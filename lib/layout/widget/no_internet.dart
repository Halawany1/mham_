import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildNoInternet extends StatelessWidget {
  const BuildNoInternet({super.key});

  @override

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.wifi_slash,size: 50.r,),
          SizedBox(height: 20.h,),
          Text('No Internet Connection'),

        ],
      ),
    );
  }
}
