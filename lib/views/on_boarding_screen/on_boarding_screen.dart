import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/layout/layout_screen.dart';
import 'package:mham/views/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    final PageController controller = PageController();
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    List<Widget> titleText = [
      Text(
        textAlign: TextAlign.center,
       locale.onboardingOneTitle,
        style: font.bodyLarge!.copyWith(fontSize: 20.sp),
      ),
      Text(
        textAlign: TextAlign.center,
        locale.onboardingTwoTitle,
        style: font.bodyLarge!.copyWith(fontSize: 20.sp),
      ),
      Text(
        textAlign: TextAlign.center,
        locale.onboardingThreeTitle,
        style: font.bodyLarge!.copyWith(fontSize: 20.sp),
      ),
    ];
    List<Widget> bodyText = [
      Text(
        textAlign: TextAlign.center,
        locale.onboardingOneBody,
        style: font.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
      Text(
        textAlign: TextAlign.center,
        locale.onboardingTwoBody,
        style: font.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
      Text(
        textAlign: TextAlign.center,
        locale.onboardingThreeBody,
        style: font.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
    ];
    return  Scaffold(
        backgroundColor: ColorConstant.onboardingBackground,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Center(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Image.asset(
                        ImageConstant.onBoarding(index + 1),
                        key: Key(index.toString()),
                      ),
                      SizedBox(
                        height: index == 0 ? 45.h : 15.h,
                      ),
                      Container(
                          width: 295.w,
                          height: 270.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Color(0xFFD9D9D9)),
                          child: Padding(
                            padding: EdgeInsets.all(15.h),
                            child: SizedBox(
                              height: 285.h,
                              child: Column(
                                children: [
                                  titleText[index],
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  bodyText[index],
                                  Spacer(),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: SmoothPageIndicator(
                                      onDotClicked: (index) {},
                                      controller: controller,
                                      // PageController
                                      count: 3,
                                      effect: ExpandingDotsEffect(
                                          activeDotColor:
                                          ColorConstant.backgroundAuth,
                                          dotHeight: 3.9.h,
                                          dotWidth:
                                          9.w), // your preferred effect
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(index!=2)
                            InkWell(
                              onTap: () {
                                CacheHelper.saveData(key: AppConstant.onBoarding,
                                    value: true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LayoutScreen()));
                              },
                              child: Text(
                                locale.skip,
                                style: font.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          if(index!=2)
                            SizedBox(
                              width: 75.w,
                            ),
                          MaterialButton(
                            height: 40.h,
                            minWidth:  index!=2?
                            126.w:170.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            color: Color(0xFFEEBF40).withOpacity(0.7),
                            onPressed: () {
                              if (index == 2) {
                                CacheHelper.saveData(key: AppConstant.onBoarding,
                                    value: true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LayoutScreen()));
                              } else {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.fastOutSlowIn);
                              }
                            },
                            child:index==2?
                            Text(
                              locale.getStarted,
                              style: font.titleMedium!
                                  .copyWith(color: color.primaryColor),
                            ):
                            Row(
                              children: [
                                Text(
                                  locale.next,
                                  style: font.titleMedium!
                                      .copyWith(color: color.primaryColor),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: color.primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  itemCount: 3,
                  controller: controller,
                )),
          ),
        ));
  }
}
