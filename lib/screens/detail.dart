// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:journey_world/models/map_point.dart';
import 'package:journey_world/screens/widgets/gallery_container.dart';
import 'package:journey_world/screens/widgets/sky_container.dart';
import 'package:video_player/video_player.dart';

class Detail extends StatefulWidget {
  MapPoint point;
  Detail({super.key, required this.point});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.point.alignment,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Material(
                  color: widget.point.color,
                  child: VideoPlayer(widget.point.controller!)),
            ),
          ),
          Positioned.fill(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Color.fromARGB(165, 0, 0, 0),
                  Colors.transparent,
                  Colors.transparent
                ],
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Hero(
                  tag: "gallery",
                  child: GalleryContainer(),
                ),
                Expanded(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Opacity(
                          opacity: value,
                          child: Container(
                              alignment: Alignment.center,
                              height: size.height * .07,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.extraLarge),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white24),
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.small * 1.5,
                                        horizontal: size.medium),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          CupertinoIcons.bookmark,
                                          color: Colors.white38,
                                          size: theme.titleMedium?.fontSize,
                                        ),
                                        SizedBox(width: size.small),
                                        Text(
                                          "|",
                                          style: theme.titleMedium?.copyWith(
                                            color: Colors.white38,
                                          ),
                                        ),
                                        SizedBox(width: size.small),
                                        Text(
                                          "Book Now",
                                          style: theme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: size.small),
                                        Icon(
                                          CupertinoIcons.heart,
                                          color: Colors.white38,
                                          size: theme.titleMedium?.fontSize,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )));
                    },
                  ),
                ),
                const Hero(
                  tag: "sky",
                  child: SkyContainer(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
