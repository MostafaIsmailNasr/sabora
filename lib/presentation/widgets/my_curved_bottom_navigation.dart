import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/config/app_colors.dart';
import 'bottomBar/nav_button.dart';
import 'bottomBar/nav_custom_painter.dart';

typedef _LetIndexPage = bool Function(int value);

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;

  CurvedNavigationBar({
    Key? key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  var _paint=Paint();

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    print("_pos");
    print(_pos);
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      print("_animationController");
      setState(() {
        _pos = _animationController.value;
        print("_pos");
        print(_pos);
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("object");
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
      print("_pos");
      print(_pos);
    }
  }

  @override
  void dispose() {
     _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      //color: widget.backgroundColor,

      height: widget.height,
      decoration: BoxDecoration(

      boxShadow: [BoxShadow(
        color: Colors.white10,

      )]),
      child: GestureDetector(
        onTap: ()=>{
          print("----------"),
          _buttonTap(2)
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              bottom: -40 - (75.0 - widget.height),
              left: Directionality.of(context) == TextDirection.rtl
                  ? null
                  : _pos * size.width,
              right: Directionality.of(context) == TextDirection.rtl
                  ? _pos * size.width
                  : null,
              width: size.width / _length,
              child: Center(
                child: Transform.translate(
                  offset: Offset(
                    0,
                    -(1 - _buttonHide) * 80,
                  ),
                  child: Material(
                    color: widget.buttonBackgroundColor ?? widget.color,
                    type: MaterialType.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _icon,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0 - (75.0 - widget.height),
              child: CustomPaint(
                painter: NavCustomPainter(
                    _pos, _length, widget.color, Directionality.of(context)),
                child: Container(
                 // color: Colors.black,
                  height: 75.0,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0 - (75.0 - widget.height),
              child: SizedBox(
                  height: 100.0,
                  child: Row(
                      children: widget.items.map((item) {
                    return NavButton(
                      onTap: _buttonTap,
                      position: _pos,
                      length: _length,
                      index: widget.items.indexOf(item),
                      child: Center(child: item),
                    );
                  }).toList())),
            ),
          ],
        ),
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    print("widget._buttonTap");
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _paint.color=AppColors.primary;
      print("widget.animationDuration");
      print(widget.animationDuration);
      print("widget.animationCurve${newPosition}");
      print(widget.animationCurve);
      var mPaint2 = Paint();
      Path path = Path();
      Canvas canvas=Canvas(PictureRecorder());
      path.moveTo(widget.height / 2, 0);
      mPaint2.style=PaintingStyle.stroke;
      mPaint2.color=AppColors.primary;
      path.cubicTo(
          widget.height / 2,
          0,
          widget.height / 2,
          widget.height+ widget.height / 2,
          widget.height,
          widget.height +widget.height / 2);
      canvas.drawPath(path, mPaint2);

      if (_endingIndex == 2)
        _animationController.animateTo(/*0.4*/newPosition,
            duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
