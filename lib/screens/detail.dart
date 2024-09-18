import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:journey_world/models/point.dart';

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
    return Scaffold(
      body: Hero(
        tag: widget.point.alignment,
        child: Container(
          height: size.height,
          width: size.width,
          child: Material(
              color: widget.point.color, child: Center(child: Text("Detail"))),
        ),
      ),
    );
  }
}
