import 'dart:developer';
import 'dart:math' hide log;

import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/utils/constants.dart';
import 'package:sideris/utils/general_utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayList extends StatelessWidget {
  final List<NotificationRuleModel> notifications;

  const DayList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onSurface.withAlpha(150),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formateDate(notifications[0].startDate),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(color: colorScheme.onSurface.withAlpha(150)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  notifications[index].title,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface.withAlpha(190),
                  ),
                ),
                subtitle: Text(
                  formateTime(notifications[index].startDate),
                  style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
                ),
                leading: Icon(
                  Icons.notifications,
                  color: notifications[index].startDate.isBefore(DateTime.now())
                      ? colorScheme.onSurface.withAlpha(150)
                      : colorScheme.primary,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final cubit = context.read<NotificationCubit>();
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      final deleted = await cubit.deleteNotification(
                        notifications[index].id,
                      );
                      log(
                        "Deleting notification with id: ${notifications[index].id.clamp(-pow(2, 31), pow(2, 31) - 1).toInt()}",
                      );

                      log(
                        "Showing snackbar for deleted notification with id: ${notifications[index].id}",
                      );
                      messenger.showSnackBar(
                        SnackBar(
                          backgroundColor: colorScheme.surfaceContainer,
                          content: Text(
                            "Reminder deleted successfully!",
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () async {
                              try {
                                await cubit.addNotification(deleted);
                                messenger.hideCurrentSnackBar();
                                messenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        colorScheme.surfaceContainer,
                                    content: Text(
                                      "Reminder restored successfully!",
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              } catch (e) {
                                messenger.hideCurrentSnackBar();
                                messenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor: colorScheme.errorContainer,
                                    content: Text(
                                      "Failed to restore reminder: $e",
                                      style: TextStyle(
                                        color: colorScheme.onErrorContainer,
                                      ),
                                    ),
                                    action: SnackBarAction(
                                      label: "Retry",
                                      onPressed: () async {
                                        try {
                                          await cubit.addNotification(deleted);
                                          messenger.showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  colorScheme.surfaceContainer,
                                              content: Text(
                                                "Reminder restored successfully!",
                                                style: TextStyle(
                                                  color: colorScheme.onSurface,
                                                ),
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          messenger.hideCurrentSnackBar();
                                          messenger.showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  colorScheme.errorContainer,
                                              content: Text(
                                                "Failed to restore reminder: $e",
                                                style: TextStyle(
                                                  color: colorScheme
                                                      .onErrorContainer,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    } catch (e) {
                      messenger.showSnackBar(
                        SnackBar(
                          backgroundColor: colorScheme.errorContainer,
                          content: Text(
                            "Failed to delete reminder: $e",
                            style: TextStyle(
                              color: colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.delete_outlined),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
