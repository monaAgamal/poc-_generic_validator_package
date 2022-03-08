import 'package:generic_validator/generic_validator.dart';

class GenericNameTextFiledValidator extends Validator<String, dynamic>
    with StringRules {
  final int maxLengthValidator;
  final int minLength;
  GenericNameTextFiledValidator({
    required this.maxLengthValidator,
    required this.minLength,
  });
  
  @override
  List<ValidationRule<String, dynamic>> get rules => [
        notEmpty(negativeFeedback: "This field can't be empty."),
        max(maxLength: maxLengthValidator, negativeFeedback: ""),
        min(minLength: minLength, negativeFeedback: ""),
      ];
}
