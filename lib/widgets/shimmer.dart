import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as s;

class Shimmer extends StatelessWidget {
  const Shimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return s.Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: const Color(0xFFF3F3F3),
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: Colors.grey[200]
        ),
      ),
    );
  }
}