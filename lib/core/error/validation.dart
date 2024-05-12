import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Validation{

  static String? validatePassword(String? value,context) {
    final locale = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return locale.pleaseEnterYourPassword;
    }
    if (value.length < 6) {
      return locale.pleaseEnterYourValidPassword;
    }
    // Add additional password validation rules as needed
    return null;
  }


  static String? validateFirstName(String? value,context) {
    final locale = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return locale.firstName;
    }
    // Add additional username validation rules as needed
    return null;
  }
  static String? validateLastName(String? value,context) {
    final locale = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return locale.lastName;
    }
    // Add additional username validation rules as needed
    return null;
  }

  static String? validatePhoneNumber(String? value,context) {
    final locale = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return locale.pleaseEnterYourPhone;
    }
    return null;
  }

  static String? validateConfirmPassword(String? password,
      String? confirmPassword,context) {
    final locale = AppLocalizations.of(context);
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return locale.pleaseEnterYourPassword;
    }
    if (password != confirmPassword) {
      return locale.passwordNoMatch;
    }
    return null;
  }
  static String? validateField(String? fieldValue, String fieldName,context) {
    final locale = AppLocalizations.of(context);
    if (fieldValue == null || fieldValue.isEmpty) {
      return '${locale.pleaseEnter} $fieldName';
    }
    return null;
  }





}