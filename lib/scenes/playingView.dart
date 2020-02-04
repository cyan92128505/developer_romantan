import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:developer_romantan/components/ball.dart';
import 'package:developer_romantan/components/mazeBuilder.dart';
import 'package:developer_romantan/components/wall.dart';
import 'package:developer_romantan/scenes/base/baseView.dart';
import 'package:developer_romantan/scenes/viewManager.dart';
import 'package:developer_romantan/helper.dart';
import 'package:developer_romantan/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/viewSwtichMessage.dart';

class PlayingView extends BaseView {
  Ball player;
  bool _initRequired = true;

  MazeBuilder mazeBuilder;

  PlayingView(GameView view, ViewManager viewManager)
      : super(view, viewManager);

  @override
  void setActive({ViewSwitchMessage message}) {
    if (_initRequired) {
      _initRequired = false;
      //Generate our test ball at the scaled center of the screen
      player = Ball(
          viewManager.game,
          scaleVectoreBy(Vector2(Wall.wallWidth * 4, Wall.wallWidth * 4),
              viewManager.game.screenSize.width / viewManager.game.scale));
      initMaze();
    }
  }

  void initMaze() {
    var savedHeight = sharedPrefs.getInt("maze_height") ?? 8;
    var savedWidth = sharedPrefs.getInt("maze_width") ?? 8;
    mazeBuilder = MazeBuilder(
      this.viewManager.game,
      height: savedHeight,
      width: savedWidth,
    );
    mazeBuilder.generateMaze();
  }

  @override
  void moveToBackground({ViewSwitchMessage message}) {
    // TODO: implement moveToBackground
  }

  @override
  void render(Canvas c) {
    player?.render(c);
    mazeBuilder?.render(c);
  }

  @override
  void update(double t) {
    player?.update(t);
  }
}
