import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
var requestScrapController = TextEditingController();
var formKey=GlobalKey<FormState>();
class BuildRequestScrap extends StatelessWidget {
  const BuildRequestScrap({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Form(
      key: formKey,
      child: AlertDialog(
        backgroundColor: color.scaffoldBackgroundColor,
        title: Text(locale.requestScrap,style: font.bodyLarge,),
        content: SizedBox(
          width: 500.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildTextFormField(title: locale.requestScrap,
                hint:  locale.enterRequestScrap,
                maxLines: 5,
               contentPadding: true,
                withBorder: true,
                cubit: AuthenticationCubit.get(context),
                controller: requestScrapController,
                validator: (value) {
                  return Validation.validateField(value,
                      locale.requestScrap,context);
                },
                keyboardType: TextInputType.text,
                maxLength: 100,),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      requestScrapController.clear();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      locale.close,
                      style: font.bodyMedium!.copyWith(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        HomeCubit.get(context).
                        addScrap(description: requestScrapController.text);
                        requestScrapController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      locale.send,
                      style: font.bodyMedium!.copyWith(
                        color: ColorConstant.brown
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
