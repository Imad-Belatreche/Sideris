import 'dart:developer';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/l10n/enum_labels.dart';
import 'package:sideris/l10n/l10n.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/models/settings_model.dart';
import 'package:sideris/services/permission_service.dart';
import 'package:sideris/utils/permission_dialog.dart';
import 'package:sideris/widgets/create_update_elevated_button.dart';
import 'package:sideris/widgets/dnd_switch.dart';
import 'package:sideris/widgets/notification_card.dart';
import 'package:sideris/widgets/notification_outlined_button.dart';
import 'package:sideris/widgets/notification_radio_card.dart';
import 'package:sideris/widgets/notification_textfield.dart';
import 'package:sideris/widgets/text/creation_screen_title.dart';

class CreateUpdateNotificationPage extends StatefulWidget {
  final NotificationRuleModel? updateNotification;
  const CreateUpdateNotificationPage({super.key, this.updateNotification});

  @override
  State<CreateUpdateNotificationPage> createState() =>
      _CreateUpdateNotificationPageState();
}

class _CreateUpdateNotificationPageState
    extends State<CreateUpdateNotificationPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  ColorTag? _colorTag;

  DateTime? _startDate;
  bool _isDndEnabled = false;

  RepetitionType _repetitionType = RepetitionType.oneTime;

  DailyOption? _dailyOption = DailyOption.allDays;

  ScheduleUnit? _scheduleUnit = ScheduleUnit.daily;
  final TextEditingController _scheduleEveryController =
      TextEditingController();

  List<int>? _selectedDaysOfWeek;

  List<int>? _selectedDaysOfMonth;
  bool? _isFirstOfMonthSelected;

  List<MonthDaysRepetition>? _selectedDaysOfYear;
  int? _activeSelectedMonth;

  RecurrenceType? _recurrenceType;
  List<TimeOfDay>? _fixedSpecificTimes;

  final TextEditingController _randomTimesController = TextEditingController();
  TimeOfDay? _randomWindowStart;
  TimeOfDay? _randomWindowEnd;

  final TextEditingController _intervalTimesController =
      TextEditingController();
  IntervalUnit? _intervalUnit;
  TimeOfDay? _intervalWindowStart;
  TimeOfDay? _intervalWindowEnd;

  DurationOption? _durationOption;

  ScheduleUnit? _durationUnit;
  final TextEditingController _durationCountController =
      TextEditingController();

  final TextEditingController _totalTimesController = TextEditingController();

  DateTime? _endDate;

  late final SettingsModel settings;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _scheduleEveryController.dispose();
    _randomTimesController.dispose();
    _intervalTimesController.dispose();
    _durationCountController.dispose();
    _totalTimesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.updateNotification != null) {
      final toUpdate = widget.updateNotification!;
      _titleController.text = toUpdate.title;
      _descriptionController.text = toUpdate.content ?? "";
      _colorTag = toUpdate.colorTag;

      _startDate = toUpdate.startDate;
      _isDndEnabled = toUpdate.bypassDnd;

      _repetitionType = toUpdate.repetitionType;

      _dailyOption = toUpdate.dailyOption;

      _scheduleUnit = toUpdate.scheduleUnit;
      _scheduleEveryController.text = toUpdate.scheduleEvery?.toString() ?? "";

      _selectedDaysOfWeek = toUpdate.selectedDaysOfWeek;
      _selectedDaysOfMonth =
          toUpdate.selectedMonthDays != null &&
              toUpdate.selectedMonthDays!.length == 1 &&
              toUpdate.selectedMonthDays![0].selectedMonth == null
          ? toUpdate.selectedMonthDays![0].selectedDaysOfMonth
          : null;

      _selectedDaysOfYear =
          toUpdate.selectedMonthDays != null &&
              toUpdate.selectedMonthDays!.length == 1 &&
              toUpdate.selectedMonthDays![0].selectedMonth == null
          ? null
          : toUpdate.selectedMonthDays;

      _activeSelectedMonth = _selectedDaysOfYear != null
          ? _selectedDaysOfYear![0].selectedMonth
          : null;
      if (_selectedDaysOfMonth != null) {
        _isFirstOfMonthSelected = _selectedDaysOfMonth!.length == 1
            ? _selectedDaysOfMonth!.first == 1
                  ? true
                  : _selectedDaysOfMonth!.first == 31
                  ? false
                  : null
            : null;
      }

      _recurrenceType = toUpdate.recurrenceType;
      _fixedSpecificTimes = toUpdate.fixedTimes;

      _randomTimesController.text = toUpdate.randomCount?.toString() ?? "";
      _randomWindowStart = toUpdate.randomWindowStart;
      _randomWindowEnd = toUpdate.randomWindowEnd;

      _intervalTimesController.text = toUpdate.intervalEvery?.toString() ?? "";
      _intervalWindowStart = toUpdate.intervalWindowStart;
      _intervalWindowEnd = toUpdate.intervalWindowEnd;
      _intervalUnit = toUpdate.intervalUnit;

      _durationUnit = toUpdate.durationUnit;
      _durationCountController.text = toUpdate.durationCount?.toString() ?? "";

      _durationOption = toUpdate.isForever
          ? DurationOption.forever
          : toUpdate.totalOccurrences != null
          ? DurationOption.occurrences
          : toUpdate.durationCount != null
          ? DurationOption.duration
          : toUpdate.durationCount == null && toUpdate.endDate != null
          ? DurationOption.untilDate
          : null;

      _totalTimesController.text = toUpdate.totalOccurrences?.toString() ?? "";

      _endDate = toUpdate.endDate;
      return;
    }

    settings = context.read<SettingsCubit>().state.settings;

    _titleController.text = settings.defaultTitle;
    _descriptionController.text = settings.defaultDescription;
    _isDndEnabled = settings.bypassDND;
    _recurrenceType = settings.recurrenceType;
    _repetitionType = settings.repetitionType;
    _colorTag = settings.colorTag;
    _scheduleUnit = settings.scheduleUnit;
    _durationOption = settings.durationOption;
  }

  final GlobalKey<AnimatedListState> _fixedTimesListKey =
      GlobalKey<AnimatedListState>();

  NotificationRuleModel? buildNotificationFromForm() {
    late NotificationRuleModel notification;

    final title = _titleController.text.trim();
    if (title.isEmpty) {
      showError(context.l10n.validationTitleEmpty);
      return null;
    }

    String? description = _descriptionController.text.trim();
    if (description.isEmpty) {
      description = null;
    }

    if (_startDate == null) {
      showError(context.l10n.validationStartDateRequired);
      return null;
    }

    if (_repetitionType == RepetitionType.oneTime) {
      if (_startDate != null && _startDate!.isBefore(DateTime.now())) {
        showError(context.l10n.validationDateInPast);
        return null;
      }

      notification = NotificationRuleModel(
        title: title,
        content: description,
        startDate: _startDate!,
        repetitionType: _repetitionType,
        colorTag: _colorTag,
        bypassDnd: _isDndEnabled,
      );
    } else if (_repetitionType == RepetitionType.repetitive) {
      if (_recurrenceType == null) {
        showError(context.l10n.validationDailyTimingRequired);
        return null;
      }

      int? scheduleEvery = int.tryParse(_scheduleEveryController.text.trim());

      if (_scheduleUnit == ScheduleUnit.daily) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError(context.l10n.validationRepeatEveryInvalid);
          return null;
        }

        if (_dailyOption == DailyOption.weekdays ||
            _dailyOption == DailyOption.weekends) {
          scheduleEvery = 1;
        }
      }

      if (_scheduleUnit == ScheduleUnit.weekly) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError(context.l10n.validationRepeatEveryInvalid);
          return null;
        }

        if (_selectedDaysOfWeek == null || _selectedDaysOfWeek!.isEmpty) {
          showError(context.l10n.validationSelectDayOfWeek);
          return null;
        }
      }

      if (_scheduleUnit == ScheduleUnit.monthly) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError(context.l10n.validationRepeatEveryInvalid);
          return null;
        }

        if (_selectedDaysOfMonth == null || _selectedDaysOfMonth!.isEmpty) {
          showError(context.l10n.validationSelectDayOfMonth);
          return null;
        }
      }

      if (_scheduleUnit == ScheduleUnit.yearly) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError(context.l10n.validationRepeatEveryInvalid);

          return null;
        }

        if (_selectedDaysOfYear == null ||
            _selectedDaysOfYear!.isEmpty ||
            _selectedDaysOfYear!.any(
              (selection) =>
                  selection.selectedMonth == null ||
                  selection.selectedDaysOfMonth == null ||
                  selection.selectedDaysOfMonth!.isEmpty,
            )) {
          showError(context.l10n.validationSelectMonthAndDay);
          return null;
        }
      }
      final DailyOption? dailyOption = _scheduleUnit == ScheduleUnit.daily
          ? _dailyOption
          : null;

      final List<int>? selectedDaysOfWeek = _scheduleUnit == ScheduleUnit.weekly
          ? _selectedDaysOfWeek
          : _scheduleUnit == ScheduleUnit.daily &&
                _dailyOption == DailyOption.weekdays
          ? [1, 2, 3, 4, 5]
          : _scheduleUnit == ScheduleUnit.daily &&
                _dailyOption == DailyOption.weekends
          ? [6, 7]
          : null;

      final List<MonthDaysRepetition>? selectedMonthDays =
          _scheduleUnit == ScheduleUnit.yearly
          ? _selectedDaysOfYear
          : _scheduleUnit == ScheduleUnit.monthly
          ? [
              MonthDaysRepetition(
                selectedMonth: null,
                selectedDaysOfMonth: _selectedDaysOfMonth,
              ),
            ]
          : null;

      int? randomCount;
      int? intervalCount;
      if (_recurrenceType == RecurrenceType.specific) {
        if (_fixedSpecificTimes == null || _fixedSpecificTimes!.isEmpty) {
          showError(context.l10n.validationAtLeastOneTime);
          return null;
        }
        // Show error when duplicated times
        if (_fixedSpecificTimes!.length !=
            _fixedSpecificTimes!.toSet().length) {
          showError(context.l10n.validationNoDuplicateTimes);
          return null;
        }
      } else if (_recurrenceType == RecurrenceType.random) {
        if (_randomTimesController.text.trim().isEmpty) {
          showError(context.l10n.validationHowManyTimesRequired);
          return null;
        }
        randomCount = int.tryParse(_randomTimesController.text.trim());
        if (randomCount == null) {
          showError(context.l10n.validationHowManyTimesNotNumber);
          return null;
        }

        if (randomCount <= 0) {
          showError(context.l10n.validationRandomCountPositive);
          return null;
        }

        if (_randomWindowStart == null || _randomWindowEnd == null) {
          showError(context.l10n.validationRandomWindowRequired);
          return null;
        }

        final startMinutes =
            _randomWindowStart!.hour * 60 + _randomWindowStart!.minute;
        final endMinutes =
            _randomWindowEnd!.hour * 60 + _randomWindowEnd!.minute;

        if (startMinutes >= endMinutes) {
          showError(context.l10n.validationRandomWindowOrder);
          return null;
        }

        final availableMinutes = endMinutes - startMinutes + 1;
        if (randomCount > availableMinutes) {
          showError(context.l10n.validationRandomCountExceedsWindow);
          return null;
        }
      } else {
        if (_intervalTimesController.text.trim().isEmpty) {
          showError(context.l10n.validationEveryRequired);
          return null;
        }
        intervalCount = int.tryParse(_intervalTimesController.text.trim());

        if (intervalCount == null || intervalCount <= 0) {
          showError(context.l10n.validationIntervalPositive);
          return null;
        }

        if (_intervalUnit == null) {
          showError(context.l10n.validationIntervalUnitRequired);
          return null;
        }

        if (_intervalWindowStart == null || _intervalWindowEnd == null) {
          showError(context.l10n.validationIntervalWindowRequired);
          return null;
        }

        final startMinutes =
            _intervalWindowStart!.hour * 60 + _intervalWindowStart!.minute;
        final endMinutes =
            _intervalWindowEnd!.hour * 60 + _intervalWindowEnd!.minute;

        if (startMinutes >= endMinutes) {
          showError(context.l10n.validationIntervalWindowOrder);
          return null;
        }
      }

      final fixedTimes = [...?_fixedSpecificTimes]
        ..sort((first, second) {
          final firstMinutes = first.hour * 60 + first.minute;
          final secondMinutes = second.hour * 60 + second.minute;
          return firstMinutes.compareTo(secondMinutes);
        });

      if (_durationOption == null) {
        showError(context.l10n.validationDurationTypeRequired);
        return null;
      }

      if (_durationOption == DurationOption.duration && _durationUnit == null) {
        showError(context.l10n.validationDurationUnitRequired);
        return null;
      }

      final int? parsedDurationCount = int.tryParse(
        _durationCountController.text.trim(),
      );

      final int? parsedTotalTimes = int.tryParse(
        _totalTimesController.text.trim(),
      );

      if (_durationOption == DurationOption.duration &&
          (parsedDurationCount == null || parsedDurationCount <= 0)) {
        showError(context.l10n.validationDurationInvalid);
        return null;
      }

      if (_durationOption == DurationOption.occurrences &&
          (parsedTotalTimes == null || parsedTotalTimes <= 0)) {
        showError(context.l10n.validationOccurrencesInvalid);
        return null;
      }

      if (_durationOption == DurationOption.untilDate && _endDate == null) {
        showError(context.l10n.validationEndDateRequired);
        return null;
      }

      final bool isForever = _durationOption == DurationOption.forever;

      final durationUnit = _durationOption == DurationOption.duration
          ? _durationUnit
          : null;

      final durationCount = _durationOption == DurationOption.duration
          ? parsedDurationCount
          : null;

      final DateTime? endDate = _durationOption == DurationOption.untilDate
          ? _endDate
          : null;

      final int? totalOccurrences =
          _durationOption == DurationOption.occurrences
          ? parsedTotalTimes
          : null;

      notification = NotificationRuleModel(
        title: title,
        content: description,
        colorTag: _colorTag,
        repetitionType: _repetitionType,
        startDate: _startDate!,
        bypassDnd: _isDndEnabled,
        scheduleUnit: _scheduleUnit,
        dailyOption: dailyOption,
        scheduleEvery: scheduleEvery,
        selectedDaysOfWeek: selectedDaysOfWeek,
        selectedMonthDays: selectedMonthDays,
        recurrenceType: _repetitionType == RepetitionType.repetitive
            ? _recurrenceType
            : null,
        randomCount: _recurrenceType == RecurrenceType.random
            ? randomCount
            : null,
        intervalEvery: _recurrenceType == RecurrenceType.interval
            ? intervalCount
            : null,

        intervalUnit: _recurrenceType == RecurrenceType.interval
            ? _intervalUnit
            : null,
        isForever: isForever,
        durationUnit: durationUnit,
        durationCount: durationCount,
        endDate: endDate,
        totalOccurrences: totalOccurrences,
      );
      notification = notification.copyWith(
        fixedTimes: Optional(
          _recurrenceType == RecurrenceType.specific ? fixedTimes : null,
        ),
        intervalWindowStart: Optional(
          _recurrenceType == RecurrenceType.interval
              ? _intervalWindowStart
              : null,
        ),
        intervalWindowEnd: Optional(
          _recurrenceType == RecurrenceType.interval
              ? _intervalWindowEnd
              : null,
        ),

        randomWindowStart: Optional(
          _recurrenceType == RecurrenceType.random ? _randomWindowStart : null,
        ),
        randomWindowEnd: Optional(
          _recurrenceType == RecurrenceType.random ? _randomWindowEnd : null,
        ),
      );
    }

    return notification;
  }

  @override
  Widget build(BuildContext context) {
    final notificationCubit = context.read<NotificationCubit>();
    final font = appFontOf(context);

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.updateNotification == null
              ? context.l10n.notificationPageCreateTitle
              : context.l10n.notificationPageUpdateTitle,
          style: font(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreationScreenTitle(title: context.l10n.fieldTitle),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _titleController,
                  hintText: context.l10n.notificationPageTitleHint,
                  maxLines: 1,
                ),

                SizedBox(height: 16),

                CreationScreenTitle(
                  title: context.l10n.notificationPageContentTitle,
                ),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _descriptionController,
                  hintText: context.l10n.notificationPageContentHint,
                  maxLines: 3,
                  minLines: 3,
                ),

                SizedBox(height: 16),

                CreationScreenTitle(
                  title: context.l10n.notificationPageColorTag,
                ),
                SizedBox(height: 5),
                buildColorTagSelector(),

                CreationScreenTitle(
                  title: context.l10n.notificationPageRepetitionType,
                ),
                SizedBox(height: 5),
                buildRepetitionTypeSelector(),

                SizedBox(height: 16),

                AnimatedSwitcher(
                  duration: 200.ms,
                  child: _repetitionType == RepetitionType.oneTime
                      ? buildOneTime(key: "oneTime")
                      : buildRepetitive(key: "repetitive"),
                ),

                SizedBox(height: 16),

                CreationScreenTitle(
                  title: context.l10n.notificationPageOptions,
                ),
                SizedBox(height: 5),
                buildOptions(),

                SizedBox(height: 30),

                Align(
                  alignment: Alignment.center,
                  child: CreateUpdateElevatedButton(
                    icon: Icons.check,
                    label: widget.updateNotification == null
                        ? context.l10n.actionCreateNotification
                        : context.l10n.actionUpdateNotification,
                    onPressed: () async {
                      final l10n = context.l10n;
                      try {
                        final permissionStatus =
                            await ensureNotificationPermission(context);
                        if (permissionStatus == null ||
                            !permissionStatus.isNotificationPermissionGranted ||
                            !permissionStatus.isExactAlarmPermissionGranted ||
                            !permissionStatus.isDndAccessPermissionGranted) {
                          showError(l10n.validationPermissionsNotGranted);
                          return;
                        }

                        final notification = buildNotificationFromForm();
                        if (notification == null) {
                          return;
                        }

                        if (widget.updateNotification == null) {
                          await notificationCubit.addNotification(notification);
                        } else {
                          notification.id = widget.updateNotification!.id;
                          notification.createdAt =
                              widget.updateNotification!.createdAt;

                          await notificationCubit.updateNotification(
                            notification,
                          );
                        }

                        log(" Notification added: ${notification.toString()}");
                        //TODO: Make the snackBar look better or pop the page entirely
                        if (!context.mounted) return;
                        if (widget.updateNotification == null) {
                          showError(context.l10n.notificationPageSaved);
                        } else {
                          showError(context.l10n.notificationPageUpdated);
                        }
                      } catch (e) {
                        log("Error while creating notification: $e");
                        if (!context.mounted) return;
                        showError(
                          context.l10n.notificationPageSaveError(e.toString()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //TODO: Keyboard always pops up when selected date or time.

  Widget buildColorTagSelector() {
    ///TODO: Better to optionally give user a custom to name or custom icon for each color in the settings
    /// Green for sports, Yellow for medicine ....etc
    /// then show the icon or the first two letters inside each color
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (var value in ColorTag.values)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _colorTag = value;
                  });
                },
                child: AnimatedScale(
                  scale: _colorTag == value ? 1.14 : 1.0,
                  duration: 200.ms,
                  curve: Curves.easeOut,
                  child: AnimatedContainer(
                    duration: 200.ms,
                    curve: Curves.easeOut,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      boxShadow: value == _colorTag
                          ? [
                              BoxShadow(
                                color: value.value,
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                      shape: BoxShape.circle,
                      border: _colorTag == value
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                      color: value.value,
                    ),
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _colorTag = null;
                });
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: Icon(
                  Icons.close_outlined,
                  color: Colors.white24,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRepetitionTypeSelector() {
    return Row(
      spacing: 10,
      children: [
        NotificationOutlinedButton(
          label: context.l10n.repetitionTypeOneTime,
          isSelected: _repetitionType == RepetitionType.oneTime,
          onPressed: () {
            setState(() {
              if (_startDate != null) {
                _startDate = null;
              }
              _repetitionType = RepetitionType.oneTime;
            });
          },
        ),

        NotificationOutlinedButton(
          label: context.l10n.repetitionTypeRepetitive,
          isSelected: _repetitionType == RepetitionType.repetitive,
          onPressed: () {
            setState(() {
              if (_startDate != null) {
                _startDate = null;
              }
              _repetitionType = RepetitionType.repetitive;
              if (_scheduleEveryController.text.isEmpty) {
                _scheduleEveryController.text = "1";
              }
              _startDate = DateTime.now();
              _recurrenceType = RecurrenceType.specific;
              _fixedSpecificTimes = [TimeOfDay(hour: 9, minute: 0)];

              _durationOption = DurationOption.forever;
            });
          },
        ),
      ],
    );
  }

  Widget buildOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DndSwitch(
          isSelected: _isDndEnabled,
          value: _isDndEnabled,
          onChanged: (value) {
            setState(() {
              _isDndEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildOneTime({required String key}) {
    final locale = Localizations.localeOf(context).toString();

    return Column(
      key: ValueKey<String>(key),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreationScreenTitle(title: context.l10n.notificationPageDateAndTime),

        ///TODO: Maybe using a single button for whole date?
        /// First shows the date picker then the time picker
        NotificationOutlinedButton(
          label: _startDate != null
              ? DateFormat.yMMMd(locale).format(_startDate!)
              : context.l10n.actionSelectDate,
          isExpanded: true,
          isSelected: _startDate != null,
          icon: const Icon(
            Icons.calendar_today,
            color: Colors.indigoAccent,
            size: 20,
          ),
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: _startDate ?? DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
            );

            if (pickedDate != null) {
              setState(() {
                _startDate = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  _startDate?.hour ?? 0,
                  _startDate?.minute ?? 0,
                );
              });
            }
          },
        ),
        SizedBox(height: 10),
        NotificationOutlinedButton(
          label:
              (_startDate != null &&
                  (_startDate!.hour != 0 || _startDate!.minute != 0))
              ? DateFormat.jm(locale).format(_startDate!)
              : context.l10n.actionSelectTime,
          isExpanded: true,
          isSelected:
              _startDate != null &&
              (_startDate!.hour != 0 || _startDate!.minute != 0),
          icon: const Icon(
            Icons.access_time,
            color: Colors.indigoAccent,
            size: 20,
          ),
          onPressed: () async {
            if (_startDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.notificationPageSelectDateFirstSnackBar,
                  ),
                ),
              );
              return;
            }

            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: TimeOfDay.now().hour,
                minute: TimeOfDay.now().minute + 1,
              ),
            );
            if (pickedTime != null) {
              setState(() {
                _startDate = DateTime(
                  _startDate!.year,
                  _startDate!.month,
                  _startDate!.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
              });
            }
          },
        ),
      ],
    );
  }

  Widget buildRepetitive({required String key}) {
    final font = appFontOf(context);
    final locale = Localizations.localeOf(context).toString();

    return Column(
      key: ValueKey<String>(key),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreationScreenTitle(title: context.l10n.notificationPageSchedule),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              NotificationOutlinedButton(
                label: ScheduleUnit.daily.shortLabel(context.l10n),
                isSelected: _scheduleUnit == ScheduleUnit.daily,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.daily;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: ScheduleUnit.weekly.shortLabel(context.l10n),
                isSelected: _scheduleUnit == ScheduleUnit.weekly,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.weekly;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: ScheduleUnit.monthly.shortLabel(context.l10n),
                isSelected: _scheduleUnit == ScheduleUnit.monthly,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.monthly;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: ScheduleUnit.yearly.shortLabel(context.l10n),
                isSelected: _scheduleUnit == ScheduleUnit.yearly,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.yearly;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5),

        NotificationCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.play_arrow, color: Colors.white38, size: 18),
                  Text(
                    context.l10n.actionStart,
                    style: font(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 10,
                children: [
                  Expanded(
                    child: NotificationOutlinedButton(
                      label: context.l10n.notificationPageStartFromNow,
                      isExpanded: true,
                      isSelected:
                          _startDate != null &&
                          _startDate!.isBefore(DateTime.now()),

                      centerText: true,
                      icon: null,
                      onPressed: () {
                        setState(() {
                          _startDate = DateTime.now();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: NotificationOutlinedButton(
                      label:
                          _startDate != null &&
                              _startDate!.isAfter(DateTime.now())
                          ? DateFormat.yMd(locale).add_jm().format(_startDate!)
                          : context.l10n.notificationPagePickDateAndTime,
                      isExpanded: true,
                      isSelected:
                          _startDate != null &&
                          _startDate!.isAfter(DateTime.now()),
                      centerText: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      icon: null,
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: _startDate ?? DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 100),
                          ),
                        );

                        if (pickedDate != null) {
                          if (!mounted) return;

                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: TimeOfDay.now().hour,
                              minute: TimeOfDay.now().minute + 1,
                            ),
                          );

                          if (pickedTime != null) {
                            final pickedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            if (pickedDateTime.isAfter(DateTime.now())) {
                              setState(() {
                                _startDate = pickedDateTime;
                              });
                            } else {
                              if (!mounted) return;
                              showError(context.l10n.validationDateInPast);
                            }
                          } else {
                            if (!mounted) return;
                            showError(
                              context
                                  .l10n
                                  .notificationPageTimeSelectionCanceled,
                            );
                          }
                        } else {
                          if (!mounted) return;
                          showError(
                            context.l10n.notificationPageDateSelectionCanceled,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 5),

        AnimatedSwitcher(
          duration: 250.ms,
          reverseDuration: 250.ms,
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [...previousChildren, ?currentChild],
            );
          },
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child:
              (_scheduleUnit == ScheduleUnit.daily &&
                  (_dailyOption == DailyOption.weekdays ||
                      _dailyOption == DailyOption.weekends))
              ? SizedBox(height: 0, key: ValueKey<String>("empty"))
              : NotificationCard(
                  key: ValueKey<String>("repeatEvery"),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        context.l10n.notificationPageRepeatEvery,
                        style: font(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),

                      NotificationTextfield(
                        controller: _scheduleEveryController,
                        hintText: "1",
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        isExpanded: false,
                        isDense: true,
                      ),

                      AnimatedSwitcher(
                        duration: 250.ms,
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            fit: StackFit.passthrough,
                            children: [...previousChildren, ?currentChild],
                          );
                        },
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          key: ValueKey<String>(_scheduleUnit!.name),
                          _scheduleUnit!.label(context.l10n),
                          style: font(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        SizedBox(height: 5),
        AnimatedSwitcher(
          duration: 350.ms,
          reverseDuration: 350.ms,
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [...previousChildren, ?currentChild],
            );
          },
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: switch (_scheduleUnit!) {
            ScheduleUnit.daily => KeyedSubtree(
              key: const ValueKey('schedule-day'),
              child: buildDayOptions(),
            ),
            ScheduleUnit.weekly => KeyedSubtree(
              key: const ValueKey('schedule-week'),
              child: buildWeekOptions(),
            ),
            ScheduleUnit.monthly => KeyedSubtree(
              key: const ValueKey('schedule-month'),
              child: buildMonthOptions(),
            ),
            ScheduleUnit.yearly => KeyedSubtree(
              key: const ValueKey('schedule-year'),
              child: buildYearOptions(),
            ),
          },
        ),

        SizedBox(height: 16),
        CreationScreenTitle(title: context.l10n.notificationPageDailyTiming),
        SizedBox(height: 5),

        buildDailyTiming(),

        SizedBox(height: 16),
        CreationScreenTitle(title: context.l10n.notificationPageDuration),
        SizedBox(height: 5),

        buildDurationOptions(),
      ],
    );
  }

  Widget buildDayOptions() {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NotificationOutlinedButton(
          label: DailyOption.allDays.label(context.l10n),
          isExpanded: false,
          isSelected: _dailyOption == DailyOption.allDays,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _dailyOption = DailyOption.allDays;
            });
          },
        ),
        NotificationOutlinedButton(
          label: DailyOption.weekdays.label(context.l10n),
          isExpanded: false,
          isSelected: _dailyOption == DailyOption.weekdays,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _dailyOption = DailyOption.weekdays;
            });
          },
        ),
        NotificationOutlinedButton(
          label: DailyOption.weekends.label(context.l10n),
          isExpanded: false,
          isSelected: _dailyOption == DailyOption.weekends,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _dailyOption = DailyOption.weekends;
            });
          },
        ),
      ],
    );
  }

  Widget buildWeekOptions() {
    final locale = Localizations.localeOf(context).toString();

    // Monday-first, localized narrow weekday names.
    final daysOfWeek = <int>[1, 2, 3, 4, 5, 6, 7].map((day) {
      final date = DateTime(2024, 1, day);
      return (index: day, label: DateFormat.E(locale).format(date));
    }).toList();

    final selectedDaysOfWeek = _selectedDaysOfWeek ??= <int>[];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 0,
        children: [
          for (final day in daysOfWeek)
            NotificationOutlinedButton(
              label: day.label,
              isExpanded: false,
              isSelected: selectedDaysOfWeek.contains(day.index),
              centerText: true,
              isRounded: true,
              minimumSize: Size(70, 70),
              icon: null,
              onPressed: () {
                setState(() {
                  if (selectedDaysOfWeek.contains(day.index)) {
                    selectedDaysOfWeek.remove(day.index);
                  } else {
                    selectedDaysOfWeek.add(day.index);
                  }

                  _selectedDaysOfWeek = selectedDaysOfWeek;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget buildMonthOptions() {
    final font = appFontOf(context);
    final selectedDaysOfMonth = _selectedDaysOfMonth ??= <int>[];
    return NotificationCard(
      child: Column(
        children: [
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NotificationOutlinedButton(
                label: context.l10n.notificationPageFirstDayOfMonth,
                isExpanded: false,
                isSelected:
                    _isFirstOfMonthSelected != null &&
                    _isFirstOfMonthSelected == true,
                centerText: true,
                icon: null,
                onPressed: () {
                  setState(() {
                    if (_isFirstOfMonthSelected == true) {
                      _isFirstOfMonthSelected = null;
                      selectedDaysOfMonth.clear();
                      _selectedDaysOfMonth = null;
                      return;
                    }
                    _isFirstOfMonthSelected = true;

                    selectedDaysOfMonth.clear();
                    selectedDaysOfMonth.add(1);

                    _selectedDaysOfMonth = selectedDaysOfMonth;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: context.l10n.notificationPageLastDayOfMonth,
                isExpanded: false,
                isSelected:
                    _isFirstOfMonthSelected != null &&
                    _isFirstOfMonthSelected == false,
                centerText: true,
                icon: null,
                onPressed: () {
                  setState(() {
                    if (_isFirstOfMonthSelected == false) {
                      _isFirstOfMonthSelected = null;
                      selectedDaysOfMonth.clear();
                      _selectedDaysOfMonth = null;
                      return;
                    }
                    _isFirstOfMonthSelected = false;

                    //TODO: Handle last day of month selection cuz not every month end with 31, it maybe 30, 28, 29 ...etc
                    selectedDaysOfMonth.clear();
                    selectedDaysOfMonth.add(31);

                    _selectedDaysOfMonth = selectedDaysOfMonth;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              for (var day = 1; day <= 31; day++)
                NotificationOutlinedButton(
                  label: day.toString(),
                  isExpanded: false,
                  isSelected: selectedDaysOfMonth.contains(day),
                  centerText: true,
                  isRounded: true,
                  icon: null,
                  onPressed: () {
                    setState(() {
                      if (selectedDaysOfMonth.contains(day)) {
                        selectedDaysOfMonth.remove(day);
                      } else {
                        selectedDaysOfMonth.add(day);
                      }
                      if (selectedDaysOfMonth.length == 1 &&
                          selectedDaysOfMonth.contains(1)) {
                        _isFirstOfMonthSelected = true;
                      } else if (selectedDaysOfMonth.length == 1 &&
                          selectedDaysOfMonth.contains(31)) {
                        _isFirstOfMonthSelected = false;
                      } else {
                        _isFirstOfMonthSelected = null;
                      }
                      _selectedDaysOfMonth = selectedDaysOfMonth;
                    });
                  },
                ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            context.l10n.notificationPageMonthlyDaysNotice,
            style: font(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildYearOptions() {
    final font = appFontOf(context);
    final locale = Localizations.localeOf(context).toString();
    final monthNumbers = List.generate(12, (int index) => index + 1);

    final months = [
      for (var month in monthNumbers)
        DateFormat.MMM(locale).format(DateTime(2026, month)),
    ];

    final daysInActiveMonth = _activeSelectedMonth != null
        ? DateTime(2026, _activeSelectedMonth! + 1, 0).day
        : 0;

    final selectedDaysOfYear = _selectedDaysOfYear ??= <MonthDaysRepetition>[];

    return SizedBox(
      width: double.infinity,
      child: NotificationCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.notificationPageMonths,
              style: font(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 8,
              children: [
                for (var index = 0; index < monthNumbers.length; index++)
                  NotificationOutlinedButton(
                    label: months[index],
                    centerText: true,
                    isSelected:
                        _activeSelectedMonth == monthNumbers[index] ||
                        selectedDaysOfYear.any(
                          (selection) =>
                              selection.selectedMonth == monthNumbers[index] &&
                              selection.selectedDaysOfMonth != null &&
                              selection.selectedDaysOfMonth!.isNotEmpty,
                        ),
                    isCurrentlySelected:
                        _activeSelectedMonth == monthNumbers[index],
                    minimumSize: const Size(20, 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    onPressed: () {
                      final month = monthNumbers[index];

                      setState(() {
                        _activeSelectedMonth = month;
                      });

                      log(
                        "The whole selected days of year: ${_selectedDaysOfYear.toString()}",
                      );
                    },
                  ),
              ],
            ),
            SizedBox(height: 10),
            AnimatedSwitcher(
              duration: 350.ms,
              reverseDuration: 350.ms,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [...previousChildren, ?currentChild],
                );
              },
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _activeSelectedMonth != null
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.notificationPageDays,
                          style: font(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NotificationOutlinedButton(
                              label:
                                  context.l10n.notificationPageFirstDayOfMonth,
                              isExpanded: false,
                              isSelected: selectedDaysOfYear.any(
                                (selection) =>
                                    selection.selectedMonth ==
                                        _activeSelectedMonth &&
                                    selection.selectedDaysOfMonth?.contains(
                                          1,
                                        ) ==
                                        true,
                              ),
                              centerText: true,
                              icon: null,
                              onPressed: () {
                                setState(() {
                                  final selectedDays =
                                      _selectedDaysForActiveMonth();
                                  if (selectedDays.contains(1)) {
                                    selectedDays.remove(1);
                                  } else {
                                    selectedDays.add(1);
                                  }
                                });
                              },
                            ),
                            NotificationOutlinedButton(
                              label:
                                  context.l10n.notificationPageLastDayOfMonth,
                              isExpanded: false,
                              isSelected: selectedDaysOfYear.any(
                                (selection) =>
                                    selection.selectedMonth ==
                                        _activeSelectedMonth &&
                                    selection.selectedDaysOfMonth?.contains(
                                          daysInActiveMonth,
                                        ) ==
                                        true,
                              ),
                              centerText: true,
                              icon: null,
                              onPressed: () {
                                setState(() {
                                  final selectedDays =
                                      _selectedDaysForActiveMonth();
                                  if (selectedDays.contains(
                                    daysInActiveMonth,
                                  )) {
                                    selectedDays.remove(daysInActiveMonth);
                                  } else {
                                    selectedDays.add(daysInActiveMonth);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              for (var day = 1; day <= daysInActiveMonth; day++)
                                NotificationOutlinedButton(
                                  label: day.toString(),
                                  centerText: true,
                                  isRounded: true,
                                  isSelected: selectedDaysOfYear.any(
                                    (element) =>
                                        element.selectedMonth ==
                                            _activeSelectedMonth &&
                                        element.selectedDaysOfMonth != null &&
                                        element.selectedDaysOfMonth!.contains(
                                          day,
                                        ),
                                  ),
                                  minimumSize: const Size(20, 20),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (!selectedDaysOfYear.any(
                                        (element) =>
                                            element.selectedMonth ==
                                            _activeSelectedMonth,
                                      )) {
                                        selectedDaysOfYear.add(
                                          MonthDaysRepetition(
                                            selectedMonth: _activeSelectedMonth,
                                            selectedDaysOfMonth: [],
                                          ),
                                        );
                                      }

                                      final selectedDays =
                                          selectedDaysOfYear
                                                  .firstWhere(
                                                    (element) =>
                                                        element.selectedMonth ==
                                                        _activeSelectedMonth,
                                                  )
                                                  .selectedDaysOfMonth ??=
                                              <int>[];

                                      if (selectedDays.contains(day)) {
                                        selectedDays.remove(day);
                                      } else {
                                        selectedDays.add(day);
                                      }
                                      _selectedDaysOfYear = selectedDaysOfYear;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDailyTiming() {
    final font = appFontOf(context);

    return RadioGroup<RecurrenceType>(
      groupValue: _recurrenceType,
      onChanged: (RecurrenceType? value) {
        if (value == null) return;

        setState(() {
          _recurrenceType = value;
        });
      },
      child: Column(
        children: [
          NotificationRadioCard(
            selectedType: RecurrenceType.specific,
            label: RecurrenceType.specific.label(context.l10n),
            icon: Icons.access_time,
            isSelected: _recurrenceType == RecurrenceType.specific,
            onTap: () {
              setState(() {
                _recurrenceType = RecurrenceType.specific;
              });
            },
            child: Column(
              spacing: 10,
              children: [
                if (_fixedSpecificTimes != null &&
                    _fixedSpecificTimes!.isNotEmpty)
                  AnimatedList(
                    key: _fixedTimesListKey,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    initialItemCount: _fixedSpecificTimes?.length ?? 0,
                    itemBuilder: (context, index, animation) {
                      final time = _fixedSpecificTimes![index];

                      return _buildFixedTimeItem(
                        time,
                        animation,
                        showDelete: _fixedSpecificTimes!.length > 1,
                        onDelete: () {
                          final removedTime = _fixedSpecificTimes!.removeAt(
                            index,
                          );

                          _fixedTimesListKey.currentState?.removeItem(index, (
                            context,
                            animation,
                          ) {
                            return _buildFixedTimeItem(
                              removedTime,
                              animation,
                              showDelete: false,
                            );
                          }, duration: const Duration(milliseconds: 250));

                          setState(() {});
                        },
                      );
                    },
                  ),

                NotificationOutlinedButton(
                  label: context.l10n.actionAddTime,
                  labelStyle: font(
                    fontSize: 15,
                    color: Colors.blueAccent.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  isExpanded: true,
                  isSelected: false,
                  centerText: true,
                  icon: Icon(
                    Icons.add,
                    color: Colors.blueAccent.shade400,
                    size: 20,
                  ),
                  onPressed: () {
                    final times = _fixedSpecificTimes ??= <TimeOfDay>[];

                    TimeOfDay? nextTime;
                    for (var minute = 0; minute < 24 * 60; minute++) {
                      final candidate = TimeOfDay(
                        hour: minute ~/ 60,
                        minute: minute % 60,
                      );

                      if (!times.contains(candidate)) {
                        nextTime = candidate;
                        break;
                      }
                    }

                    if (nextTime == null) {
                      showError(
                        context.l10n.notificationPageAllTimeSlotsSelected,
                      );
                      return;
                    }

                    setState(() {
                      times.add(nextTime!);
                    });

                    _fixedTimesListKey.currentState?.insertItem(
                      times.length - 1,
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                ),
              ],
            ),
          ),
          NotificationRadioCard(
            selectedType: RecurrenceType.random,
            label: RecurrenceType.random.label(context.l10n),
            icon: Icons.shuffle,
            isSelected: _recurrenceType == RecurrenceType.random,
            onTap: () {
              setState(() {
                _recurrenceType = RecurrenceType.random;
                _randomWindowStart = TimeOfDay(hour: 8, minute: 0);
                _randomWindowEnd = TimeOfDay(hour: 17, minute: 0);
              });
            },
            child: Column(
              spacing: 5,
              children: [
                NotificationCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          Text(
                            context.l10n.notificationPageHowManyTimes,
                            style: font(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),

                          NotificationTextfield(
                            controller: _randomTimesController,
                            hintText: "5",
                            maxLines: 1,
                            isExpanded: false,
                            isDense: true,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      Text(
                        context.l10n.notificationPageRandomExample,
                        style: font(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_recurrenceType != null)
                  buildTimeRangePicking(_recurrenceType!),
              ],
            ),
          ),
          NotificationRadioCard(
            selectedType: RecurrenceType.interval,
            label: RecurrenceType.interval.label(context.l10n),
            icon: Icons.loop,
            isSelected: _recurrenceType == RecurrenceType.interval,
            onTap: () {
              setState(() {
                _recurrenceType = RecurrenceType.interval;
                _intervalUnit = IntervalUnit.hour;
                _intervalWindowStart = TimeOfDay(hour: 8, minute: 0);
                _intervalWindowEnd = TimeOfDay(hour: 17, minute: 0);
              });
            },
            child: Column(
              spacing: 5,
              children: [
                NotificationCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            context.l10n.notificationPageEvery,
                            style: font(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),

                          NotificationTextfield(
                            controller: _intervalTimesController,
                            hintText: "2",
                            maxLines: 1,
                            isExpanded: false,
                            isDense: true,
                            keyboardType: TextInputType.number,
                          ),

                          NotificationOutlinedButton(
                            label: "",
                            labelWidget: Text(
                              (_intervalUnit ?? IntervalUnit.hour).label(
                                context.l10n,
                              ),
                              style: font(fontSize: 15, color: Colors.white54),
                            ),
                            centerText: true,
                            isCurrentlySelected: true,
                            onPressed: () {
                              setState(() {
                                if (_intervalUnit == IntervalUnit.hour) {
                                  _intervalUnit = IntervalUnit.minute;
                                } else {
                                  _intervalUnit = IntervalUnit.hour;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        context.l10n.notificationPageIntervalExample,
                        style: font(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_recurrenceType != null)
                  buildTimeRangePicking(_recurrenceType!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedTimeItem(
    TimeOfDay time,
    Animation<double> animation, {
    required bool showDelete,
    VoidCallback? onDelete,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: FadeTransition(
        opacity: animation,
        child: Column(
          children: [
            SizedBox(height: 10),
            NotificationOutlinedButton(
              label: time.format(context),
              isExpanded: true,
              isSelected: true,
              icon: Icon(
                Icons.access_time,
                color: Colors.blue.shade600,
                size: 20,
              ),
              tailingWidget: AnimatedSwitcher(
                duration: 250.ms,
                child: showDelete
                    ? IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Colors.blue.shade600,
                        ),
                        onPressed: onDelete,
                      )
                    : null,
              ),

              onPressed: () async {
                final l10n = context.l10n;
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: time,
                );

                if (pickedTime == null) return;

                final duplicate = _fixedSpecificTimes!.any(
                  (existingTime) => existingTime == pickedTime,
                );

                if (duplicate) {
                  showError(l10n.notificationPageDuplicateTime);
                  return;
                }

                setState(() {
                  _fixedSpecificTimes![_fixedSpecificTimes!.indexOf(time)] =
                      pickedTime;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDurationOptions() {
    final font = appFontOf(context);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    return RadioGroup(
      groupValue: _durationOption,
      onChanged: (value) {
        setState(() {
          _durationOption = value;
        });
      },
      child: Column(
        children: [
          NotificationRadioCard(
            selectedType: DurationOption.forever,
            label: DurationOption.forever.label(context.l10n),
            isSelected: _durationOption == DurationOption.forever,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.forever;
              });
            },
          ),

          NotificationRadioCard(
            selectedType: DurationOption.duration,
            label: DurationOption.duration.label(context.l10n),
            isSelected: _durationOption == DurationOption.duration,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.duration;
              });
            },
            child: NotificationCard(
              child: Row(
                spacing: 5,
                children: [
                  Text(
                    "${context.l10n.notificationPageDuration} ",
                    style: font(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  NotificationTextfield(
                    controller: _durationCountController,
                    hintText: "7",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    isDense: true,
                    isExpanded: false,
                  ),
                  NotificationOutlinedButton(
                    label: (_durationUnit ?? ScheduleUnit.daily).unit(
                      int.tryParse(_durationCountController.text) ?? 1,
                      l10n,
                    ),
                    isCurrentlySelected: true,
                    onPressed: () {
                      setState(() {
                        _durationUnit ??= ScheduleUnit.daily;

                        switch (_durationUnit!) {
                          case ScheduleUnit.daily:
                            _durationUnit = ScheduleUnit.weekly;
                          case ScheduleUnit.weekly:
                            _durationUnit = ScheduleUnit.monthly;
                          case ScheduleUnit.monthly:
                            _durationUnit = ScheduleUnit.yearly;
                          case ScheduleUnit.yearly:
                            _durationUnit = ScheduleUnit.daily;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          NotificationRadioCard(
            selectedType: DurationOption.untilDate,
            label: DurationOption.untilDate.label(context.l10n),
            isSelected: _durationOption == DurationOption.untilDate,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.untilDate;
              });
            },
            child: NotificationOutlinedButton(
              label: _endDate != null
                  ? DateFormat.yMMMd(locale).format(_endDate!)
                  : context.l10n.actionSelectDate,
              isExpanded: true,
              icon: Icon(
                Icons.calendar_month,
                color: Colors.blueAccent.shade700,
                size: 20,
              ),
              isSelected: _endDate != null,
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
                );
                if (pickedDate != null) {
                  setState(() {
                    _endDate = pickedDate;
                  });
                }
              },
            ),
          ),
          NotificationRadioCard(
            selectedType: DurationOption.occurrences,
            label: DurationOption.occurrences.label(context.l10n),
            isSelected: _durationOption == DurationOption.occurrences,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.occurrences;
              });
            },
            child: NotificationCard(
              child: Row(
                spacing: 5,
                children: [
                  Text(
                    context.l10n.notificationPageDuration,
                    style: font(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  NotificationTextfield(
                    controller: _totalTimesController,
                    hintText: "10",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    isDense: true,
                    isExpanded: false,
                  ),
                  Text(
                    context.l10n.notificationPageOccurrences,
                    style: font(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> _selectedDaysForActiveMonth() {
    final selectedDaysOfYear = _selectedDaysOfYear ??= <MonthDaysRepetition>[];

    final selection = selectedDaysOfYear.firstWhere(
      (element) => element.selectedMonth == _activeSelectedMonth,
      orElse: () {
        final newSelection = MonthDaysRepetition(
          selectedMonth: _activeSelectedMonth,
          selectedDaysOfMonth: <int>[],
        );
        selectedDaysOfYear.add(newSelection);
        return newSelection;
      },
    );

    return selection.selectedDaysOfMonth ??= <int>[];
  }

  bool _applyTimeWindow({
    required RecurrenceType recurrenceType,
    required TimeOfDay start,
    required TimeOfDay end,
  }) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes >= endMinutes) {
      showError(context.l10n.validationStartBeforeEnd);
      return false;
    }

    setState(() {
      if (recurrenceType == RecurrenceType.interval) {
        _intervalWindowStart = start;
        _intervalWindowEnd = end;
      } else {
        _randomWindowStart = start;
        _randomWindowEnd = end;
      }
    });

    return true;
  }

  Widget buildTimeRangePicking(RecurrenceType recurrenceType) {
    final font = appFontOf(context);
    final fromTime = recurrenceType == RecurrenceType.interval
        ? _intervalWindowStart
        : _randomWindowStart;

    final untilTime = recurrenceType == RecurrenceType.interval
        ? _intervalWindowEnd
        : _randomWindowEnd;

    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: NotificationOutlinedButton(
            label: "",
            padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 12),
            centerText: false,
            isExpanded: true,
            onPressed: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: fromTime ?? TimeOfDay(hour: 8, minute: 0),
              );
              if (pickedTime != null) {
                final currentEnd =
                    untilTime ?? const TimeOfDay(hour: 17, minute: 0);

                _applyTimeWindow(
                  recurrenceType: recurrenceType,
                  start: pickedTime,
                  end: currentEnd,
                );
              }
            },
            labelWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.notificationPageFrom,
                  style: font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white38,
                  ),
                ),
                Text(
                  fromTime != null
                      ? fromTime.format(context)
                      : context.l10n.notificationPageSelectRange,
                  style: font(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Text(
          context.l10n.actionTo,
          style: font(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
        Expanded(
          child: NotificationOutlinedButton(
            label: "",
            padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 12),
            centerText: false,
            isExpanded: true,
            onPressed: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: untilTime ?? TimeOfDay(hour: 17, minute: 0),
              );
              if (pickedTime != null) {
                final currentStart =
                    fromTime ?? const TimeOfDay(hour: 8, minute: 0);

                _applyTimeWindow(
                  recurrenceType: recurrenceType,
                  start: currentStart,
                  end: pickedTime,
                );
              }
            },
            labelWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.notificationPageUntil,
                  style: font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white38,
                  ),
                ),
                Text(
                  untilTime != null
                      ? untilTime.format(context)
                      : context.l10n.notificationPageSelectRange,
                  style: font(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

//TODO: Make it return something to know if the permissions are granted or not
Future<NotificationPermissionStatus?> ensureNotificationPermission(
  BuildContext context,
) async {
  final status = await PermissionService.instance
      .checkNotificationPermissionStatus();
  log("Notification permission status before request: $status");

  if (!status.isNotificationPermissionGranted) {
    if (!context.mounted) return null;
    await buildPermissionDialog(
      context,
      context.l10n.permissionNotificationsTitle,
      context.l10n.permissionNotificationsMessage,
      context.l10n.actionOkay,
      () async {
        await PermissionService.instance.requestNotificationPermission();
        if (!context.mounted) return;
        Navigator.pop(context);
      },
    );
  }

  if (!status.isExactAlarmPermissionGranted) {
    if (!context.mounted) return null;
    await buildPermissionDialog(
      context,
      context.l10n.permissionExactAlarmTitle,
      context.l10n.permissionExactAlarmMessage,
      context.l10n.actionOpenSettings,
      () async {
        log("Requesting exact alarm permission");
        await PermissionService.instance.requestExactAlarmPermission();
        if (!context.mounted) return;
        Navigator.pop(context);
      },
    );
  }

  if (!status.isDndAccessPermissionGranted) {
    if (!context.mounted) return null;
    await buildPermissionDialog(
      context,
      context.l10n.permissionDndTitle,
      context.l10n.permissionDndMessage,
      context.l10n.actionOpenSettings,
      () async {
        await PermissionService.instance.requestDndAccessPermission();
        if (!context.mounted) return;
        Navigator.pop(context);
      },
    );
  }
  final updatedStatus = await PermissionService.instance
      .checkNotificationPermissionStatus();

  log("Notification permission status after request: $updatedStatus");
  return updatedStatus;
}
