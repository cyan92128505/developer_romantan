import 'package:flutter/material.dart';
import 'dart:async';

enum CurveType { concave, convex, none }

class NeumorphicContainer extends StatefulWidget {
  final NeumorOption option;
  final StreamController<String> streamController =
      StreamController.broadcast();

  NeumorphicContainer(this.option);

  @override
  _NeumorphicContainerState createState() =>
      _NeumorphicContainerState(this.streamController);

  dispose() {
    streamController.close();
  }

  toggle(bool status) {
    this.option.emboss = status;
    this.streamController.sink.add('v');
  }

  toggleOn() {
    this.toggle(true);
  }

  toggleOff() {
    this.toggle(false);
  }

  toggleTap() {
    toggle(!this.option.emboss);
  }
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  final StreamController<String> streamController;

  _NeumorphicContainerState(this.streamController) : super() {
    this.streamController.stream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    this.widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightValue =
        this.widget.option.height == null ? null : this.widget.option.height;
    double widthValue =
        this.widget.option.width == null ? null : this.widget.option.width;
    int depthValue =
        this.widget.option.depth == null ? 20 : this.widget.option.depth;
    Color colorValue = this.widget.option.color == null
        ? Color(0xFFf0f0f0)
        : this.widget.option.color;
    Color parentColorValue = this.widget.option.parentColor == null
        ? colorValue
        : this.widget.option.parentColor;
    Color surfaceColorValue = this.widget.option.surfaceColor == null
        ? colorValue
        : this.widget.option.surfaceColor;
    double spreadValue =
        this.widget.option.spread == null ? 6 : this.widget.option.spread;
    bool embossValue =
        this.widget.option.emboss == null ? false : this.widget.option.emboss;
    BorderRadius borderRadiusValue = this.widget.option.borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(this.widget.option.borderRadius);

    if (this.widget.option.customBorderRadius != null) {
      borderRadiusValue = this.widget.option.customBorderRadius;
    }
    CurveType curveTypeValue = this.widget.option.curveType == null
        ? CurveType.none
        : this.widget.option.curveType;

    List<BoxShadow> shadowList = [
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? 0 - depthValue : depthValue),
          offset: Offset(0 - spreadValue, 0 - spreadValue),
          blurRadius: spreadValue),
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? depthValue : 0 - depthValue),
          offset: Offset(spreadValue, spreadValue),
          blurRadius: spreadValue)
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue)
      colorValue = _getAdjustColor(colorValue, 0 - depthValue ~/ 2);
    if (this.widget.option.surfaceColor != null) colorValue = surfaceColorValue;

    List<Color> gradientColors;
    switch (curveTypeValue) {
      case CurveType.concave:
        gradientColors = _getConcaveGradients(colorValue, depthValue);
        break;
      case CurveType.convex:
        gradientColors = _getConvexGradients(colorValue, depthValue);
        break;
      case CurveType.none:
        gradientColors = _getFlatGradients(colorValue, depthValue);
        break;
    }

    return Container(
      height: heightValue,
      width: widthValue,
      child: this.widget.option.child,
      decoration: BoxDecoration(
        borderRadius: borderRadiusValue,
        color: colorValue,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors),
        boxShadow: shadowList,
      ),
    );
  }

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }
}

class NeumorOption {
  double height;
  double width;
  Color color;
  Color parentColor;
  Color surfaceColor;
  double spread;
  Widget child;
  double borderRadius;
  BorderRadius customBorderRadius;
  CurveType curveType;
  int depth;
  bool emboss;

  NeumorOption({
    this.child,
    this.height,
    this.width,
    this.color,
    this.surfaceColor,
    this.parentColor,
    this.spread,
    this.borderRadius,
    this.customBorderRadius,
    this.curveType,
    this.depth,
    this.emboss,
  });

  factory NeumorOption.build(NeumorOption option) {
    return option == null ? NeumorOption() : option;
  }

  @override
  String toString() {
    return '''{
    child: ${this.child},
    height: ${this.height},
    width: ${this.width},
    color: ${this.color},
    surfaceColor: ${this.surfaceColor},
    parentColor: ${this.parentColor},
    spread: ${this.spread},
    borderRadius: ${this.borderRadius},
    customBorderRadius: ${this.customBorderRadius},
    curveType: ${this.curveType},
    depth: ${this.depth},
    emboss: ${this.emboss},
    }''';
  }
}
