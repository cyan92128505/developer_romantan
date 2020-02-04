import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/util.dart';

import 'package:developer_romantan/Views/mainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'haunt_game.dart';
import 'neumorphic_view.dart';

SharedPreferences sharedPrefs;

enum ViewType {
  Ninja,
  Mazzball,
  Neumorphic,
}

void main() async {
  const ViewType viewType = ViewType.Neumorphic;

  const Map<ViewType, Function> _funMap = {
    ViewType.Ninja: setupNinja,
    ViewType.Mazzball: setupMazzBall,
    ViewType.Neumorphic: setupNeumorphic,
  };

  _funMap[viewType]();
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

void setupNeumorphic() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Neumorphic());
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
