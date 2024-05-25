import 'package:flutter/widgets.dart';
import 'package:flutter_validation/src/models/role.dart';

abstract class Validation<T> {
  const Validation();

  String? validate(BuildContext context, T value);
}

class RequiredValidation<T> extends Validation<T> {
  const RequiredValidation({this.isExist});

  final bool Function(T value)? isExist;

  @override
  String? validate(BuildContext context, T value) {
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

class EmailValidation extends Validation<String> {
  const EmailValidation();

  @override
  String? validate(BuildContext context, String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

class RoleValidation extends Validation<Role?> {
  const RoleValidation();

  @override
  String? validate(BuildContext context, Role? value) {
    if (value == null) {
      return 'Role is required';
    }
    if (value == Role.member) {
      return 'Require Admin or Editor role';
    }
    return null;
  }
}
