import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/error/validation.dart';

class BuildDropDownMenu extends StatelessWidget {
  const BuildDropDownMenu({super.key,
    required this.list,
    required this.valueName,
    required this.value,
    required this.onChange,
  });
  final List<String>list;
  final String valueName;
  final void Function(String?) onChange;
  final String ?value;
  @override
  Widget build(BuildContext context) {

    var color=Theme.of(context);
    var font=Theme.of(context).textTheme;
    return DropdownButtonFormField<String>(
      value: value,
      validator: (value) {
        return Validation.validateField(value, valueName, context);
      },
      dropdownColor: color.cardColor,
      onChanged: onChange,
      items: list
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style:
          font.bodyMedium!.copyWith(fontSize: 16.sp,
              color: color.primaryColor),),
        );
      }).toList(),
      icon: Icon(Icons.keyboard_arrow_down,color: color.backgroundColor,),
      hint: Text(valueName,style:font.bodyMedium!
          .copyWith(color: color.primaryColor.withOpacity(0.75),fontSize: 15.sp) ,),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: color.backgroundColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: color.backgroundColor)),
      ),
    );
  }
}
