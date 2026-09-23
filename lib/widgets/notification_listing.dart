import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/models/notification_rule_model.dart';

class NotificationListing extends StatelessWidget {
  final NotificationRuleModel notification;
  const NotificationListing({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final accent = notification.colorTag?.value ?? Colors.white70;
    final isActive = notification.isActive;
    final nextTrigger =
        notification.nextTriggerAt != null &&
            notification.nextTriggerAt!.isAfter(DateTime.now())
        ? notification.nextTriggerAt
        : notification.lastTriggeredAt;

    return AnimatedOpacity(
      duration: 250.ms,
      opacity: isActive ? 1 : 0.58,
      child:
          Card(
                color: const Color.fromARGB(10, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  side: BorderSide(color: Colors.white24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Row(
                        children: [
                          _AccentDot(color: accent),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                AnimatedSwitcher(
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  duration: 250.ms,
                                  child: notification.content != null
                                      ? Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Text(
                                              notification.content!,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.outfit(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          _StatusBadge(isNotificationActive: isActive),
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              direction: Axis.horizontal,
                              children: [
                                _InfoPill(
                                  icon: Icons.repeat,
                                  label: _scheduleLabel(context),
                                ),
                                if (notification.repetitionType ==
                                    RepetitionType.repetitive)
                                  _InfoPill(
                                    icon: Icons.hourglass_bottom_rounded,
                                    label: _durationLabel(),
                                  ),
                                if (notification.bypassDnd)
                                  const _InfoPill(
                                    icon: Icons.do_not_disturb_on_outlined,
                                    label: 'Bypass DND',
                                  ),

                                Text(
                                  _secondaryDetails(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          _NextTrigger(
                            trigger: nextTrigger,
                            accent: accent,
                            isActive: notification.isActive,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 350.ms)
              .slideY(begin: 0.04, duration: 350.ms),
    );
  }

  String _scheduleLabel(BuildContext context) {
    if (notification.isOneTime) {
      return 'Once  •  ${DateFormat('EEE, MMM d').format(notification.startDate)}';
    }

    if (notification.isSpecific &&
        notification.fixedTimes?.isNotEmpty == true) {
      final times = notification.fixedTimes!
          .map((time) => time.format(context))
          .join(', ');
      final unit = _pretty(notification.scheduleUnit?.name ?? 'day');
      final every = notification.scheduleEvery ?? 1;
      return every == 1
          ? 'Every $unit  •  $times'
          : 'Every $every $unit\n$times';
    }

    if (notification.isRandom &&
        notification.randomCount != null &&
        notification.randomCount! > 0 &&
        notification.randomWindowStart != null &&
        notification.randomWindowEnd != null) {
      return 'Random  •  ${notification.randomCount ?? 0} times\n${notification.randomWindowStart!.format(context)} - ${notification.randomWindowEnd!.format(context)}';
    }

    if (notification.isInterval &&
        notification.intervalEvery != null &&
        notification.intervalEvery! > 0 &&
        notification.intervalUnit != null &&
        notification.intervalWindowStart != null &&
        notification.intervalWindowEnd != null) {
      final unit = _pretty(notification.intervalUnit?.name ?? 'hour');
      return 'Every ${notification.intervalEvery ?? 1} $unit\n${notification.intervalWindowStart!.format(context)} - ${notification.intervalWindowEnd!.format(context)}';
    }

    return 'Scheduled notification';
  }

  String _durationLabel() {
    if (notification.isForever) return 'Forever';
    if (notification.endDate != null) {
      return 'Until ${DateFormat('MMM d, yyyy').format(notification.endDate!)}';
    }
    if (notification.totalOccurrences != null) {
      return 'Remaining ${notification.totalOccurrences} ${notification.totalOccurrences == 1 ? 'time' : "times"}';
    }
    return 'Limited duration';
  }

  String _secondaryDetails() {
    final details = <String>[];
    if (notification.isScheduled) details.add('Scheduled');
    if (notification.totalOccurrences != null) {
      details.add('${notification.totalOccurrences} occurrences');
    }
    if (notification.lastTriggeredAt != null) {
      details.add(
        'Last sent ${DateFormat('MMM d, HH:mm').format(notification.lastTriggeredAt!)}',
      );
    }
    return details.isEmpty
        ? notification.updatedAt == null
              ? 'Created ${DateFormat('MMM d, yyyy').format(notification.createdAt!)}'
              : 'Updated ${DateFormat('MMM d, yyyy').format(notification.updatedAt!)}'
        : details.join('  •  ');
  }

  String _pretty(String value) => value[0].toUpperCase() + value.substring(1);
}

class _AccentDot extends StatelessWidget {
  final Color color;
  const _AccentDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.75),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isNotificationActive;
  const _StatusBadge({required this.isNotificationActive});

  @override
  Widget build(BuildContext context) {
    final icon = isNotificationActive
        ? Icons.notifications_active_outlined
        : Icons.notifications_off_outlined;
    final label = isNotificationActive ? 'ACTIVE' : 'PAUSED';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: (isNotificationActive ? Colors.blueAccent : Colors.white24)
            .withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: isNotificationActive
                ? Colors.lightBlueAccent
                : Colors.white54,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white54,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(color: Colors.white10),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white.withAlpha(1),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.lightBlueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.outfit(color: Colors.white60, fontSize: 11),
              // overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextTrigger extends StatelessWidget {
  final DateTime? trigger;
  final Color accent;
  final bool isActive;
  const _NextTrigger({
    required this.trigger,
    required this.accent,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final time = trigger == null
        ? '--:--'
        : DateFormat('HH:mm').format(trigger!);
    final relative = trigger == null
        ? 'Not scheduled'
        : _relativeTime(trigger!);

    final difference = trigger?.difference(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 3,
      children: [
        Text(
          time,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule_rounded, size: 14, color: accent),
            const SizedBox(width: 4),
            if (difference != null && !difference.isNegative) ...[
              Text(
                "in",
                style: GoogleFonts.outfit(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              relative,
              style: GoogleFonts.outfit(
                color: accent,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (difference != null && difference.isNegative) ...[
              const SizedBox(width: 4),
              Text(
                "ago",
                style: GoogleFonts.outfit(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  String _relativeTime(DateTime value) {
    final difference = value.difference(DateTime.now());
    final totalMinutes = difference.inMinutes.abs();
    if (totalMinutes == 0) return 'Now';

    var remainingMinutes = totalMinutes;
    final days = remainingMinutes ~/ Duration.minutesPerDay;
    final years = days ~/ 365;
    remainingMinutes %= Duration.minutesPerDay;
    final hours = remainingMinutes ~/ Duration.minutesPerHour;
    final minutes = remainingMinutes % Duration.minutesPerHour;

    final parts = <String>[];
    if (years > 0) {
      parts.add('$years ${years == 1 ? 'year' : 'years'}');
      final label = parts.join(' ');
      return label;
    }

    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
      final label = parts.join(' ');
      return label;
    }

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    if (minutes > 0) {
      parts.add("\n");
      parts.add('$minutes ${minutes == 1 ? 'min' : 'mins'}');
    }

    final label = parts.join(' ');
    return label;
  }
}
