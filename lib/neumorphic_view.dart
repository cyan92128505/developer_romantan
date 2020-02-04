import 'package:flutter/material.dart';

import 'package:developer_romantan/components/neumorphic.dart';

class Neumorphic extends StatefulWidget {
  @override
  _NeumorphicState createState() => _NeumorphicState();
}

class _NeumorphicState extends State<Neumorphic> {
  Color baseColorDark = Color(0xFF555555);
  Color baseColorLight = Color(0xFFF2F2F2);

  bool toggleDarkMode = false;

  Color get baseColor => toggleDarkMode ? baseColorDark : baseColorLight;

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
              ).buildContainer(),
              NeumorOption(
                color: baseColor,
                child: SizedBox(
                  height: 100,
                  width: 100,
                ),
              ).buildContainer()
            ],
          ),
        ),
      ),
    );
  }
}
