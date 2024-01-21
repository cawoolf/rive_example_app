import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../app_assets.dart';

class StartCourseButton extends StatelessWidget {
  const StartCourseButton({
    super.key,
    required RiveAnimationController btnController,
  }) : _btnController = btnController;

  final RiveAnimationController _btnController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 236,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Stack(
            children: [
              RiveAnimation.asset(
                AssetPaths.buttonRiv,
                fit: BoxFit.cover,
                controllers: [_btnController],
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(4, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_forward_rounded),
                      SizedBox(width: 4),
                      Text(
                        "Start the course",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _btnController.isActive = true;
      },
    );
  }
}
