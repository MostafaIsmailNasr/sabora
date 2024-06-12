import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  NavButton({
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: Container(
            height: 75.0,
            //color: index==1?Colors.black:null,
            child:  Transform.translate(
              offset: Offset(
                  0, difference < 1.0 / length ? verticalAlignment * 40 : 0),
              child: Opacity(
                  opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                  child:Container(
                    margin: EdgeInsets.only(top: 18),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: 
                      BorderRadius.all(Radius.circular(40))),
                      elevation: 0,
                      child: InkWell(
                        // behavior: HitTestBehavior.translucent,
                          onTap: () {
                            onTap(index);
                          },
                          child: child),
                    ),
                  ),
            )),
      ),
    );
  }
}
