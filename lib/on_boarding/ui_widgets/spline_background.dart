import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../app_assets.dart';

class SplineBackground extends StatelessWidget {
  const SplineBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Center(
        child: OverflowBox(
          maxWidth: double.infinity,
          child: Transform.translate(
            offset: const Offset(200, 100),
            child: Image.asset(AssetPaths.spline, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}