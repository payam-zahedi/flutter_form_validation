import 'package:flutter/widgets.dart';
import 'package:flutter_validation/src/validation.dart';

class Validator {
  Validator._();

  static FormFieldValidator<T> validate<T>(
    BuildContext context,
    Validation<T> validation,
  ) {
    return (value) => validation.validate(context, value as T);
  }

  static FormFieldValidator<T> combine<T>(
    BuildContext context,
    List<Validation<T>> validations,
  ) {
    return (value) {
      for (final validation in validations) {
        final error = validation.validate(context, value as T);
        if (error != null) return error;
      }
      return null;
    };
  }
}
