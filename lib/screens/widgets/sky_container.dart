import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_image.dart';
import 'package:journey_world/constants/app_size.dart';

class SkyContainer extends StatelessWidget {
  const SkyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    return RotatedBox(
      quarterTurns: 2,
      child: Container(
        height: size.height * .05,
        width: size.height * .05,
        margin: EdgeInsets.all(size.medium),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(AppImage.sky), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
