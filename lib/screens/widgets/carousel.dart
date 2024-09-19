// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:journey_world/models/map_point.dart';
import 'package:journey_world/screens/detail.dart';
import 'package:journey_world/screens/home.dart';
import 'package:journey_world/screens/widgets/video_container.dart';
import 'package:video_player/video_player.dart';

class Carousel extends StatefulWidget {
  MapPoint? currentPoint;
  Function(int, CarouselPageChangedReason)? onPageChanged;
  Carousel({super.key, this.onPageChanged, this.currentPoint});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<MapPoint> _points = [];
  @override
  void initState() {
    super.initState();
    _points = points.asMap().entries.map((entry) {
      MapPoint point = entry.value;
      point.controller = VideoPlayerController.asset(point.video)
        ..initialize().then((_) {
          if (entry.key == 0) {
            point.controller!.play();
          }
        });
      return point;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _points.map((point) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(point: point)));
                },
                child: VideoContainer(point: point),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          aspectRatio: 1,
          viewportFraction: 0.7,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          // autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0,
          onPageChanged: (index, reason) {
            widget.onPageChanged?.call(index, reason);
            MapPoint point = points[index];
            point.controller?.play();
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
