import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.background}) : super(key: key);
  final bool background;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      color: background ? Colors.white.withOpacity(0.3) : Colors.transparent,//8
    );
  }
}
