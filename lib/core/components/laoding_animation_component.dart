import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildImageLoader extends StatefulWidget {
  final String assetName;
  const BuildImageLoader({super.key,
    required this.assetName,
  });

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<BuildImageLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<EdgeInsets> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..repeat(reverse: true);
    _animation = Tween(
      begin: EdgeInsets.zero,
      end: EdgeInsets.only(top: 25.h),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: _animation.value,
          child: child,
        );
      },
      child: Image.asset(
        widget.assetName,
        width: 70.w,
        height: 70.h,
        fit: BoxFit.cover,
        // You can customize other properties as needed
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}