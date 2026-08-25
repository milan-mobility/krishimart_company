import 'package:flutter/material.dart';
import 'package:krishi_mart/gen/assets.gen.dart';

class RoleBackgroundWidget extends StatelessWidget {
  const RoleBackgroundWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Column(
          children: <Widget>[
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Transform.rotate(
                  angle: -.18,
                  child: Image.asset(Assets.png.icRoleBgLeft.path),
                ),
                Transform.rotate(
                  angle: .18,
                  child: Image.asset(Assets.png.icRoleBgRight.path),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
