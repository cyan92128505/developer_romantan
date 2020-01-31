import 'package:flutter/material.dart';

import 'components/neumorphic_container.dart';

class Neumorphic extends StatelessWidget {
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    NeumorphicContainer neumorphicContainer1 = NeumorphicContainer(NeumorOption(
      color: baseColor,
      height: 64,
      width: 64,
      borderRadius: 64,
      emboss: false,
    ));

    NeumorphicContainer neumorphicContainer2 = NeumorphicContainer(NeumorOption(
      color: baseColor,
      height: 64,
      width: 64,
      borderRadius: 64,
      emboss: false,
    ));

    return Container(
      color: baseColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: neumorphicContainer1,
                onTapDown: (_) {
                  neumorphicContainer1.toggleOn();
                },
                onTapUp: (_) {
                  neumorphicContainer1.toggleOff();
                },
              ),
              GestureDetector(
                child: neumorphicContainer2,
                onTapDown: (_) {
                  neumorphicContainer2.toggleOn();
                },
                onTapUp: (_) {
                  neumorphicContainer2.toggleOff();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
