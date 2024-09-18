// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_image.dart';
import 'package:journey_world/constants/app_size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:journey_world/models/point.dart';
import 'package:journey_world/screens/detail.dart';

List<MapPoint> points = [
  MapPoint(alignment: Alignment(0.5, 0.5), color: Colors.amber),
  MapPoint(alignment: Alignment(0, 0), color: Colors.teal),
  MapPoint(alignment: Alignment(-.5, -0.5), color: Colors.green),
  MapPoint(alignment: Alignment(-.3, 0.2), color: Colors.brown),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AlignmentGeometry currentPosition = Alignment.center;

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: size.height * .6,
              color: Colors.red,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.medium),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Welcome to the Journey World",
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleLarge?.copyWith(
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
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
                                  currentPosition = points[index].alignment;
                                });
                              },
                            ))),
                  ],
                ),
              )),
          Expanded(
              child: Stack(
            children: [
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
              AnimatedAlign(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                alignment: currentPosition,
                child: _buildCursor(),
              ),
              ...points.map((point) {
                return Align(
                  alignment: point.alignment,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPosition = point.alignment;
                        });
                      },
                      child: _buildPoint(color: point.color)),
                );
              }),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildPoint({
    Color? color = Colors.amber,
  }) {
    return Builder(builder: (context) {
      AppSize size = AppSize(context);
      return Container(
        height: size.width * .1,
        width: size.width * .1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
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
              border: Border.all(color: Colors.blue, width: 3.0),
            )),
      );
    });
  }
}

class Carousel extends StatelessWidget {
  Function(int, CarouselPageChangedReason)? onPageChanged;
  Carousel({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context);
    return CarouselSlider(
        items: points.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(point: i)));
                },
                child: Hero(
                  tag: i.alignment,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: size.small),
                        decoration: BoxDecoration(color: i.color),
                        child: Text(
                          'text $i',
                          style: TextStyle(fontSize: 16.0),
                        )),
                  ),
                ),
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
            onPageChanged?.call(index, reason);
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
