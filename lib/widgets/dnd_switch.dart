import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/l10n/l10n.dart';
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
    final font = appFontOf(context);

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
              color: Colors.white.withValues(alpha: 0.1),
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
                style: font(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                context.l10n.dndSwitchSubtitle,
                style: font(color: Colors.white.withValues(alpha: 0.6)),
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
