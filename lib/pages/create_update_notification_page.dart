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
import 'package:sideris/widgets/notification_outlined_button.dart';
import 'package:sideris/widgets/notification_textfield.dart';

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
  bool _isDndEnabled = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
                Text(
                  "Title".toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.white24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _titleController,
                  hintText: 'Notification title',
                  maxLines: 1,
                ),
                SizedBox(height: 16),

                Text(
                  "${"Content".toUpperCase()} (optional)",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.white24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                NotificationTextfield(
                  controller: _descriptionController,
                  hintText: 'Add details...',
                  maxLines: 3,
                ),
                SizedBox(height: 16),

                Text(
                  "Color Tag".toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.white24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                buildColorTagSelector(),
                Text(
                  "Type".toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.white24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                buildRepetitionTypeSelector(),
                SizedBox(height: 16),
                buildOneTime(),
                SizedBox(height: 16),
                buildOptions(),
                SizedBox(height: 30),

                Align(
                  alignment: Alignment.center,
                  child: NotificationOutlinedButton(
                    label: "Create Notification",
                    isSelected: true,
                    onPressed: () async {
                      if (_titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Title cannot be empty."),
                          ),
                        );
                        return;
                      }
                      if (_selectedRepetitionType == RepetitionType.oneTime &&
                          _selectedDateTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a date and time."),
                          ),
                        );
                        return;
                      }

                      if (_selectedRepetitionType == RepetitionType.oneTime &&
                          _selectedDateTime != null &&
                          _selectedDateTime!.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Selected date and time cannot be in the past.",
                            ),
                          ),
                        );
                        return;
                      }

                      final notification = NotificationRuleModel(
                        title: _titleController.text,
                        content: _descriptionController.text,
                        colorTag: _selectedColorTag,
                        repetitionType: _selectedRepetitionType,
                        startDate: _selectedDateTime!,
                        bypassDnd: _isDndEnabled,
                        recurrenceType: null,
                        isForever: false,
                      );

                      await ensureNotificationPermission(context);

                      await notificationCubit.addNotification(notification);

                      log(" Notification added: ${notification.toString()}");
                      //TODO: Make the snackBar look better or pop the page entirely
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Notification saved successfully."),
                        ),
                      );
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
              _selectedRepetitionType = RepetitionType.oneTime;
            });
          },
        ),

        NotificationOutlinedButton(
          label: "Repetitive",
          isSelected: _selectedRepetitionType == RepetitionType.repetitive,
          onPressed: () {
            setState(() {
              _selectedRepetitionType = RepetitionType.repetitive;
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
        Text(
          "Options".toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: Colors.white24,
            fontWeight: FontWeight.w500,
          ),
        ),
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

  Widget buildOneTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date & Time".toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: Colors.white24,
            fontWeight: FontWeight.w500,
          ),
        ),
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
}

Future<void> ensureNotificationPermission(BuildContext context) async {
  final status = await PermissionService.instance
      .checkNotificationPermissionStatus();
  log("Notification permission status before request: $status");

  if (!status.isNotificationPermissionGranted) {
    if (!context.mounted) return;
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
    if (!context.mounted) return;
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
    if (!context.mounted) return;
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
}
