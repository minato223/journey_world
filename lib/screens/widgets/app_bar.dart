import 'package:flutter/material.dart';
import 'package:journey_world/constants/app_size.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSize size = AppSize(context);
    return Padding(
      padding: EdgeInsets.all(size.medium),
      child: Row(
        children: [
          Expanded(
              child: Text(
            "Dubai",
            overflow: TextOverflow.ellipsis,
            style: theme.titleLarge?.copyWith(
                color: Colors.white, height: 1.5, fontWeight: FontWeight.bold),
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
    );
  }
}
