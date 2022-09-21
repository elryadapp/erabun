import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ErboonAnimatedListHandler extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final bool noScroll;
   

 const ErboonAnimatedListHandler({
   Key? key,
    required this.children,
    this.noScroll = false,
    this.shrinkWrap = false, this.scrollController,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: shrinkWrap,
        physics:
            noScroll ?const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
        itemCount: children.length,
        itemBuilder: (BuildContext context, int position) {
          return AnimationConfiguration.staggeredList(
            position: position,
            duration: const Duration(milliseconds: 600),

            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: children[position],
              ),
            ),
          );
        },
      ),
    );
  }
}
