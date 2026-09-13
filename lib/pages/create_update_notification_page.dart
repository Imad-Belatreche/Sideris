import 'dart:developer';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/services/permission_service.dart';
import 'package:sideris/utils/permission_dialog.dart';
import 'package:sideris/widgets/dnd_switch.dart';
import 'package:sideris/widgets/notification_card.dart';
import 'package:sideris/widgets/notification_outlined_button.dart';
import 'package:sideris/widgets/notification_radio_card.dart';
import 'package:sideris/widgets/notification_textfield.dart';
import 'package:sideris/widgets/text/creation_screen_title.dart';

enum DurationOption { forever, duration, untilDate, totalTimes }

class CreateUpdateNotificationPage extends StatefulWidget {
  const CreateUpdateNotificationPage({super.key});

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

  ScheduleUnit? _scheduleUnit = ScheduleUnit.day;
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

  final GlobalKey<AnimatedListState> _fixedTimesListKey =
      GlobalKey<AnimatedListState>();

  NotificationRuleModel? buildNotificationFromForm() {
    late NotificationRuleModel notification;

    final title = _titleController.text.trim();
    if (title.isEmpty) {
      showError("Title cannot be empty.");
      return null;
    }

    String? description = _descriptionController.text.trim();
    if (description.isEmpty) {
      description = null;
    }

    if (_startDate == null) {
      showError("Please select a start date and time.");
      return null;
    }

    if (_repetitionType == RepetitionType.oneTime) {
      if (_startDate != null && _startDate!.isBefore(DateTime.now())) {
        showError("Selected date and time cannot be in the past.");
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
        showError("Select a daily timing method.");
        return null;
      }

      int? scheduleEvery = int.tryParse(_scheduleEveryController.text.trim());

      if (_scheduleUnit == ScheduleUnit.day) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError("'Repeat every' must be a whole number greater than 0.");
          return null;
        }

        if (_dailyOption == DailyOption.weekdays ||
            _dailyOption == DailyOption.weekends) {
          scheduleEvery = 1;
        }
      }

      if (_scheduleUnit == ScheduleUnit.week) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError("'Repeat every' must be a whole number greater than 0.");
          return null;
        }

        if (_selectedDaysOfWeek == null || _selectedDaysOfWeek!.isEmpty) {
          showError("Select at least one day of the week.");
          return null;
        }
      }

      if (_scheduleUnit == ScheduleUnit.month) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError("'Repeat every' must be a whole number greater than 0.");
          return null;
        }

        if (_selectedDaysOfMonth == null || _selectedDaysOfMonth!.isEmpty) {
          showError("Select at least one day of the month.");
          return null;
        }
      }

      if (_scheduleUnit == ScheduleUnit.year) {
        if (scheduleEvery == null || scheduleEvery <= 0) {
          showError("'Repeat every' must be a whole number greater than 0.");
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
          showError("Select at least one month and one day.");
          return null;
        }
      }
      final DailyOption? dailyOption = _scheduleUnit == ScheduleUnit.day
          ? _dailyOption
          : null;

      final List<int>? selectedDaysOfWeek = _scheduleUnit == ScheduleUnit.week
          ? _selectedDaysOfWeek
          : _scheduleUnit == ScheduleUnit.day &&
                _dailyOption == DailyOption.weekdays
          ? [1, 2, 3, 4, 5]
          : _scheduleUnit == ScheduleUnit.day &&
                _dailyOption == DailyOption.weekends
          ? [6, 7]
          : null;

      final List<MonthDaysRepetition>? selectedMonthDays =
          _scheduleUnit == ScheduleUnit.year
          ? _selectedDaysOfYear
          : _scheduleUnit == ScheduleUnit.month
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
          showError(
            "You must add at least one time for `At selected times` type",
          );
          return null;
        }
        // Show error when duplicated times
        if (_fixedSpecificTimes!.length !=
            _fixedSpecificTimes!.toSet().length) {
          showError(
            "You cannot add duplicate times for `At selected times` type",
          );
          return null;
        }
      } else if (_recurrenceType == RecurrenceType.random) {
        if (_randomTimesController.text.trim().isEmpty) {
          showError(
            "You must set the `How many times` field for `Random times` type",
          );
          return null;
        }
        randomCount = int.tryParse(_randomTimesController.text.trim());
        if (randomCount == null) {
          showError("The `How many times` field must be a number");
          return null;
        }

        if (randomCount <= 0) {
          showError("Number of random notifications must be greater than 0.");
          return null;
        }

        if (_randomWindowStart == null || _randomWindowEnd == null) {
          showError("Select random notification start and end times.");
          return null;
        }

        final startMinutes =
            _randomWindowStart!.hour * 60 + _randomWindowStart!.minute;
        final endMinutes =
            _randomWindowEnd!.hour * 60 + _randomWindowEnd!.minute;

        if (startMinutes >= endMinutes) {
          showError("Random times start time must be before end time.");
          return null;
        }

        final availableMinutes = endMinutes - startMinutes + 1;
        if (randomCount > availableMinutes) {
          showError(
            "Random times notification count cannot exceed available minutes in window.",
          );
          return null;
        }
      } else {
        if (_intervalTimesController.text.trim().isEmpty) {
          showError(
            "You must set the `Every` field for `At regular intervals` type",
          );
          return null;
        }
        intervalCount = int.tryParse(_intervalTimesController.text.trim());

        if (intervalCount == null || intervalCount <= 0) {
          showError(
            "At regular intervals must be a whole number greater than 0.",
          );
          return null;
        }

        if (_intervalUnit == null) {
          showError("Select an interval unit.");
          return null;
        }

        if (_intervalWindowStart == null || _intervalWindowEnd == null) {
          showError("Select interval start and end times.");
          return null;
        }

        final startMinutes =
            _intervalWindowStart!.hour * 60 + _intervalWindowStart!.minute;
        final endMinutes =
            _intervalWindowEnd!.hour * 60 + _intervalWindowEnd!.minute;

        if (startMinutes >= endMinutes) {
          showError("At regular intervals start time must be before end time.");
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
        showError("Select a duration type");
        return null;
      }

      if (_durationOption == DurationOption.duration && _durationUnit == null) {
        showError("Select a duration unit.");
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
        showError("Enter a valid duration.");
        return null;
      }

      if (_durationOption == DurationOption.totalTimes &&
          (parsedTotalTimes == null || parsedTotalTimes <= 0)) {
        showError("Enter valid total times occurrences.");
        return null;
      }

      if (_durationOption == DurationOption.untilDate && _endDate == null) {
        showError("Select an end date for the notification.");
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

      final int? totalOccurrences = _durationOption == DurationOption.totalTimes
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

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Create Notification',
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
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
                const CreationScreenTitle(title: "Title"),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _titleController,
                  hintText: 'Notification title',
                  maxLines: 1,
                ),

                SizedBox(height: 16),

                CreationScreenTitle(
                  title: "${"Content".toUpperCase()} (optional)",
                ),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _descriptionController,
                  hintText: 'Add details...',
                  maxLines: 3,
                ),

                SizedBox(height: 16),

                const CreationScreenTitle(title: "Color Tag"),
                SizedBox(height: 5),
                buildColorTagSelector(),

                const CreationScreenTitle(title: "Repetition Type"),
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

                const CreationScreenTitle(title: "Options"),
                SizedBox(height: 5),
                buildOptions(),

                SizedBox(height: 30),

                Align(
                  alignment: Alignment.center,
                  child: NotificationOutlinedButton(
                    label: "Create Notification",
                    isSelected: true,
                    onPressed: () async {
                      try {
                        final permissionStatus =
                            await ensureNotificationPermission(context);
                        if (permissionStatus == null ||
                            !permissionStatus.isNotificationPermissionGranted ||
                            !permissionStatus.isExactAlarmPermissionGranted ||
                            !permissionStatus.isDndAccessPermissionGranted) {
                          showError(
                            "Required permissions are not granted. Please enable them in settings.",
                          );
                          return;
                        }

                        final notification = buildNotificationFromForm();
                        if (notification == null) {
                          return;
                        }

                        await notificationCubit.addNotification(notification);

                        log(" Notification added: ${notification.toString()}");
                        //TODO: Make the snackBar look better or pop the page entirely
                        if (!context.mounted) return;
                        showError("Notification saved successfully.");
                      } catch (e) {
                        log("Error while creating notification: $e");
                        if (!context.mounted) return;
                        showError("Error while creating notification: $e");
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
          label: "One-time",
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
          label: "Repetitive",
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
    return Column(
      key: ValueKey<String>(key),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreationScreenTitle(title: "Date & Time"),

        ///TODO: Maybe using a single button for whole date?
        /// First shows the date picker then the time picker
        NotificationOutlinedButton(
          label: _startDate != null
              ? DateFormat.yMMMd().format(_startDate!)
              : "Select Date",
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
              ? DateFormat.jm().format(_startDate!)
              : "Select Time",
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
                const SnackBar(content: Text("Please select a date first.")),
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
    return Column(
      key: ValueKey<String>(key),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreationScreenTitle(title: "Schedule"),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              NotificationOutlinedButton(
                label: "Day",
                isSelected: _scheduleUnit == ScheduleUnit.day,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.day;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Week",
                isSelected: _scheduleUnit == ScheduleUnit.week,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.week;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Month",
                isSelected: _scheduleUnit == ScheduleUnit.month,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.month;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Year",
                isSelected: _scheduleUnit == ScheduleUnit.year,
                onPressed: () {
                  setState(() {
                    _scheduleUnit = ScheduleUnit.year;
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
                    "Start".toUpperCase(),
                    style: GoogleFonts.outfit(
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
                      label: "From now",
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
                          ? DateFormat.yMd().add_jm().format(_startDate!)
                          : "Pick date & time",
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
                              showError(
                                "Selected date and time cannot be in the past.",
                              );
                            }
                          } else {
                            if (!mounted) return;
                            showError("Time selection canceled.");
                          }
                        } else {
                          if (!mounted) return;
                          showError("Date selection canceled.");
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
              (_scheduleUnit == ScheduleUnit.day &&
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
                        "Repeat every",
                        style: GoogleFonts.outfit(
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
                          "${_scheduleUnit!.name[0].toUpperCase()}${_scheduleUnit!.name.substring(1)} (s)",
                          style: GoogleFonts.outfit(
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
            ScheduleUnit.day => KeyedSubtree(
              key: const ValueKey('schedule-day'),
              child: buildDayOptions(),
            ),
            ScheduleUnit.week => KeyedSubtree(
              key: const ValueKey('schedule-week'),
              child: buildWeekOptions(),
            ),
            ScheduleUnit.month => KeyedSubtree(
              key: const ValueKey('schedule-month'),
              child: buildMonthOptions(),
            ),
            ScheduleUnit.year => KeyedSubtree(
              key: const ValueKey('schedule-year'),
              child: buildYearOptions(),
            ),
          },
        ),

        SizedBox(height: 16),
        CreationScreenTitle(title: "Daily timing"),
        SizedBox(height: 5),

        buildDailyTiming(),

        SizedBox(height: 16),
        CreationScreenTitle(title: "Duration"),
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
          label: "All days",
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
          label: "Weekdays",
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
          label: "Weekends",
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
    final normalDaysOfWeek = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
    final englishDaysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final selectedDaysOfWeek = _selectedDaysOfWeek ??= <int>[];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 0,
        children: [
          for (var day in normalDaysOfWeek)
            NotificationOutlinedButton(
              label: day,
              isExpanded: false,
              isSelected: selectedDaysOfWeek.contains(
                englishDaysOfWeek.indexOf(day) + 1,
              ),
              centerText: true,
              isRounded: true,
              icon: null,
              onPressed: () {
                setState(() {
                  final dayIndex = englishDaysOfWeek.indexOf(day) + 1;
                  if (selectedDaysOfWeek.contains(dayIndex)) {
                    selectedDaysOfWeek.remove(dayIndex);
                  } else {
                    selectedDaysOfWeek.add(dayIndex);
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
                label: "First day of month",
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
                label: "Last day of month",
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
            "If you select 29, 30 or 31, the notification will not trigger in months that do not have those days.",
            style: GoogleFonts.outfit(
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
    final monthNumbers = List.generate(12, (int index) => index + 1);

    final months = [
      for (var month in monthNumbers)
        DateFormat.MMM().format(DateTime(2026, month)),
    ];

    final daysInActiveMonth = _activeSelectedMonth != null
        ? DateTime(2026, _activeSelectedMonth! + 1, 0).day
        : 0;

    final selectedDaysOfYear = _selectedDaysOfYear ??= <MonthDaysRepetition>[];

    return NotificationCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Month (s)",
            style: GoogleFonts.outfit(
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
          if (_activeSelectedMonth != null) ...[
            Text(
              "Day (s)",
              style: GoogleFonts.outfit(
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
                  label: "First day of month",
                  isExpanded: false,
                  isSelected: selectedDaysOfYear.any(
                    (selection) =>
                        selection.selectedMonth == _activeSelectedMonth &&
                        selection.selectedDaysOfMonth?.contains(1) == true,
                  ),
                  centerText: true,
                  icon: null,
                  onPressed: () {
                    setState(() {
                      final selectedDays = _selectedDaysForActiveMonth();
                      if (selectedDays.contains(1)) {
                        selectedDays.remove(1);
                      } else {
                        selectedDays.add(1);
                      }
                    });
                  },
                ),
                NotificationOutlinedButton(
                  label: "Last day of month",
                  isExpanded: false,
                  isSelected: selectedDaysOfYear.any(
                    (selection) =>
                        selection.selectedMonth == _activeSelectedMonth &&
                        selection.selectedDaysOfMonth?.contains(
                              daysInActiveMonth,
                            ) ==
                            true,
                  ),
                  centerText: true,
                  icon: null,
                  onPressed: () {
                    setState(() {
                      final selectedDays = _selectedDaysForActiveMonth();
                      if (selectedDays.contains(daysInActiveMonth)) {
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
                            element.selectedMonth == _activeSelectedMonth &&
                            element.selectedDaysOfMonth != null &&
                            element.selectedDaysOfMonth!.contains(day),
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
                                element.selectedMonth == _activeSelectedMonth,
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
        ],
      ),
    );
  }

  Widget buildDailyTiming() {
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
            label: "At selected times",
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
                  label: "Add Time",
                  labelStyle: GoogleFonts.outfit(
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
                      showError("All daily time slots are already selected.");
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
            label: "Random times",
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
                            "How many times: ",
                            style: GoogleFonts.outfit(
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
                        "e.g: Show 5 notifications at random times",
                        style: GoogleFonts.outfit(
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
            label: "At regular intervals",
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
                            "Every:",
                            style: GoogleFonts.outfit(
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
                              _intervalUnit == null ||
                                      _intervalUnit == IntervalUnit.hour
                                  ? "hours"
                                  : "minutes",
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                color: Colors.white54,
                              ),
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
                        "e.g: Show notification every 2 hours",
                        style: GoogleFonts.outfit(
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
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: time,
                );

                if (pickedTime == null) return;

                final duplicate = _fixedSpecificTimes!.any(
                  (existingTime) => existingTime == pickedTime,
                );

                if (duplicate) {
                  showError(
                    "This time is already selected. Choose a different time.",
                  );
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
            label: "Forever",
            isSelected: _durationOption == DurationOption.forever,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.forever;
              });
            },
          ),

          NotificationRadioCard(
            selectedType: DurationOption.duration,
            label: "N duration",
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
                    "Duration: ",
                    style: GoogleFonts.outfit(
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
                    label: _durationUnit != null
                        ? "${_durationUnit!.name[0].toUpperCase()}${_durationUnit!.name.substring(1).toLowerCase()}s"
                        : "${ScheduleUnit.day.name[0].toUpperCase()}${ScheduleUnit.day.name.substring(1).toLowerCase()}s",
                    isCurrentlySelected: true,
                    onPressed: () {
                      setState(() {
                        _durationUnit ??= ScheduleUnit.day;

                        switch (_durationUnit!) {
                          case ScheduleUnit.day:
                            _durationUnit = ScheduleUnit.week;
                          case ScheduleUnit.week:
                            _durationUnit = ScheduleUnit.month;
                          case ScheduleUnit.month:
                            _durationUnit = ScheduleUnit.year;
                          case ScheduleUnit.year:
                            _durationUnit = ScheduleUnit.day;
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
            label: "Until date",
            isSelected: _durationOption == DurationOption.untilDate,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.untilDate;
              });
            },
            child: NotificationOutlinedButton(
              label: _endDate != null
                  ? DateFormat.yMMMd().format(_endDate!)
                  : "Select a date",
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
            selectedType: DurationOption.totalTimes,
            label: "N total times",
            isSelected: _durationOption == DurationOption.totalTimes,
            onTap: () {
              setState(() {
                _durationOption = DurationOption.totalTimes;
              });
            },
            child: NotificationCard(
              child: Row(
                spacing: 5,
                children: [
                  Text(
                    "Duration: ",
                    style: GoogleFonts.outfit(
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
                    "occurrences",
                    style: GoogleFonts.outfit(
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
      showError("Start time must be before end time.");
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
                  "From",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white38,
                  ),
                ),
                Text(
                  fromTime != null ? fromTime.format(context) : "Select range",
                  style: GoogleFonts.outfit(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Text(
          "to",
          style: GoogleFonts.outfit(
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
                  "Until",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white38,
                  ),
                ),
                Text(
                  untilTime != null
                      ? untilTime.format(context)
                      : "Select range",
                  style: GoogleFonts.outfit(fontSize: 16, color: Colors.white),
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
      'Notifications Permission Required',
      'Please allow notifications permission in settings to receive reminders.',
      'Okay',
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
      'Exact Alarm Permission Required',
      'Please allow exact alarm permission in settings to receive reminders.',
      'Open Settings',
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
      'DND Access Permission Required',
      'Please allow DND access permission in settings to receive reminders.',
      'Open Settings',
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
