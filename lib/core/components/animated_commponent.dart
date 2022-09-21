import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class ErboonSlideAnimation extends StatelessWidget {
  final Widget? child;
  final double? horizontalOffset;
  final double? verticalOffset;
  const ErboonSlideAnimation(
      {Key? key, this.child, this.verticalOffset, this.horizontalOffset, })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(

      child:  AnimationConfiguration.synchronized(
          duration: const  Duration(milliseconds: 600),
          child: FadeInAnimation(
                          duration: const  Duration(milliseconds: 1000),

            child: SlideAnimation(
              duration: const  Duration(milliseconds: 600),
                verticalOffset: verticalOffset ?? 200,
                horizontalOffset: horizontalOffset ?? 0,
                child: child!),
          ),
        ),
      
    );
  }
}
