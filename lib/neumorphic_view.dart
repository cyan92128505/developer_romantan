import 'package:flutter/material.dart';

import 'components/neumorphic.dart';

class Neumorphic extends StatelessWidget {
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    return Container(
      color: baseColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NeumorOption(
                color: baseColor,
                height: 64,
                width: 64,
                borderRadius: 64,
                emboss: false,
                gesture: true,
              ).buildContainer(),
              NeumorOption(
                  color: baseColor,
                  height: 64,
                  width: 64,
                  borderRadius: 64,
                  emboss: false,
                  gesture: true,
                  onTapDown: () {
                    print('onTapDown');
                  },
                  onTapUp: () {
                    print('onTapUp');
                  }).buildContainer()
            ],
          ),
        ),
      ),
    );
  }
}
