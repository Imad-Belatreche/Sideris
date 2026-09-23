import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/utils/general_utils.dart';
import 'package:sideris/widgets/notification_outlined_button.dart';

class CalendarDay extends StatelessWidget {
  final DateTime currentDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDayPress;
  final NotificationState state;
  final List<Color> Function(DateTime date, NotificationState state)
  getColorsOfDate;

  final VoidCallback onRightPressed;
  final VoidCallback onLeftPressed;
  const CalendarDay({
    super.key,
    required this.currentDate,
    required this.selectedDate,
    required this.getColorsOfDate,
    required this.onDayPress,
    required this.state,
    required this.onRightPressed,
    required this.onLeftPressed,
  });

  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 7, spreadRadius: 2)],
      ),
    );
  }

  Widget _horizontalDots(List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 2,
      children: [
        for (var index = 0; index < 5; index++)
          _dot(index < colors.length ? colors[index] : Colors.transparent),
      ],
    );
  }

  Widget _verticalDots(List<Color> colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 2,
      children: [
        for (var index = 0; index < 5; index++)
          _dot(index < colors.length ? colors[index] : Colors.transparent),
      ],
    );
  }

  Widget _dayContent(int dayNumber, List<Color> colors) {
    final top = colors.sublist(0, colors.length.clamp(0, 5));
    final bottom = colors.length > 5
        ? colors.sublist(5, colors.length.clamp(5, 10))
        : <Color>[];
    final left = colors.length > 10
        ? colors.sublist(10, colors.length.clamp(10, 15))
        : <Color>[];
    final right = colors.length > 15
        ? colors.sublist(15, colors.length.clamp(15, 20))
        : <Color>[];

    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Text(
              '$dayNumber',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Positioned(top: 3, left: 4, right: 4, child: _horizontalDots(top)),
          Positioned(
            bottom: 3,
            left: 4,
            right: 4,
            child: _horizontalDots(bottom),
          ),
          Positioned(left: 3, top: 4, bottom: 4, child: _verticalDots(left)),
          Positioned(right: 3, top: 4, bottom: 4, child: _verticalDots(right)),
        ],
      ),
    );
  }

  List<String> getDayNames() {
    return List.generate(
      7,
      (index) => DateFormat.E().format(DateTime(2021, 1, index + 4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12, width: 2),
            color: Colors.white.withAlpha(3),
          ),
          child: Column(
            spacing: 25,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        minimumSize: Size(35, 35),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onLeftPressed,
                      icon: Icon(Icons.keyboard_double_arrow_left, size: 30),
                    ),
                    Text(
                      DateFormat.yMMM().format(currentDate),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: onRightPressed,
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        minimumSize: Size(35, 35),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(Icons.keyboard_double_arrow_right, size: 30),
                    ),
                  ],
                ),
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                mainAxisExtent: 56,
                crossAxisCount: 7,
                shrinkWrap: true,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  for (var weekName in getDayNames())
                    Text(
                      weekName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 17,
                        letterSpacing: 1,
                        color: Colors.white.withAlpha(210),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ...List.generate(
                    DateTime(currentDate.year, currentDate.month, 1).weekday -
                        1,
                    (_) => const SizedBox.shrink(),
                  ),
                  for (var dayNumber in List.generate(
                    DateTime(currentDate.year, currentDate.month + 1, 0).day,
                    (index) => index + 1,
                  ))
                    Builder(
                      builder: (context) {
                        final day = DateTime(
                          currentDate.year,
                          currentDate.month,
                          dayNumber,
                        );

                        final colors = getColorsOfDate(
                          day,
                          state,
                        ).take(20).toList();

                        return NotificationOutlinedButton(
                          label: "",
                          labelWidget: _dayContent(dayNumber, colors),
                          isRounded: false,
                          isExpanded: false,
                          isSelected: dateOnly(selectedDate) == day,
                          padding: EdgeInsets.zero,
                          onPressed: () => onDayPress(day),
                        );
                      },
                    ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
