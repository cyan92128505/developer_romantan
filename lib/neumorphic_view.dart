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
            children: <Widget>[
              NeumorOption(
                color: baseColor,
                gesture: true,
                borderRadius: 64,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Hello World',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ).buildContainer(),
              NeumorOption(
                  color: baseColor,
                  height: 64,
                  width: 64,
                  borderRadius: 64,
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
