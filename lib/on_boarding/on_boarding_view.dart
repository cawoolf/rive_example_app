import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:rive/rive.dart';
import 'package:rive_example_app/on_boarding/signin_view.dart';
import '../theme.dart';
import 'package:rive_example_app/app_assets.dart';

import '../ui_widgets/start_course_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with TickerProviderStateMixin {
  AnimationController? _signInAnimController;

  // Control touch effect animation for the "Start the Course" button
  late RiveAnimationController _btnController;

  @override
  void initState() {
    super.initState();
    _signInAnimController = AnimationController(
        duration: const Duration(milliseconds: 350),
        upperBound: 1,
        vsync: this);

    _btnController = OneShotAnimation("active", autoplay: false);

    const springDesc = SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5,
    );

    // Controllers the animation that displays the SignInView
    // The model is actually ahove the screen, and slides down into view.
    _btnController.isActiveChanged.addListener(() {
      if (!_btnController.isActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _signInAnimController?.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    _signInAnimController?.dispose();
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        splineBackground(),
        backgroundAnimation(),
        bodyContent(),
        signInButton()
      ]),
    );
  }

  ImageFiltered splineBackground(){
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


  ImageFiltered backgroundAnimation() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      child: const RiveAnimation.asset(AssetPaths.shapesRiv),
    );
  }

  AnimatedBuilder bodyContent() {
    //AnimationBuilder used to shift the content up by 50px whenever the SignIn model is displayed.
    return AnimatedBuilder(
      animation: _signInAnimController!,
      builder: (context, child) {
        return Transform(
            transform: Matrix4.translationValues(
                0, -50 * _signInAnimController!.value, 0),
            child: child);
      },
      child: SafeArea(
        // Causes content to always draw below the "notch" on mobile
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainText(),
              const SizedBox(height: 16),
              // const Spacer(),
              StartCourseButton(btnController: _btnController),
              const SizedBox(height: 16),
              footerText(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded mainText() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 260,
              padding: const EdgeInsets.only(bottom: 16),
              child: const Text(
                "Learn design & code",
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 60),
              ),
            ),
            Text(
              "Don’t skip design. Learn design and code, by building real apps with React and Swift. Complete courses about the best tools.",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontFamily: "Inter",
                  fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Text footerText() {
    return Text(
      "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
      style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontFamily: "Inter",
          fontSize: 13),
    );
  }

  RepaintBoundary signInButton() {
    return RepaintBoundary( // At 0:50min in video. Used to improve performance when redrawing widgets. Use with care. Resource intensive. See docs.
        child: AnimatedBuilder(
          animation: _signInAnimController!,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                    top: 100 - (_signInAnimController!.value * 200),
                    right: 20,
                    child: SafeArea(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(36 / 2),
                        minSize: 36,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(36 / 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10))
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // widget.closeModal!();
                        },
                      ),
                    )),
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: Opacity(
                      opacity: 0.4 * _signInAnimController!.value,
                      child: Container(color: RiveAppTheme.shadow),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(
                    0,
                    -MediaQuery.of(context).size.height *
                        (1 - _signInAnimController!.value),
                  ),
                  child: child,
                ),
              ],
            );
          },
          child: SignInView(
              closeModal: () {
                _signInAnimController?.reverse();
              },
              ),
        ),
      );
  }

}
