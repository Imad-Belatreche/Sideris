import 'package:sideris/utils/constants.dart';
import 'package:material_ui/material_ui.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              width: 110,
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: colorScheme.primary.withAlpha(150),
                  onTap: () async {
                    // Show time picker dialog
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text("Pick a time")),
                  ),
                ),
              ),
            ),
            Text(
              "Select time",
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withAlpha(190),
              ),
            ),
          ],
        ),

        Text(
          "Remind me at",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            SizedBox(
              width: 110,
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: colorScheme.primary.withAlpha(150),
                  onTap: () async {
                    // Show date picker dialog
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text("Pick a date (default: today)")),
                  ),
                ),
              ),
            ),
            Text(
              "Select date",
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withAlpha(190),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
