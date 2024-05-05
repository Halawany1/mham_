import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void filterPopUp(BuildContext context) {
  var font = Theme.of(context).textTheme;
  var cubit = context.read<HomeCubit>();
  var layoutCubit = context.read<LayoutCubit>();
  final locale = AppLocalizations.of(context);
  var color = Theme.of(context);
  showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(layoutCubit.lang=='en'?
    120.w:30.w, 170.h, layoutCubit.lang=='en'?30.w:120.w, 0),
    elevation: 5,
    color: color.scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    items: [
      PopupMenuItem<String>(
        value: cubit.selectValue==RadioButtonValue.copy
            ?'copy':cubit.selectValue==RadioButtonValue.original?'original':'',
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Container(
              width: 150.w,
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter',
                    style: font.bodyMedium,
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    title: Text(
                      'All',
                      style: TextStyle(fontSize: 15.sp,color: color.primaryColor),
                    ),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<RadioButtonValue>(
                      activeColor: color.primaryColor,
                      value: RadioButtonValue.all,
                      groupValue: cubit.selectValue,
                      onChanged: (value) {
                        cubit.changeType(value!);
                      },
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    title: Text(
                      'Original',
                      style: TextStyle(fontSize: 15.sp,color: color.primaryColor),
                    ),
                    leading: Radio<RadioButtonValue>(
                      activeColor: color.primaryColor,
                      value: RadioButtonValue.original,
                      groupValue: cubit.selectValue,
                      onChanged: (value) {
                        cubit.changeType(value!);
                      },
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    title: Text(
                      'Copy',
                      style: TextStyle(fontSize: 15.sp,color: color.primaryColor),
                    ),
                    leading: Radio<RadioButtonValue>(
                      activeColor: color.primaryColor,
                      value: RadioButtonValue.copy,
                      groupValue: cubit.selectValue,
                      onChanged: (value) {
                        cubit.changeType(value!);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text('Price Range', style: font.bodyMedium!),
                  SizedBox(height: 10.h),
                  Slider(
                    value: cubit.price,
                    min: 0,

                    label: '${cubit.price.toInt()} ${locale.kd}',
                    inactiveColor: color.primaryColor.withOpacity(0.4),
                    max: 20000,
                    divisions: 200,
                    // You can change the number of divisions as needed
                    onChanged: (double value) {
                      cubit.changePrice(value);

                    },
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildSmallButton(text: 'Done',
                          hieght: 25.h,
                          withIcon: false,
                          onPressed: () {
                        cubit.allProducts.clear();
                        cubit.getAllProduct(
                            price: cubit.price,
                            type: cubit.selectValue==
                                RadioButtonValue.copy
                            ?'copy':cubit.selectValue==
                                RadioButtonValue.original?'original'
                                :'');
                        Navigator.pop(context);
                          },),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )
    ],
  );
}
