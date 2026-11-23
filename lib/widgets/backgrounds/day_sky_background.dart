import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_colors.dart';

class CloudSpec {
  final String asset;
  final double yFraction; // 0..1 of height
  final double scale; // size multiplier
  final double speed; // px per second
  final double opacity; // 0.15 .. 0.9  ← "barely seen / well seen"
  final double phase; // 0..1 start position along the loop
  final int layer; // 0 = far, 1 = mid, 2 = near

  CloudSpec({
    required this.asset,
    required this.yFraction,
    required this.scale,
    required this.speed,
    required this.opacity,
    required this.phase,
    required this.layer,
  });
}

class DaySkyBackground extends StatefulWidget {
  final Widget child;
  const DaySkyBackground({super.key, required this.child});

  @override
  State<DaySkyBackground> createState() => _DaySkyBackgroundState();
}

class _DaySkyBackgroundState extends State<DaySkyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Random _random = Random();

  final List<CloudSpec> _clouds = [];
  final List<String> _cloudAssets = [
    "assets/clouds/cloud_01.svg",
    "assets/clouds/cloud_02.svg",
    "assets/clouds/cloud_03.svg",
    "assets/clouds/cloud_04.svg",
    "assets/clouds/cloud_05.svg",
    "assets/clouds/cloud_06.svg",
    "assets/clouds/cloud_07.svg",
    "assets/clouds/cloud_08.svg",
    "assets/clouds/cloud_09.svg",
    "assets/clouds/cloud_10.svg",
    "assets/clouds/cloud_11.svg",
    "assets/clouds/cloud_12.svg",
    "assets/clouds/cloud_13.svg",
    "assets/clouds/cloud_14.svg",
    "assets/clouds/cloud_15.svg",
    "assets/clouds/cloud_16.svg",
    "assets/clouds/cloud_17.svg",
  ]..shuffle();

  double _rand(double min, double max) =>
      min + _random.nextDouble() * (max - min);

  @override
  void initState() {
    super.initState();
    final List<String> layer0 = _cloudAssets.sublist(0, 7);
    final List<String> layer1 = _cloudAssets.sublist(7, 13);
    final List<String> layer2 = _cloudAssets.sublist(13, 16);

    for (var i = 0; i < layer0.length; i++) {
      final yFraction = _random.nextDouble();
      final scale = _rand(0.5, 0.7);
      final speed = _rand(6, 10);
      final opacity = _rand(0.2, 0.35);
      final phase = (i + _rand(0.25, 0.75)) / layer0.length;

      _clouds.add(
        CloudSpec(
          asset: layer0[i],
          yFraction: yFraction,
          scale: scale,
          speed: speed,
          opacity: opacity,
          phase: phase,
          layer: 0,
        ),
      );
    }
    for (var i = 0; i < layer1.length; i++) {
      final yFraction = _random.nextDouble();
      final scale = _rand(0.8, 1);
      final speed = _rand(15, 20);
      final opacity = _rand(0.45, 0.60);
      final phase = (i + _rand(0.25, 0.75)) / layer1.length;

      _clouds.add(
        CloudSpec(
          asset: layer1[i],
          yFraction: yFraction,
          scale: scale,
          speed: speed,
          opacity: opacity,
          phase: phase,
          layer: 1,
        ),
      );
    }
    for (var i = 0; i < layer2.length; i++) {
      final yFraction = _random.nextDouble();
      final scale = _rand(1.1, 1.4);
      final speed = _rand(30, 40);
      final opacity = _rand(0.75, 0.95);
      final phase = (i + _rand(0.25, 0.75)) / layer2.length;

      _clouds.add(
        CloudSpec(
          asset: layer2[i],
          yFraction: yFraction,
          scale: scale,
          speed: speed,
          opacity: opacity,
          phase: phase,
          layer: 2,
        ),
      );
    }

    _clouds.shuffle();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  AnimatedBuilder _buildCloud(CloudSpec cloud, double width, double height) {
    final cw = 240 * cloud.scale;
    final travel = width + cw;
    final y = cloud.yFraction * (height - cw);

    return AnimatedBuilder(
      animation: _animationController,
      child: RepaintBoundary(
        child: cloud.layer < 1
            ? SvgPicture.asset(
                cloud.asset,
                width: cw,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: cloud.opacity),
                  BlendMode.srcIn,
                ),
              )
            : Opacity(
                opacity: cloud.opacity,
                child: SvgPicture.asset(cloud.asset, width: cw),
              ),
      ),
      builder: (context, child) {
        final t =
            (_animationController.lastElapsedDuration ?? Duration.zero)
                .inMicroseconds /
            1e6;
        final x = -cw + ((cloud.phase * travel + t * cloud.speed) % travel);
        return Positioned(left: x, top: y, child: child!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.backgroundTop,
            colors.backgroundMid,
            colors.backgroundBottom,
          ],
        ),
      ),
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
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final wd = constraints.maxWidth;
              final hg = constraints.maxHeight;
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  ..._clouds.sublist(0, 10).map((c) => _buildCloud(c, wd, hg)),
                  widget.child,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
