import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/l10n.dart';
import 'package:sideris/themes/app_theme.dart';
import 'package:sideris/widgets/notification_card.dart';

class DndSwitch extends StatelessWidget {
  const DndSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.isSelected,
  });

  final bool value;
  final bool? isSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = isSelected ?? false;
    return NotificationCard(
      isSelected: selected,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.appColors.surfaceOverlay,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.do_not_disturb_on_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.dndSwitchTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                context.l10n.dndSwitchSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          Spacer(),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
