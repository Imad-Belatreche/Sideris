import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/pages/create_update_notification_page.dart';
import 'package:sideris/utils/general_utils.dart';
import 'package:sideris/utils/recurrence_calculator.dart';
import 'package:sideris/widgets/calendar_day.dart';
import 'package:sideris/widgets/night_sky_background.dart';
import 'package:sideris/widgets/notification_listing.dart';
import 'package:sideris/widgets/slide_trigger_item.dart';

class HomePage extends StatefulWidget {
  //Enough for now at least
  //TODO: Add some stats widgets

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;

  static const int _initialPage = 12;
  late final PageController _pageController;
  final DateTime _baseDate = DateTime.now();
  DateTime _selectedDay = dateOnly(DateTime.now());

  @override
  void initState() {
    super.initState();
    //FIXME:Revise this performance killer
    _timer = Timer.periodic(1.minutes, (_) {
      if (mounted) setState(() {});
    });
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final Set<int> _leavingIds = {};
  bool isCalanderView = true;

  DateTime getMonthFromIndex(int index) {
    final monthOffset = index - _initialPage;
    return DateTime(_baseDate.year, _baseDate.month + monthOffset, 1);
  }

  List<NotificationRuleModel> _rulesForDay(
    DateTime day,
    NotificationState state,
  ) {
    final rules = state.notifications
        .where(
          (notification) => RecurrenceCalculator.occursOnDay(notification, day),
        )
        .toList();
    rules.sort((first, second) => first.startDate.compareTo(second.startDate));
    return rules;
  }

  Future<void> _deleteNotification(NotificationRuleModel notification) async {
    final confirmed = await showWarningDialogue(
      text:
          "This notification rule will be permanently deleted.\n\nAre you sure about that?",
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Delete"),
        ),
      ],
    );

    if (confirmed != true || !mounted) return;
    setState(() => _leavingIds.add(notification.id));
    await Future.delayed(300.ms);

    if (!mounted) return;

    final deleted = await context.read<NotificationCubit>().deleteNotification(
      notification.id,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Notification deleted",
          style: GoogleFonts.outfit(color: Colors.black),
        ),
        backgroundColor: Colors.greenAccent,
        action: SnackBarAction(
          onPressed: () async {
            setState(() => _leavingIds.remove(deleted.id));
            await context.read<NotificationCubit>().addNotification(deleted);
          },
          label: "Undo",
        ),
      ),
    );
  }

  List<Color> getColorsOfDate(DateTime day, NotificationState state) {
    if (state.notifications.isEmpty) return [];

    return [
      for (final n in state.notifications)
        if (RecurrenceCalculator.occursOnDay(n, day))
          n.colorTag?.value ?? Colors.white,
    ];
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String getGreeting() {
      final hour = now.hour;

      if (hour < 12) return 'Good Morning';
      if (hour < 17) return 'Good Afternoon';
      return 'Good Evening';
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.isLoading && state.notifications.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                final selectedDayRules = _rulesForDay(_selectedDay, state);
                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<NotificationCubit>().loadNotifications();
                  },
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        toolbarHeight: 70,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                      getGreeting(),
                                      style: GoogleFonts.outfit(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(duration: 400.ms)
                                    .slideX(
                                      duration: 400.ms,
                                      begin: -0.05,
                                      curve: Curves.easeOut,
                                    ),
                                const SizedBox(height: 2),

                                Text(
                                      DateFormat.EEEE()
                                          .addPattern(", MMMM dd")
                                          .format(now),
                                      style: GoogleFonts.outfit(
                                        color: Colors.white38,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(duration: 400.ms, delay: 100.ms)
                                    .slideX(
                                      duration: 400.ms,
                                      delay: 100.ms,
                                      begin: -0.05,
                                      curve: Curves.easeOut,
                                    ),
                              ],
                            ),
                            IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isCalanderView = !isCalanderView;
                                    });
                                  },
                                  icon: Icon(
                                    isCalanderView
                                        ? Icons.list
                                        : Icons.calendar_today,
                                    size: 25,
                                  ),
                                )
                                .animate(key: ValueKey(isCalanderView))
                                .fadeIn(duration: 250.ms)
                                .scaleXY(),
                          ],
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: AnimatedCrossFade(
                          reverseDuration: 350.ms,
                          crossFadeState: isCalanderView
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: 400.ms,
                          firstChild: _buildCalanderView(
                            state,
                            selectedDayRules,
                          ),
                          secondChild: _buildListView(state),
                        ),
                      ),

                      SliverToBoxAdapter(child: SizedBox(height: 25)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }

  Widget _buildCalanderView(
    NotificationState state,
    List<NotificationRuleModel> selectedDayRules,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          key: ValueKey("Yes Calandar"),
          height: 550,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: 25,

            controller: _pageController,
            itemBuilder: (context, index) {
              final monthDate = getMonthFromIndex(index);
              return CalendarDay(
                state: state,
                getColorsOfDate: getColorsOfDate,
                currentDate: monthDate,
                selectedDate: _selectedDay,
                onRightPressed: () => _pageController.nextPage(
                  duration: 400.ms,
                  curve: Curves.easeIn,
                ),
                onLeftPressed: () => _pageController.previousPage(
                  duration: 400.ms,
                  curve: Curves.easeIn,
                ),
                onDayPress: (day) {
                  setState(() => _selectedDay = dateOnly(day));
                },
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeyedSubtree(
                    key: ValueKey(_selectedDay),
                    child:
                        Text(
                              DateFormat('EEEE, MMMM d').format(_selectedDay),
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 300.ms, curve: Curves.easeIn)
                            .slideX(
                              begin: -0.1,
                              duration: 300.ms,
                              curve: Curves.easeIn,
                            ),
                  ),
                  const SizedBox(height: 4),
                  KeyedSubtree(
                    key: ValueKey(selectedDayRules.length),
                    child:
                        Text(
                              selectedDayRules.isEmpty
                                  ? 'No rules planned for this day'
                                  : '${selectedDayRules.length} ${selectedDayRules.length == 1 ? 'rule' : 'rules'} planned',
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 300.ms, curve: Curves.easeIn)
                            .slideX(
                              begin: -0.1,
                              duration: 300.ms,
                              curve: Curves.easeIn,
                            ),
                  ),
                  const SizedBox(height: 12),
                  if (selectedDayRules.isEmpty)
                    Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Center(
                            child: Text(
                              'Tap another day to inspect its rules.',
                              style: GoogleFonts.outfit(color: Colors.white38),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 300.ms, curve: Curves.easeIn)
                        .slideY(
                          begin: 0.4,
                          duration: 300.ms,
                          curve: Curves.easeIn,
                        )
                  else
                    for (final notification in selectedDayRules)
                      Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SlideTriggerItem(
                              onTriggered: () =>
                                  _deleteNotification(notification),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                      transitionDuration: 300.ms,
                                      pageBuilder:
                                          (_, animation, secondaryAnimation) {
                                            return NightSkyBackground(
                                              child: BlocProvider.value(
                                                value: context
                                                    .read<NotificationCubit>(),
                                                child:
                                                    CreateUpdateNotificationPage(
                                                      updateNotification:
                                                          notification,
                                                    ),
                                              ),
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: NotificationListing(
                                  key: ValueKey(
                                    "calender_rule_${notification.id}",
                                  ),
                                  notification: notification,
                                ),
                              ),
                            ),
                          )
                          .animate(
                            target: _leavingIds.contains(notification.id)
                                ? 1
                                : 0,
                          )
                          .fadeOut(duration: 300.ms, curve: Curves.easeIn)
                          .slideY(
                            begin: 0.0,
                            end: 0.12,
                            duration: 300.ms,
                            curve: Curves.easeIn,
                          ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 300.ms, curve: Curves.easeIn)
            .slideY(begin: 0.4, duration: 300.ms, curve: Curves.easeIn),
      ],
    );
  }

  Widget _buildListView(NotificationState state) {
    return Column(
      key: const ValueKey("ListViewContainer"),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "All Active Rules",
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (final notification in state.notifications.reversed.toList())
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: NotificationListing(
              key: ValueKey("all_rule_${notification.id}"),
              notification: notification,
            ),
          ),
      ],
    );
  }

  Future<bool?> showWarningDialogue({
    required String text,
    List<Widget>? actions,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
            side: BorderSide(color: Colors.white12),
          ),
          backgroundColor: const Color.fromARGB(255, 38, 7, 75),
          content: Text(text),
          title: Text(
            "Warning",
            style: GoogleFonts.outfit(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
