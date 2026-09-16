import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:sideris/utils/exceptions.dart';

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

class MockNotificationService extends Mock implements NotificationService {}

DateTime _futureDate({int days = 1, int hour = 10}) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + days, hour);
}

NotificationRuleModel _makeOneTimeRule({DateTime? startDate, int? id}) {
  final now = DateTime.now();
  return NotificationRuleModel(
    title: "one-time",
    startDate: startDate ?? now.add(const Duration(days: 1)),
    bypassDnd: false,
    repetitionType: RepetitionType.oneTime,
    recurrenceType: null,
  )..id = id ?? 1;
}

NotificationRuleModel _makeRepetitiveRule({
  int? id,
  bool isForever = true,
  ScheduleUnit scheduleUnit = ScheduleUnit.day,
  List<int>? fixedTimesMinutes,
  List<int>? selectedDaysOfWeek,
  List<MonthDaysRepetition>? selectedMonthDays,
  ScheduleUnit? durationUnit,
  int? durationCount,
  int? scheduleEvery = 1,
}) {
  final now = DateTime.now();
  final hour = now.hour < 22 ? now.hour + 1 : 22;
  return NotificationRuleModel(
    title: "repetitive",
    startDate: now.subtract(const Duration(days: 1)),
    bypassDnd: false,
    repetitionType: RepetitionType.repetitive,
    recurrenceType: RecurrenceType.specific,
    fixedTimesMinutes: fixedTimesMinutes ?? [hour * 60],
    scheduleUnit: scheduleUnit,
    scheduleEvery: scheduleEvery,
    selectedDaysOfWeek: selectedDaysOfWeek,
    selectedMonthDays: selectedMonthDays,
    isForever: isForever,
    durationUnit: durationUnit,
    durationCount: durationCount,
  )..id = id ?? 2;
}

void main() {
  late MockNotificationsRepository mockRepo;
  late MockNotificationService mockService;
  late NotificationCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      NotificationRuleModel(
        title: "",
        startDate: DateTime(2026),
        bypassDnd: false,
        repetitionType: RepetitionType.oneTime,
      ),
    );
    registerFallbackValue(0);
  });

  setUp(() {
    mockRepo = MockNotificationsRepository();
    mockService = MockNotificationService();
    cubit = NotificationCubit(repository: mockRepo, service: mockService);

    when(
      () => mockService.refreshScheduledNotifications(),
    ).thenAnswer((_) async => []);
  });

  tearDown(() => cubit.close());

  group("loadNotifications", () {
    test("populates state from repository", () async {
      final rules = [_makeOneTimeRule(id: 10)];
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => rules);

      await cubit.loadNotifications();

      expect(cubit.state.notifications, equals(rules));
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isNull);
      verify(() => mockRepo.getAllNotifications()).called(1);
    });

    test("sets empty list when repo returns nothing", () async {
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      await cubit.loadNotifications();

      expect(cubit.state.notifications, isEmpty);
      expect(cubit.state.isLoading, isFalse);
    });

    test("sets errorMessage when repo throws", () async {
      when(
        () => mockRepo.getAllNotifications(),
      ).thenThrow(Exception("db failure"));

      await cubit.loadNotifications();

      expect(cubit.state.errorMessage, contains("db failure"));
      expect(cubit.state.isLoading, isFalse);
    });

    test("emits loading true then false", () async {
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [_makeOneTimeRule()]);

      final states = <NotificationState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.loadNotifications();
      await Future<void>.delayed(Duration.zero);

      expect(states.any((s) => s.isLoading), isTrue);
      expect(states.last.isLoading, isFalse);

      await sub.cancel();
    });

    test("skips redundant isLoading emit when already loading", () async {
      final completer = Completer<List<NotificationRuleModel>>();
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) => completer.future);

      final f1 = cubit.loadNotifications();
      await Future<void>.delayed(Duration.zero);

      final f2 = cubit.loadNotifications();

      completer.complete([]);
      await Future.wait([f1, f2]);

      expect(cubit.state.isLoading, isFalse);
    });
  });

  group("addNotification", () {
    test("success — returns fetched notification with nextTriggerAt", () async {
      final input = _makeRepetitiveRule();
      final saved = input.copyWith(nextTriggerAt: Optional(_futureDate()))
        ..id = 5;

      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => 5);
      when(
        () => mockRepo.getNotificationById(5),
      ).thenAnswer((_) async => saved);
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [saved]);

      final result = await cubit.addNotification(input);

      expect(result.id, equals(5));
      expect(result.nextTriggerAt, isNotNull);
      verify(() => mockRepo.addNotification(any())).called(1);
      verify(() => mockService.refreshScheduledNotifications()).called(1);
      verify(() => mockRepo.getAllNotifications()).called(1);
    });

    test("non-forever rule computes endDate", () async {
      final now = DateTime.now();
      final input = _makeRepetitiveRule(
        isForever: false,
        durationUnit: ScheduleUnit.week,
        durationCount: 2,
      );
      final saved = input.copyWith(
        nextTriggerAt: Optional(_futureDate()),
        endDate: Optional(now.add(const Duration(days: 14))),
      );

      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => 8);
      when(
        () => mockRepo.getNotificationById(8),
      ).thenAnswer((_) async => saved);
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [saved]);

      final result = await cubit.addNotification(input);

      expect(result.endDate, isNotNull);
      expect(result.endDate!.isAfter(now), isTrue);
    });

    test("normalizes input before inserting", () async {
      final input = NotificationRuleModel(
        title: "weird",
        startDate: DateTime.now().add(const Duration(days: 1)),
        bypassDnd: false,
        repetitionType: RepetitionType.oneTime,
        recurrenceType: RecurrenceType.specific,
        scheduleUnit: ScheduleUnit.week,
      );
      final saved = input.copyWith(nextTriggerAt: Optional(_futureDate()));

      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => 9);
      when(
        () => mockRepo.getNotificationById(9),
      ).thenAnswer((_) async => saved);
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      await cubit.addNotification(input);

      final captured =
          verify(() => mockRepo.addNotification(captureAny())).captured.single
              as NotificationRuleModel;
      expect(captured.recurrenceType, isNull);
      expect(captured.scheduleUnit, isNull);
    });

    test("throws NotificationException when nextTrigger has error", () async {
      final now = DateTime.now();
      final input = _makeOneTimeRule(
        startDate: now.subtract(const Duration(days: 1)),
      );

      expect(
        () => cubit.addNotification(input),
        throwsA(isA<NotificationException>()),
      );

      verifyNever(() => mockRepo.addNotification(any()));
    });

    test("throws when repo.insert returns -1", () async {
      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => -1);
      when(() => mockRepo.deleteNotification(any())).thenAnswer((_) async {});

      expect(
        () => cubit.addNotification(_makeRepetitiveRule()),
        throwsA(isA<NotificationException>()),
      );
    });

    test("rolls back when getById returns null after insert", () async {
      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => 11);
      when(
        () => mockRepo.getNotificationById(11),
      ).thenAnswer((_) async => null);
      when(() => mockRepo.deleteNotification(any())).thenAnswer((_) async {});

      await expectLater(
        () => cubit.addNotification(_makeRepetitiveRule()),
        throwsA(isA<NotificationNotFoundException>()),
      );

      verify(() => mockRepo.deleteNotification(11)).called(1);
    });

    test("emits error and rethrows on generic repo failure", () async {
      when(
        () => mockRepo.addNotification(any()),
      ).thenThrow(Exception("db write failed"));

      await expectLater(
        () => cubit.addNotification(_makeRepetitiveRule()),
        throwsA(isA<Exception>()),
      );

      expect(cubit.state.errorMessage, contains("db write failed"));
    });

    test("emits isLoading false in finally block", () async {
      final input = _makeRepetitiveRule();
      final saved = input.copyWith(nextTriggerAt: Optional(_futureDate()));

      when(() => mockRepo.addNotification(any())).thenAnswer((_) async => 13);
      when(
        () => mockRepo.getNotificationById(13),
      ).thenAnswer((_) async => saved);
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [saved]);

      await cubit.addNotification(input);

      expect(cubit.state.isLoading, isFalse);
    });
  });

  group("updateNotification", () {
    test("success — calls repo.update and refreshes", () async {
      final input = _makeRepetitiveRule(id: 20);
      final saved = input.copyWith(nextTriggerAt: Optional(_futureDate()));

      when(() => mockRepo.updateNotification(any())).thenAnswer((_) async {});
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [saved]);

      await cubit.updateNotification(input);

      verify(() => mockRepo.updateNotification(any())).called(1);
      verify(() => mockService.refreshScheduledNotifications()).called(1);
      expect(cubit.state.notifications, equals([saved]));
      expect(cubit.state.isLoading, isFalse);
    });

    test("recalculates endDate for non-forever rule", () async {
      final now = DateTime.now();
      final input = _makeRepetitiveRule(
        id: 21,
        isForever: false,
        durationUnit: ScheduleUnit.month,
        durationCount: 1,
      );
      final saved = input.copyWith(
        nextTriggerAt: Optional(_futureDate()),
        endDate: Optional(now.add(const Duration(days: 30))),
      );

      when(() => mockRepo.updateNotification(any())).thenAnswer((_) async {});
      when(
        () => mockRepo.getAllNotifications(),
      ).thenAnswer((_) async => [saved]);

      await cubit.updateNotification(input);

      final captured =
          verify(
                () => mockRepo.updateNotification(captureAny()),
              ).captured.single
              as NotificationRuleModel;
      expect(captured.endDate, isNotNull);
      expect(captured.endDate!.isAfter(now), isTrue);
    });

    test("repo error sets errorMessage", () async {
      when(
        () => mockRepo.updateNotification(any()),
      ).thenThrow(Exception("update failed"));

      await cubit.updateNotification(_makeRepetitiveRule(id: 22));

      expect(cubit.state.errorMessage, contains("update failed"));
    });

    test("emits isLoading false in finally block", () async {
      when(() => mockRepo.updateNotification(any())).thenAnswer((_) async {});
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      await cubit.updateNotification(_makeRepetitiveRule(id: 23));

      expect(cubit.state.isLoading, isFalse);
    });
  });

  group("deleteNotification", () {
    test("success — deletes and returns the notification", () async {
      final existing = _makeOneTimeRule(id: 30);

      when(
        () => mockRepo.getNotificationById(30),
      ).thenAnswer((_) async => existing);
      when(() => mockRepo.deleteNotification(30)).thenAnswer((_) async {});
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      final result = await cubit.deleteNotification(30);

      expect(result, equals(existing));
      verify(() => mockRepo.deleteNotification(30)).called(1);
      verify(() => mockService.refreshScheduledNotifications()).called(1);
      expect(cubit.state.notifications, isEmpty);
    });

    test("throws NotificationNotFoundException when id not found", () async {
      when(
        () => mockRepo.getNotificationById(999),
      ).thenAnswer((_) async => null);

      expect(
        () => cubit.deleteNotification(999),
        throwsA(isA<NotificationNotFoundException>()),
      );

      verifyNever(() => mockRepo.deleteNotification(any()));
    });

    test("repo delete error — emits errorMessage and rethrows", () async {
      when(
        () => mockRepo.getNotificationById(31),
      ).thenAnswer((_) async => _makeOneTimeRule(id: 31));
      when(
        () => mockRepo.deleteNotification(31),
      ).thenThrow(Exception("delete failed"));

      await expectLater(
        () => cubit.deleteNotification(31),
        throwsA(isA<Exception>()),
      );

      expect(cubit.state.errorMessage, contains("delete failed"));
    });

    test("service.refreshScheduledNotifications called after delete", () async {
      when(
        () => mockRepo.getNotificationById(32),
      ).thenAnswer((_) async => _makeOneTimeRule(id: 32));
      when(() => mockRepo.deleteNotification(32)).thenAnswer((_) async {});
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      await cubit.deleteNotification(32);

      verify(() => mockService.refreshScheduledNotifications()).called(1);
    });

    test("emits isLoading false in finally block", () async {
      when(
        () => mockRepo.getNotificationById(33),
      ).thenAnswer((_) async => _makeOneTimeRule(id: 33));
      when(() => mockRepo.deleteNotification(33)).thenAnswer((_) async {});
      when(() => mockRepo.getAllNotifications()).thenAnswer((_) async => []);

      await cubit.deleteNotification(33);

      expect(cubit.state.isLoading, isFalse);
    });
  });

  group("NotificationState", () {
    test("defaults are correct", () {
      final state = NotificationState(notifications: []);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.notifications, isEmpty);
    });

    test("copyWith preserves fields when not replaced", () {
      final state = NotificationState(
        notifications: [_makeOneTimeRule()],
        isLoading: true,
        errorMessage: "old error",
      );
      final copied = state.copyWith(isLoading: false);

      expect(copied.notifications, equals(state.notifications));
      expect(copied.isLoading, isFalse);
      expect(copied.errorMessage, equals("old error"));
    });

    test("copyWith replaces all fields when specified", () {
      final state = NotificationState(notifications: []);
      final rules = [_makeOneTimeRule(), _makeRepetitiveRule()];

      final copied = state.copyWith(
        notifications: rules,
        isLoading: true,
        errorMessage: "oops",
      );

      expect(copied.notifications, equals(rules));
      expect(copied.isLoading, isTrue);
      expect(copied.errorMessage, equals("oops"));
    });
  });
}
