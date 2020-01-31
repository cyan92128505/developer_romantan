import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:developer_romantan/Views/mainMenu.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/widgets.dart';
import 'haunt-game.dart';

//TODO Keep screen active -> no sleep

SharedPreferences sharedPrefs;

bool isNinjaGame = true;

void main() async {
  if (isNinjaGame == true) {
    setupNinja();
  } else {
    setupMazzBall();
  }
}

void setupNinja() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HauntGame().widget);
}

void setupMazzBall() async {
  //Make sure flame is ready before we launch our game
  await setupFlame();
  runApp(App());
}

/// Setup all Flame specific parts
Future setupFlame() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Since flutter upgrade this is required
  sharedPrefs = await SharedPreferences.getInstance();
  var flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(
      DeviceOrientation.portraitUp); //Force the app to be in this screen mode
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}
