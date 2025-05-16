final class ValidatorForm {
  static String? requiredValidator(
    String fieldName,
    String? fieldValue, [
    String? message,
  ]) {
    return fieldValue == null || fieldValue.trim().isEmpty
        ? message ?? 'El campo "$fieldName" es requerido'
        : null;
  }

  static String? minLengthValidator(
    int minValue,
    String fieldName,
    String fieldValue, [
    String? message,
  ]) {
    final RegExp minExp = RegExp(
      '^.{$minValue,}'
      r'$',
    );

    return !minExp.hasMatch(fieldValue.trim())
        ? message ??
            'El campo "$fieldName" debe tener mínimo $minValue carácteres'
        : null;
  }

  static String? maxLengthValidator(
    int maxValue,
    String fieldName,
    String fieldValue, [
    String? message,
  ]) {
    final RegExp maxExp = RegExp(
      '^.{1,$maxValue}'
      r'$',
    );

    return !maxExp.hasMatch(fieldValue.trim())
        ? message ??
            'El campo "$fieldName" debe tener máximo $maxValue carácteres'
        : null;
  }

  static String? onlyNumbersValidator(
    String fieldName,
    String fieldValue, [
    String? message,
  ]) {
    final RegExp numberExp = RegExp(r'^\d+$');

    return !numberExp.hasMatch(fieldValue.trim())
        ? message ?? 'El campo "$fieldName" solo debe tener valores numéricos'
        : null;
  }

  static String? emailValidator(String fieldValue, [String? message]) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp emailExp = RegExp(pattern);

    return !emailExp.hasMatch(fieldValue.trim())
        ? message ?? 'El campo "correo" no es válido'
        : null;
  }

  static String? patternValidator(
    String pattern,
    String fieldName,
    String fieldValue, [
    String? message,
  ]) {
    final RegExp patternExp = RegExp(pattern);

    return !patternExp.hasMatch(fieldValue.trim())
        ? message ?? 'El campo "$fieldName" no cumple con la condición'
        : null;
  }
}

final class CommonValidators {
  static String? Function(String?) documentNumberValidator(String fieldName) {
    return (String? documentNumberValue) {
      return [
        ValidatorForm.requiredValidator(fieldName, documentNumberValue),
        ValidatorForm.onlyNumbersValidator(fieldName, documentNumberValue!),
        ValidatorForm.minLengthValidator(3, fieldName, documentNumberValue),
        ValidatorForm.maxLengthValidator(10, fieldName, documentNumberValue),
      ].firstWhere((validator) => validator != null, orElse: () => null);
    };
  }

  static String? Function(String?) namesValidator(String fieldName) {
    return (String? namesValue) {
      return [
        ValidatorForm.requiredValidator(fieldName, namesValue),
        ValidatorForm.patternValidator(
          r'^[a-zA-Z ]+$',
          fieldName,
          namesValue!,
          'El campo "$fieldName" solo debe tener letras y espacios',
        ),
        ValidatorForm.minLengthValidator(3, fieldName, namesValue),
        ValidatorForm.maxLengthValidator(50, fieldName, namesValue),
      ].firstWhere((validator) => validator != null, orElse: () => null);
    };
  }

  static String? Function(String?) emailValidator() {
    return (String? emailValue) {
      return [
        ValidatorForm.requiredValidator('correo', emailValue),
        ValidatorForm.emailValidator(emailValue!),
        ValidatorForm.maxLengthValidator(50, 'correo', emailValue),
      ].firstWhere((validator) => validator != null, orElse: () => null);
    };
  }

  static String? Function(String?) professionValidator() {
    final String fieldName = 'profesión';

    return (String? professionValue) {
      return [
        ValidatorForm.requiredValidator(fieldName, professionValue),
        ValidatorForm.patternValidator(
          r'^[a-zA-Z0-9 ]+$',
          fieldName,
          professionValue!,
          'El campo "$fieldName" solo debe tener letras, números y espacios',
        ),
        ValidatorForm.minLengthValidator(2, fieldName, professionValue),
        ValidatorForm.maxLengthValidator(30, fieldName, professionValue),
      ].firstWhere((validator) => validator != null, orElse: () => null);
    };
  }
}

final class SubjectValidators {
  static String? Function(String?) nameValidator() {
    final String fieldName = 'nombre';

    return (String? nameValue) {
      return [
        ValidatorForm.requiredValidator(fieldName, nameValue),
        ValidatorForm.patternValidator(
          r'^[a-zA-Z0-9 ]+$',
          fieldName,
          nameValue!,
          'El campo "$fieldName" solo debe tener letras, números y espacios',
        ),
        ValidatorForm.minLengthValidator(3, fieldName, nameValue),
        ValidatorForm.maxLengthValidator(30, fieldName, nameValue),
      ].firstWhere((validator) => validator != null, orElse: () => null);
    };
  }

  static String? Function(String?) descriptionValidator() {
    final String fieldName = 'descripción';

    return (String? descriptionValue) {
      return ValidatorForm.requiredValidator(fieldName, descriptionValue) ==
              null
          ? ValidatorForm.minLengthValidator(5, fieldName, descriptionValue!)
          : null;
    };
  }
}
