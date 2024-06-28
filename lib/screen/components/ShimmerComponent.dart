import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer(
      {super.key,
      required this.height,
      required this.width,
      required this.radius,
      required this.main,
      required this.highlight});
  final double height;
  final double width;
  final double radius;
  final Color main;
  final Color highlight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: highlight,
        baseColor: main,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius), color: Colors.white),
        ));
  }
}
