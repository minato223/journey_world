import 'dart:math';

import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_image.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:journey_world/models/gallery_image.dart';

List<GalleryImage> images = [
  GalleryImage(image: AppImage.img1, angle: 0),
  GalleryImage(image: AppImage.img2, angle: cos(30)),
  GalleryImage(image: AppImage.img3, angle: -cos(30)),
];

class GalleryContainer extends StatelessWidget {
  const GalleryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...images.reversed.map((image) {
          return _buildImage(image);
        }),
      ],
    );
  }

  Widget _buildImage(GalleryImage image) {
    return Builder(builder: (context) {
      AppSize size = AppSize(context);
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(image.angle * 80, 0.0)
          ..rotateZ(image.angle),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(size.height * .003),
          margin: EdgeInsets.fromLTRB(
              size.extraLarge, size.medium, size.medium, size.medium),
          height: size.height * .06,
          width: size.height * .05,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 211, 210, 210),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(image.image, fit: BoxFit.cover)),
        ),
      );
    });
  }
}
