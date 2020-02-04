import 'package:flutter/material.dart';

enum CurveType {
  concave,
  convex,
  none,
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
  bool gesture;
  Function onTapUp;
  Function onTapDown;

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
    this.gesture,
    this.onTapUp,
    this.onTapDown,
  });

  factory NeumorOption.build(NeumorOption option) {
    return option == null ? NeumorOption() : option;
  }

  buildContainer() {
    return NeumorphicContainer(this);
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
    gesture: ${this.gesture},
    onTapUp: ${this.onTapUp},
    onTapDown: ${this.onTapDown},
    }''';
  }
}

class NeumorphicContainer extends StatefulWidget {
  final NeumorOption option;

  NeumorphicContainer(this.option);

  @override
  _NeumorphicContainerState createState() =>
      _NeumorphicContainerState(NeumorConfig.buildByNeumorOption(this.option));
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  final NeumorConfig config;

  _NeumorphicContainerState(this.config);

  @override
  Widget build(BuildContext context) {
    Widget _container = Container(
      height: config.heightValue,
      width: config.widthValue,
      child: this.widget.option.child,
      decoration: BoxDecoration(
        borderRadius: config.borderRadiusValue,
        color: config.colorValue,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: config.gradientColors),
        boxShadow: config.shadowList,
      ),
    );

    if (this.widget.option.gesture) {
      _container = GestureDetector(
        child: _container,
        onTapDown: (_) {
          this.widget.option.emboss = true;
          if (this.widget.option.onTapDown is Function) {
            this.widget.option.onTapDown();
          }
          config.prepareConfig(this.widget.option);
          setState(() {});
        },
        onTapUp: (_) {
          this.widget.option.emboss = false;
          if (this.widget.option.onTapDown is Function) {
            this.widget.option.onTapUp();
          }
          config.prepareConfig(this.widget.option);
          setState(() {});
        },
      );
    }

    return config != null ? _container : Container();
  }
}

const Color neumorColor = Color(0xFFf0f0f0);

class NeumorConfig {
  double heightValue;
  double widthValue;
  int depthValue = 20;
  Color colorValue = neumorColor;
  Color parentColorValue = neumorColor;
  Color surfaceColorValue = neumorColor;
  double spreadValue = 6;
  bool embossValue = false;
  BorderRadius borderRadiusValue = BorderRadius.zero;
  CurveType curveTypeValue = CurveType.none;
  List<BoxShadow> shadowList;
  List<Color> gradientColors;

  NeumorConfig({
    this.heightValue,
    this.widthValue,
    this.depthValue,
    this.colorValue,
    this.parentColorValue,
    this.surfaceColorValue,
    this.spreadValue,
    this.embossValue,
    this.borderRadiusValue,
    this.curveTypeValue,
  });

  factory NeumorConfig.buildByNeumorOption(NeumorOption _option) {
    NeumorConfig _config = NeumorConfig();

    _config.prepareProperty(_option);
    _config.generatorShadowList();
    _config.setupCustomBorderRadiusValue(_option);
    _config.detectEmbossValue(_option);
    _config.generatorGradientColors();

    print(_config);

    return _config;
  }

  prepareConfig(NeumorOption _option) {
    this.prepareProperty(_option);
    this.generatorShadowList();
    this.setupCustomBorderRadiusValue(_option);
    this.detectEmbossValue(_option);
    this.generatorGradientColors();
  }

  prepareProperty(NeumorOption _option) {
    this.heightValue = _option.height == null ? null : _option.height;
    this.widthValue = _option.width == null ? null : _option.width;
    this.depthValue = _option.depth == null ? 20 : _option.depth;
    this.colorValue = _option.color == null ? Color(0xFFf0f0f0) : _option.color;
    this.parentColorValue =
        _option.parentColor == null ? colorValue : _option.parentColor;
    this.surfaceColorValue =
        _option.surfaceColor == null ? colorValue : _option.surfaceColor;
    this.spreadValue = _option.spread == null ? 6 : _option.spread;
    this.embossValue = _option.emboss == null ? false : _option.emboss;
    this.borderRadiusValue = _option.borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(_option.borderRadius);

    this.curveTypeValue =
        _option.curveType == null ? CurveType.none : _option.curveType;
  }

  generatorShadowList() {
    this.shadowList = [
      BoxShadow(
        color: _getAdjustColor(this.parentColorValue,
            this.embossValue ? 0 - this.depthValue : this.depthValue),
        offset: Offset(0 - this.spreadValue, 0 - this.spreadValue),
        blurRadius: this.spreadValue,
      ),
      BoxShadow(
        color: _getAdjustColor(this.parentColorValue,
            this.embossValue ? this.depthValue : 0 - this.depthValue),
        offset: Offset(this.spreadValue, this.spreadValue),
        blurRadius: this.spreadValue,
      )
    ];
  }

  setupCustomBorderRadiusValue(NeumorOption _option) {
    if (_option.customBorderRadius != null) {
      borderRadiusValue = _option.customBorderRadius;
    }
  }

  detectEmbossValue(NeumorOption _option) {
    if (this.embossValue) this.shadowList = this.shadowList.reversed.toList();
    if (this.embossValue)
      this.colorValue =
          _getAdjustColor(this.colorValue, 0 - this.depthValue ~/ 2);
    if (_option.surfaceColor != null) this.colorValue = this.surfaceColorValue;
  }

  generatorGradientColors() {
    switch (this.curveTypeValue) {
      case CurveType.concave:
        this.gradientColors =
            _getConcaveGradients(this.colorValue, this.depthValue);
        break;
      case CurveType.convex:
        this.gradientColors =
            _getConvexGradients(this.colorValue, this.depthValue);
        break;
      default:
        this.gradientColors =
            _getFlatGradients(this.colorValue, this.depthValue);
        break;
    }
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

  List<Color> _getFlatGradients(Color baseColor, int depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(Color baseColor, int depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(Color baseColor, int depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }
}
