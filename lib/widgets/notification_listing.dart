import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/l10n/enum_labels.dart';
import 'package:sideris/l10n/l10n.dart';
import 'package:sideris/models/notification_rule_model.dart';

class NotificationListing extends StatelessWidget {
  final NotificationRuleModel notification;
  const NotificationListing({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final font = appFontOf(context);
    final l10n = context.l10n;
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
                                  style: font(
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
                                              style: font(
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
                                    label: _durationLabel(context),
                                  ),
                                if (notification.bypassDnd)
                                  _InfoPill(
                                    icon: Icons.do_not_disturb_on_outlined,
                                    label: l10n.listingBypassDnd,
                                  ),

                                Text(
                                  _secondaryDetails(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: font(
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
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    if (notification.isOneTime) {
      return l10n.listingScheduleOnce(
        DateFormat('EEE, MMM d', locale).format(notification.startDate),
      );
    }

    if (notification.isSpecific &&
        notification.fixedTimes?.isNotEmpty == true) {
      final times = notification.fixedTimes!
          .map((time) => time.format(context))
          .join(', ');
      final unit = (notification.scheduleUnit ?? ScheduleUnit.daily).unit(
        notification.scheduleEvery ?? 1,
        l10n,
      );
      final every = notification.scheduleEvery ?? 1;
      return every == 1
          ? l10n.listingScheduleEveryUnit(unit, times)
          : l10n.listingScheduleEveryCount(every, unit, times);
    }

    if (notification.isRandom &&
        notification.randomCount != null &&
        notification.randomCount! > 0 &&
        notification.randomWindowStart != null &&
        notification.randomWindowEnd != null) {
      return l10n.listingScheduleRandom(
        notification.randomCount!,
        notification.randomWindowStart!.format(context),
        notification.randomWindowEnd!.format(context),
      );
    }

    if (notification.isInterval &&
        notification.intervalEvery != null &&
        notification.intervalEvery! > 0 &&
        notification.intervalUnit != null &&
        notification.intervalWindowStart != null &&
        notification.intervalWindowEnd != null) {
      final unit = notification.intervalUnit!.unit(
        notification.intervalEvery!,
        l10n,
      );
      return l10n.listingScheduleInterval(
        notification.intervalEvery!,
        unit,
        notification.intervalWindowStart!.format(context),
        notification.intervalWindowEnd!.format(context),
      );
    }

    return l10n.listingScheduleFallback;
  }

  String _durationLabel(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    if (notification.isForever) return l10n.durationOptionForever;
    if (notification.endDate != null) {
      return l10n.listingDurationUntil(
        DateFormat('MMM d, yyyy', locale).format(notification.endDate!),
      );
    }
    if (notification.totalOccurrences != null) {
      return l10n.listingDurationRemaining(notification.totalOccurrences!);
    }
    return l10n.listingDurationLimited;
  }

  String _secondaryDetails(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final details = <String>[];

    if (notification.isScheduled) details.add(l10n.listingDetailScheduled);
    if (notification.totalOccurrences != null) {
      details.add(
        l10n.listingDetailOccurrences(notification.totalOccurrences!),
      );
    }
    if (notification.lastTriggeredAt != null) {
      details.add(
        l10n.listingDetailLastSent(
          DateFormat(
            'MMM d, HH:mm',
            locale,
          ).format(notification.lastTriggeredAt!),
        ),
      );
    }

    return details.isEmpty
        ? notification.updatedAt == null
              ? l10n.listingDetailCreated(
                  DateFormat(
                    'MMM d, yyyy',
                    locale,
                  ).format(notification.createdAt!),
                )
              : l10n.listingDetailUpdated(
                  DateFormat(
                    'MMM d, yyyy',
                    locale,
                  ).format(notification.updatedAt!),
                )
        : details.join(l10n.listingSeparator);
  }
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
    final font = appFontOf(context);
    final l10n = context.l10n;
    final icon = isNotificationActive
        ? Icons.notifications_active_outlined
        : Icons.notifications_off_outlined;
    final label = isNotificationActive
        ? l10n.listingStatusActive
        : l10n.listingStatusPaused;
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
            style: font(
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
    final font = appFontOf(context);

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
              style: font(color: Colors.white60, fontSize: 11),
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
    final font = appFontOf(context);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final time = trigger == null
        ? '--:--'
        : DateFormat('HH:mm', locale).format(trigger!);
    final relative = trigger == null
        ? l10n.listingNotScheduled
        : _relativeTime(trigger!, l10n);

    final difference = trigger?.difference(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 3,
      children: [
        Text(
          time,
          style: font(
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
                l10n.listingRelativeIn,
                style: font(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              relative,
              style: font(
                color: accent,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (difference != null && difference.isNegative) ...[
              const SizedBox(width: 4),
              Text(
                l10n.listingRelativeAgo,
                style: font(
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

  String _relativeTime(DateTime value, AppLocalizations l10n) {
    final difference = value.difference(DateTime.now());
    final totalMinutes = difference.inMinutes.abs();
    if (totalMinutes == 0) return l10n.listingRelativeNow;

    var remainingMinutes = totalMinutes;
    final days = remainingMinutes ~/ Duration.minutesPerDay;
    final years = days ~/ 365;
    remainingMinutes %= Duration.minutesPerDay;
    final hours = remainingMinutes ~/ Duration.minutesPerHour;
    final minutes = remainingMinutes % Duration.minutesPerHour;

    if (years > 0) return l10n.listingRelativeYears(years);
    if (days > 0) return l10n.listingRelativeDays(days);

    final parts = <String>[];
    if (hours > 0) parts.add(l10n.listingRelativeHours(hours));
    if (minutes > 0) {
      if (parts.isNotEmpty) parts.add("\n");
      parts.add(l10n.listingRelativeMinutes(minutes));
    }

    return parts.join(' ');
  }
}
