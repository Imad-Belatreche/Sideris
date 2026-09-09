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
import 'package:sideris/widgets/notification_textfield.dart';
import 'package:sideris/widgets/text/creation_screen_title.dart';

enum DailyOption { allDays, weekdays, weekends }

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
  ColorTag? _selectedColorTag;

  DateTime? _selectedDateTime;
  RepetitionType _selectedRepetitionType = RepetitionType.oneTime;
  DailyOption _selectedDailyOption = DailyOption.allDays;

  bool _isDndEnabled = false;

  ScheduleUnit _selectedScheduleUnit = ScheduleUnit.day;
  final TextEditingController _scheduleEveryController =
      TextEditingController();

  List<int>? _selectedDaysOfWeek;

  List<int>? _selectedDaysOfMonth;
  bool? isFirstOfMonthSelected;

  List<MonthDaysRepetition>? _selectedDaysOfYear;
  int? _activeSelectedMonth;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _scheduleEveryController.dispose();
    super.dispose();
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
                  child: _selectedRepetitionType == RepetitionType.oneTime
                      ? buildOneTime(key: "oneTime")
                      : buildRepetitive(key: "repetitive"),
                ),

                SizedBox(height: 16),
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

                        late NotificationRuleModel notification;

                        //TODO: Handle validation for _selectedDaysOfWeek, _selectedDaysOfMonth, and _selectedDaysOfYear based on the selected repetition type and schedule unit.
                        final title = _titleController.text.trim();
                        if (title.isEmpty) {
                          showError("Title cannot be empty.");
                          return;
                        }

                        String? description = _descriptionController.text
                            .trim();
                        if (description.isEmpty) {
                          description = null;
                        }

                        if (_selectedDateTime == null) {
                          showError("Please select a date and time.");
                          return;
                        }
                        if (_selectedDateTime == null) {
                          showError("Please select a date and time.");
                          return;
                        }

                        if (_selectedRepetitionType == RepetitionType.oneTime) {
                          if (_selectedDateTime != null &&
                              _selectedDateTime!.isBefore(DateTime.now())) {
                            showError(
                              "Selected date and time cannot be in the past.",
                            );
                            return;
                          }

                          notification = NotificationRuleModel(
                            title: title,
                            content: description,
                            startDate: _selectedDateTime!,
                            repetitionType: _selectedRepetitionType,
                            colorTag: _selectedColorTag,
                            bypassDnd: _isDndEnabled,
                          );
                        } else if (_selectedRepetitionType ==
                            RepetitionType.repetitive) {
                          final userInputScheduleEvery =
                              _scheduleEveryController.text.trim();

                          int? scheduleEvery = int.tryParse(
                            userInputScheduleEvery,
                          );

                          if (_selectedScheduleUnit == ScheduleUnit.day) {
                            if (_selectedDailyOption != DailyOption.allDays &&
                                (scheduleEvery == null || scheduleEvery <= 0)) {
                              showError(
                                "'Repeat every' must be a whole number greater than 0.",
                              );
                              return;
                            }

                            if (_selectedDailyOption == DailyOption.weekdays ||
                                _selectedDailyOption == DailyOption.weekends) {
                              scheduleEvery = 1;
                              setState(() {
                                _selectedDaysOfWeek =
                                    _selectedDailyOption == DailyOption.weekdays
                                    ? [1, 2, 3, 4, 5]
                                    : [6, 7];
                              });
                            }
                          }

                          if (_selectedScheduleUnit == ScheduleUnit.week) {
                            if (scheduleEvery == null || scheduleEvery <= 0) {
                              showError(
                                "'Repeat every' must be a whole number greater than 0.",
                              );
                              return;
                            }

                            if (_selectedDaysOfWeek == null ||
                                _selectedDaysOfWeek!.isEmpty) {
                              showError("Select at least one day of the week.");
                              return;
                            }
                          }

                          if (_selectedScheduleUnit == ScheduleUnit.month) {
                            if (scheduleEvery == null || scheduleEvery <= 0) {
                              showError(
                                "'Repeat every' must be a whole number greater than 0.",
                              );
                              return;
                            }

                            if (_selectedDaysOfMonth == null ||
                                _selectedDaysOfMonth!.isEmpty) {
                              showError(
                                "Select at least one day of the month.",
                              );
                              return;
                            }
                          }

                          if (_selectedScheduleUnit == ScheduleUnit.year) {
                            if (scheduleEvery == null || scheduleEvery <= 0) {
                              showError(
                                "'Repeat every' must be a whole number greater than 0.",
                              );
                              return;
                            }

                            if (_selectedDaysOfYear == null ||
                                _selectedDaysOfYear!.isEmpty ||
                                _selectedDaysOfYear!.any(
                                  (selection) =>
                                      selection.selectedMonth == null ||
                                      selection.selectedDaysOfMonth == null ||
                                      selection.selectedDaysOfMonth!.isEmpty,
                                )) {
                              showError(
                                "Select at least one month and one day.",
                              );
                              return;
                            }
                          }

                          notification = NotificationRuleModel(
                            title: title,
                            content: description,
                            colorTag: _selectedColorTag,
                            repetitionType: _selectedRepetitionType,
                            startDate: _selectedDateTime!,
                            bypassDnd: _isDndEnabled,
                            scheduleUnit: _selectedScheduleUnit,
                            scheduleEvery: scheduleEvery,
                            selectedDaysOfWeek:
                                _selectedScheduleUnit == ScheduleUnit.week ||
                                    (_selectedScheduleUnit ==
                                            ScheduleUnit.day &&
                                        _selectedDailyOption !=
                                            DailyOption.allDays)
                                ? _selectedDaysOfWeek
                                : null,
                            selectedMonthDays:
                                _selectedScheduleUnit == ScheduleUnit.year
                                ? _selectedDaysOfYear
                                : _selectedScheduleUnit == ScheduleUnit.month
                                ? [
                                    MonthDaysRepetition(
                                      selectedMonth: null,
                                      selectedDaysOfMonth: _selectedDaysOfMonth,
                                    ),
                                  ]
                                : null,
                          );
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
                    _selectedColorTag = value;
                  });
                },
                child: AnimatedScale(
                  scale: _selectedColorTag == value ? 1.14 : 1.0,
                  duration: 200.ms,
                  curve: Curves.easeOut,
                  child: AnimatedContainer(
                    duration: 200.ms,
                    curve: Curves.easeOut,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      boxShadow: value == _selectedColorTag
                          ? [
                              BoxShadow(
                                color: value.value,
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                      shape: BoxShape.circle,
                      border: _selectedColorTag == value
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
                  _selectedColorTag = null;
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
          isSelected: _selectedRepetitionType == RepetitionType.oneTime,
          onPressed: () {
            setState(() {
              if (_selectedDateTime != null) {
                _selectedDateTime = null;
              }
              _selectedRepetitionType = RepetitionType.oneTime;
            });
          },
        ),

        NotificationOutlinedButton(
          label: "Repetitive",
          isSelected: _selectedRepetitionType == RepetitionType.repetitive,
          onPressed: () {
            setState(() {
              if (_selectedDateTime != null) {
                _selectedDateTime = null;
              }
              _selectedRepetitionType = RepetitionType.repetitive;
              if (_scheduleEveryController.text.isEmpty) {
                _scheduleEveryController.text = "1";
              }
              _selectedDateTime = DateTime.now();
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
        const CreationScreenTitle(title: "Options"),
        SizedBox(height: 5),
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
          label: _selectedDateTime != null
              ? DateFormat.yMMMd().format(_selectedDateTime!)
              : "Select Date",
          isExpanded: true,
          isSelected: _selectedDateTime != null,
          icon: const Icon(
            Icons.calendar_today,
            color: Colors.indigoAccent,
            size: 20,
          ),
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: _selectedDateTime ?? DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
            );

            if (pickedDate != null) {
              setState(() {
                _selectedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  _selectedDateTime?.hour ?? 0,
                  _selectedDateTime?.minute ?? 0,
                );
              });
            }
          },
        ),
        SizedBox(height: 10),
        NotificationOutlinedButton(
          label:
              (_selectedDateTime != null &&
                  (_selectedDateTime!.hour != 0 ||
                      _selectedDateTime!.minute != 0))
              ? DateFormat.jm().format(_selectedDateTime!)
              : "Select Time",
          isExpanded: true,
          isSelected:
              _selectedDateTime != null &&
              (_selectedDateTime!.hour != 0 || _selectedDateTime!.minute != 0),
          icon: const Icon(
            Icons.access_time,
            color: Colors.indigoAccent,
            size: 20,
          ),
          onPressed: () async {
            if (_selectedDateTime == null) {
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
                _selectedDateTime = DateTime(
                  _selectedDateTime!.year,
                  _selectedDateTime!.month,
                  _selectedDateTime!.day,
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
                isSelected: _selectedScheduleUnit == ScheduleUnit.day,
                onPressed: () {
                  setState(() {
                    _selectedScheduleUnit = ScheduleUnit.day;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Week",
                isSelected: _selectedScheduleUnit == ScheduleUnit.week,
                onPressed: () {
                  setState(() {
                    _selectedScheduleUnit = ScheduleUnit.week;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Month",
                isSelected: _selectedScheduleUnit == ScheduleUnit.month,
                onPressed: () {
                  setState(() {
                    _selectedScheduleUnit = ScheduleUnit.month;
                  });
                },
              ),
              NotificationOutlinedButton(
                label: "Year",
                isSelected: _selectedScheduleUnit == ScheduleUnit.year,
                onPressed: () {
                  setState(() {
                    _selectedScheduleUnit = ScheduleUnit.year;
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
                          _selectedDateTime != null &&
                          _selectedDateTime!.isBefore(DateTime.now()),

                      centerText: true,
                      icon: null,
                      onPressed: () {
                        setState(() {
                          _selectedDateTime = DateTime.now();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: NotificationOutlinedButton(
                      label:
                          _selectedDateTime != null &&
                              _selectedDateTime!.isAfter(DateTime.now())
                          ? DateFormat.yMd().add_jm().format(_selectedDateTime!)
                          : "Pick date & time",
                      isExpanded: true,
                      isSelected:
                          _selectedDateTime != null &&
                          _selectedDateTime!.isAfter(DateTime.now()),
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
                          initialDate: _selectedDateTime ?? DateTime.now(),
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
                                _selectedDateTime = pickedDateTime;
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
              (_selectedScheduleUnit == ScheduleUnit.day &&
                  (_selectedDailyOption == DailyOption.weekdays ||
                      _selectedDailyOption == DailyOption.weekends))
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
                          key: ValueKey<String>(_selectedScheduleUnit.name),
                          "${_selectedScheduleUnit.name[0].toUpperCase()}${_selectedScheduleUnit.name.substring(1)} (s)",
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
            return FadeTransition(opacity: animation, child: child);
          },
          child: switch (_selectedScheduleUnit) {
            ScheduleUnit.day => buildDayOptions(),
            ScheduleUnit.week => buildWeekOptions(),
            ScheduleUnit.month => buildMonthOptions(),
            ScheduleUnit.year => buildYearOptions(),
          },
        ),
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
          isSelected: _selectedDailyOption == DailyOption.allDays,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _selectedDailyOption = DailyOption.allDays;
            });
          },
        ),
        NotificationOutlinedButton(
          label: "Weekdays",
          isExpanded: false,
          isSelected: _selectedDailyOption == DailyOption.weekdays,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _selectedDailyOption = DailyOption.weekdays;
            });
          },
        ),
        NotificationOutlinedButton(
          label: "Weekends",
          isExpanded: false,
          isSelected: _selectedDailyOption == DailyOption.weekends,
          centerText: true,
          icon: null,
          onPressed: () {
            setState(() {
              _selectedDailyOption = DailyOption.weekends;
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
                    isFirstOfMonthSelected != null &&
                    isFirstOfMonthSelected == true,
                centerText: true,
                icon: null,
                onPressed: () {
                  setState(() {
                    if (isFirstOfMonthSelected == true) {
                      isFirstOfMonthSelected = null;
                      selectedDaysOfMonth.clear();
                      _selectedDaysOfMonth = null;
                      return;
                    }
                    isFirstOfMonthSelected = true;

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
                    isFirstOfMonthSelected != null &&
                    isFirstOfMonthSelected == false,
                centerText: true,
                icon: null,
                onPressed: () {
                  setState(() {
                    if (isFirstOfMonthSelected == false) {
                      isFirstOfMonthSelected = null;
                      selectedDaysOfMonth.clear();
                      _selectedDaysOfMonth = null;
                      return;
                    }
                    isFirstOfMonthSelected = false;

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
                        isFirstOfMonthSelected = true;
                      } else if (selectedDaysOfMonth.length == 1 &&
                          selectedDaysOfMonth.contains(31)) {
                        isFirstOfMonthSelected = false;
                      } else {
                        isFirstOfMonthSelected = null;
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
