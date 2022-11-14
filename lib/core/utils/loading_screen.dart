import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.enabled}) : super(key: key);
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(208, 200, 200, .5),
      highlightColor: const Color.fromRGBO(162, 195, 195, 1),
      enabled: enabled,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: List.generate(9, (index) => item()),
      ),
    );
  }

  Widget item() {
    return SizedBox(
      height: 70,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            Container(
              width: double.infinity,
              height: 12.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: double.infinity,
              height: 12.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: 40.0,
              height: 12.0,
              color: Colors.white,
            ),
          ],
        ))
      ]),
    );
  }
}
