import 'dart:developer';

import 'package:material_ui/material_ui.dart';

class SlideTriggerItem extends StatefulWidget {
  const SlideTriggerItem({
    super.key,
    required this.child,
    required this.onTriggered,
  });
  final Widget child;
  final VoidCallback onTriggered;

  @override
  State<SlideTriggerItem> createState() => _SlideTriggerItemState();
}

class _SlideTriggerItemState extends State<SlideTriggerItem> {
  double _iconDragOffset = 50.0;
  double _dragOffset = 0.0;

  static const double _targetOffset = -80;
  static const double _targetIconOffset = -30;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(_iconDragOffset, 10),
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete_forever, color: Colors.red, size: 30),
          ),
        ),
        Transform.translate(
          offset: Offset(_dragOffset, 0),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragOffset = (_dragOffset + details.delta.dx).clamp(
                  _targetOffset,
                  0,
                );
                _iconDragOffset = (_iconDragOffset + details.delta.dx).clamp(
                  _targetIconOffset,
                  50,
                );
              });
            },
            onHorizontalDragEnd: (details) {
              if (_dragOffset <= _targetOffset) {
                log("Inside _dragOffset");
                setState(() {
                  _dragOffset = _targetOffset;
                  _iconDragOffset = _targetIconOffset;
                });
                widget.onTriggered();
                setState(() {
                  _dragOffset = 0.0;
                  _iconDragOffset = 50.0;
                });
              } else {
                setState(() {
                  _dragOffset = 0.0;
                  _iconDragOffset = 50.0;
                });
              }
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
