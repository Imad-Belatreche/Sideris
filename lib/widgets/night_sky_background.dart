import 'dart:math' hide log;

import 'package:flutter/material.dart';

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
}

class ShootingStar {
  final double startX; // Normalized start X (0.0 - 1.0)
  final double startY; // Normalized start Y (0.0 - 1.0)
  final double length; // Length of tail in pixels
  final double angle; // Angle in radians
  final double speedMultiplier;
  final double delay;
  double progress = 0.0; // Flight completion (0.0 to 1.0)

  ShootingStar({
    required this.startX,
    required this.startY,
    required this.length,
    required this.angle,
    this.speedMultiplier = 1.0,
    this.delay = 0.0,
  });

  double get activeProgress {
    if (progress < delay) return 0.0;
    // Map progress from delay..1.0 to 0.0..1.0
    return ((progress - delay) / (1.0 - delay)).clamp(0.0, 1.0);
  }

  bool get hasStarted => progress >= delay;
}

class NightSkyBackground extends StatefulWidget {
  final Widget child;
  const NightSkyBackground({super.key, required this.child});

  @override
  State<NightSkyBackground> createState() => _NightSkyBackgroundState();
}

class _NightSkyBackgroundState extends State<NightSkyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<ShootingStar> _shootingStars = [];
  final List<Star> _stars = [];
  final Random _random = Random();

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 150; i++) {
      _stars.add(
        Star(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 2.0 + 0.8,
          opacity: _random.nextDouble() * 0.7 + 0.3,
        ),
      );
    }

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {
              if (_shootingStars.isEmpty && _random.nextDouble() < 0.02) {
                int groupCount = 1 + _random.nextInt(3);
                for (int i = 0; i < groupCount; i++) {
                  _shootingStars.add(
                    ShootingStar(
                      // Slight positional scatter for the cluster
                      startX: _random.nextDouble() * 0.7,
                      startY: _random.nextDouble() * 0.4,
                      length: 100 + _random.nextDouble() * 100,
                      angle: pi / 4,
                      // Vary speeds slightly so they pass each other
                      speedMultiplier: 0.8 + _random.nextDouble() * 0.5,
                      delay: i == 0 ? 0.0 : _random.nextDouble() * 0.3,
                    ),
                  );
                }
              } else if (_shootingStars.isNotEmpty) {
                _shootingStars.removeWhere((star) {
                  star.progress += 0.01 * star.speedMultiplier;
                  return star.progress >= 1.0;
                });
              }
            });
          })
          ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [Color(0xFF03071E), Color(0xFF0B091A), Color(0xFF161233)],
        ),
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _scrollOffset = notification.metrics.pixels;
            });
          }
          return false;
        },
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.1, 0.90, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: CustomPaint(
                size: Size.infinite,
                painter: StarPainter(
                  stars: _stars,
                  scrollOffset: _scrollOffset,
                  shootingStars: _shootingStars,
                ),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double scrollOffset;
  final List<ShootingStar> shootingStars;

  StarPainter({
    required this.stars,
    required this.scrollOffset,
    required this.shootingStars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var star in stars) {
      final double rawY = star.y * size.height - (scrollOffset * 0.2);
      double starY = rawY % size.height;
      if (starY < 0) {
        starY += size.height;
      }

      final double pixelX = star.x * size.width;

      paint.color = Colors.white.withValues(alpha: star.opacity);
      canvas.drawCircle(Offset(pixelX, starY), star.size, paint);
    }

    for (var shootingStar in shootingStars) {
      if (!shootingStar.hasStarted) continue;

      final s = shootingStar;
      final p = s.activeProgress;

      final headX =
          s.startX * size.width + cos(s.angle) * (s.length * s.progress * 3);
      final headY =
          s.startY * size.height + sin(s.angle) * (s.length * s.progress * 3);
      final head = Offset(headX, headY);

      double currentTailLength = s.length;
      if (p < 0.2) {
        currentTailLength = s.length * (p / 0.2);
      } else if (p > 0.8) {
        currentTailLength = s.length * ((1.0 - p) / 0.2);
      }
      final tail = Offset(
        head.dx - cos(s.angle) * currentTailLength,
        head.dy - sin(s.angle) * currentTailLength,
      );

      final streakPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent, // Faded tail
            const Color.fromARGB(200, 255, 255, 255).withValues(
              alpha: 1.0 - s.progress,
            ), // Bright head (fades as it finishes)
          ],
        ).createShader(Rect.fromPoints(head, tail))
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(head, tail, streakPaint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
