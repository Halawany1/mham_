class Validation{
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return null;
    }


    return 'Please enter a valid Email';
  }
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Add additional password validation rules as needed
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Username';
    }
    // Add additional username validation rules as needed
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Phone Number';
    }
    // Check if the value contains only numeric characters
    if (!value.contains(RegExp(r'^[0-9]+$'))) {
      return 'Phone Number should contain only digits';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your Password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }


}