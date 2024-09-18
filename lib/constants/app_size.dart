import 'package:flutter/material.dart';

class AppSize {
  late BuildContext context;
  AppSize(this.context);
  double get small => 8.0;
  double get medium => 16.0;
  double get large => 24.0;
  double get extraLarge => 32.0;
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
