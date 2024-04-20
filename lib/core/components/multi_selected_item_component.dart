import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class BuildMultiSelectDropDownWidget extends StatelessWidget {
  BuildMultiSelectDropDownWidget({required this.controller,
    required this.options,
    required this.onOptionSelected,
    required this.selectedOptions,
    required this.text,

  });

  final List<ValueItem> options;
  final List<ValueItem> selectedOptions;
  final MultiSelectController controller;
  final void Function(List<ValueItem>) onOptionSelected;
  final String text;
  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return SizedBox(
      width: 135.w,
      height: 27.h,
      child: MultiSelectDropDown(
        controller: controller,
        dropdownBorderRadius: 10.r,
        onOptionSelected: onOptionSelected,
        inputDecoration: BoxDecoration(
          color: ColorConstant.scaffoldBackground,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.backgroundColor),
        ),

        options: options,
        hint: text,
        hintStyle: font.bodyMedium!.copyWith(
            color: color.hintColor,
            fontSize: 10.sp
        ),

        selectionType: SelectionType.single,
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        selectedOptions: selectedOptions,
        animateSuffixIcon: true,
        dropdownHeight: 100.h,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: color.backgroundColor,
        ),
        optionTextStyle: TextStyle(fontSize: 12.sp),
        selectedOptionIcon: const Icon(Icons.check_circle),
      ),
    );
  }
}
