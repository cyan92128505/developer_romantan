import 'package:flutter/material.dart';

import 'package:clay_containers/clay_containers.dart';

class Neumorphic extends StatelessWidget {
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    return Container(
      color: baseColor,
      child: Center(
        child: ClayContainer(
          color: baseColor,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
