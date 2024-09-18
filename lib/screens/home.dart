// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_image.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:journey_world/constants/app_video.dart';
import 'package:journey_world/models/map_point.dart';
import 'package:journey_world/screens/detail.dart';
import 'package:journey_world/screens/widgets/gallery_container.dart';
import 'package:journey_world/screens/widgets/sky_container.dart';
import 'package:video_player/video_player.dart';

List<MapPoint> points = [
  MapPoint(
    alignment: const Alignment(0.5, 0.5),
    color: Colors.amber,
    emoji: "🤩",
    video: AppVideo.v1,
    name: "Dubai Palace",
    price: 100,
  ),
  MapPoint(
    alignment: const Alignment(0, 0),
    color: Colors.teal,
    video: AppVideo.v2,
    emoji: "😎",
    name: "The Ritz Carlton",
    price: 200,
  ),
  MapPoint(
    alignment: const Alignment(.3, -0.2),
    color: Colors.blue,
    video: AppVideo.v3,
    emoji: "😍",
    name: "The Venetian",
    price: 300,
  ),
  MapPoint(
    alignment: const Alignment(-.3, -0.5),
    color: Colors.red,
    video: AppVideo.v4,
    emoji: "📸",
    name: "The Ritz",
    price: 400,
  ),
  MapPoint(
    alignment: const Alignment(-.2, 0.2),
    color: Colors.purple,
    video: AppVideo.v5,
    emoji: "👑",
    name: "The Venetian",
    price: 500,
  ),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MapPoint currentPoint;

  @override
  void initState() {
    super.initState();
    currentPoint = points[0];
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 52, 68, 75),
              Color.fromARGB(255, 211, 210, 210),
              Color.fromARGB(255, 200, 198, 198),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
                height: size.height * .6,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.medium),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Dubai",
                              overflow: TextOverflow.ellipsis,
                              style: theme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: size.extraLarge,
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                              width: size.width,
                              child: Carousel(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentPoint = points[index];
                                  });
                                },
                                currentPoint: currentPoint,
                              ))),
                    ],
                  ),
                )),
            Expanded(
                child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildIconContainer(CupertinoIcons.calendar),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child:
                      _buildIconContainer(CupertinoIcons.slider_horizontal_3),
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(tag: "gallery", child: GalleryContainer())),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Hero(
                    tag: "sky",
                    child: SkyContainer(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height * .3,
                    width: size.height * .3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppImage.map), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height * .3,
                    width: size.height * .3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          const Color.fromARGB(255, 5, 36, 83).withOpacity(.5),
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  alignment: currentPoint.alignment,
                  child: _buildCursor(),
                ),
                ...points.map((point) {
                  return Align(
                    alignment: point.alignment,
                    child: _buildPoint(point),
                  );
                }),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon) {
    return Builder(builder: (context) {
      AppSize size = AppSize(context);
      return Container(
          padding: EdgeInsets.all(size.medium),
          margin: EdgeInsets.all(size.medium),
          decoration: const BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ));
    });
  }

  Widget _buildPoint(MapPoint point) {
    return Builder(builder: (context) {
      AppSize size = AppSize(context);
      return Container(
        height: size.width * .1,
        width: size.width * .1,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
            child: Transform.scale(scale: 1.5, child: Text(point.emoji))),
      );
    });
  }

  Widget _buildCursor() {
    return Builder(builder: (context) {
      AppSize size = AppSize(context);
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(1.3),
        child: Container(
            height: size.width * .1,
            width: size.width * .1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color.fromARGB(255, 42, 255, 234), width: 3.0),
            )),
      );
    });
  }
}

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
