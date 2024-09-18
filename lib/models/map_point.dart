import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MapPoint {
  AlignmentGeometry alignment;
  Color color;
  String video;
  String emoji;
  VideoPlayerController? controller;
  double price;
  String name;

  MapPoint({
    required this.alignment,
    required this.color,
    required this.video,
    required this.emoji,
    required this.price,
    required this.name,
    this.controller,
  });
}
