import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  const MainText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}