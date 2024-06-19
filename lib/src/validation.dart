import 'package:flutter/widgets.dart';
import 'package:flutter_validation/src/models/role.dart';

/// base class for all validations.
abstract class Validation<T> {
  const Validation();

  /// Validates the given [value] and returns an error message if validation fails.
  /// 
  /// if the validation passes, it should return `null`.
  String? validate(BuildContext context, T? value);
}

/// a validation that checks if the value is required.
class RequiredValidation<T> extends Validation<T> {
  const RequiredValidation({this.isExist});

  final bool Function(T value)? isExist;

  @override
  String? validate(BuildContext context, T? value) {
    if (value == null) {
      return 'This field is required';
    }

    if (isExist != null && !isExist!(value)) {
      return 'This field is required';
    }

    if (value is String && (value as String).isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}

/// a validation that checks if the value is a valid email.
class EmailValidation extends Validation<String> {
  const EmailValidation();

  @override
  String? validate(BuildContext context, String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null) return null;
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

/// a validation that checks if the value is a valid phone number.
class RoleValidation extends Validation<Role> {
  const RoleValidation();

  @override
  String? validate(BuildContext context, Role? value) {
    if (value == Role.member) {
      return 'Require Admin or Editor role';
    }

    return null;
  }
}


/// a validation that checks if the value is a valid password.
class PasswordValidation extends Validation<String> {
  const PasswordValidation({
    this.minLength = 8,
    this.number = false,
    this.upperCase = false,
    this.specialChar = false,
  });

  final int minLength;
  final bool number;
  final bool upperCase;
  final bool specialChar;

  static final _numberRegex = RegExp(r'[0-9]');
  static final _upperCaseRegex = RegExp(r'[A-Z]');
  static final _specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  String? validate(BuildContext context, String? value) {
    if (value?.isEmpty == true) return null;

    if (value!.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (number && !_numberRegex.hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (upperCase && !_upperCaseRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (specialChar && !_specialCharRegex.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}
