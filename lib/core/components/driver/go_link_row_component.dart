import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/map_screen/map_screen.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class BuildGoToLinkRow extends StatelessWidget {
  const BuildGoToLinkRow({super.key,
     this.assign=false,
     this.index,
    required this.link,});
  final String link;
  final bool assign;
  final int ?index;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var cubit = OrderDriverCubit.get(context);
    return Row(
      children: [
        Icon(Icons.location_on_outlined),
        SizedBox(
          width: 5.w,
        ),
        GestureDetector(
          onTap: () async {
            if(assign) {
              CacheHelper.saveData(key: AppConstant.timeLineProcess,
                  value: index!);
            }
            determinePosition().then((value) async {
              final currentLocation = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              Helper.push(
                  context: context,
                  widget: MapScreen(link),
                  withAnimate: true);
            });
          },
          child: SizedBox(
            width: 200.w,
            child: Text(
              link,
              overflow: TextOverflow.ellipsis,
              style: font.bodyMedium!.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
