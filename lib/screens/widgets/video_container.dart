// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:journey_world/models/map_point.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulWidget {
  MapPoint point;
  VideoContainer({super.key, required this.point});

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.point.controller != null) {
      _controller = widget.point.controller!..setVolume(0);
    } else {
      _controller = VideoPlayerController.asset(widget.point.video)
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(size.small),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Hero(
            tag: widget.point.alignment,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.large),
                clipBehavior: Clip.hardEdge,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.large),
              color: Colors.black38,
            ),
          )),
          Padding(
            padding: EdgeInsets.all(size.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: size.small),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 4, 52, 92),
                                borderRadius:
                                    BorderRadius.circular(size.medium)),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(height: 1),
                                    children: [
                                      TextSpan(
                                        text: "L",
                                        style: theme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: ".",
                                          style: TextStyle(
                                              fontSize: size.medium,
                                              color: const Color.fromARGB(
                                                  255, 33, 236, 243))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: size.small),
                          Text("9.1",
                              style: theme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Text("\$ ${widget.point.price}",
                        style: theme.titleMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(size.small),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          widget.point.emoji,
                          style: theme.titleLarge,
                        )),
                    SizedBox(height: size.small),
                    Row(
                      children: [
                        Text(
                          widget.point.name,
                          style: theme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
