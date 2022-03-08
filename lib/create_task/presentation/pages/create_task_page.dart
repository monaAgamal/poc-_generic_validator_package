import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:generic_validator_poc/create_task/presentation/validations/generic_name_text_field.dart';
import 'package:generic_validator_poc/create_task/presentation/widgets/custom_generic_text_field.dart';
import 'package:generic_validator_poc/create_task/presentation/widgets/generic_text_field.dart';
import 'package:generic_validator_poc/create_task/presentation/widgets/main_button.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Body();
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskdescriptionController =
      TextEditingController();
  final TextEditingController definitionOfDoneController =
      TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskExpectedTimeController =
      TextEditingController();

  int taskExpectedTimeIntValue = 0;

  final TextEditingController priorityController = TextEditingController();
  bool _isValidTaskDuration = false;
  bool showRepetitionEndDateFiled = false;
  final TextEditingController taskRepetitionEndDateController =
      TextEditingController();
  bool _isRepeated = false;
  // RepetitionInterval? interval;
  int priorityItem = 2;
  bool _showTaskStartDateAndEndDateError = false;
  bool _showTaskExpectedTimeError = false;
  bool _showTaskPriorityError = false;
  bool _showTaskAssigneesError = false;
  bool _isExpectedTimeErrorMessage = false;
  bool _isRepetitionErrorMessage = false;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _taskGroupId;
  File? _voiceRecordingFile;
  bool _showSubjectError = false;
  bool _showClassesError = false;
  bool _showTaskStartDateShouldBeAfterCurrentDateError = false;

  bool get formIsDirty {
    return taskNameController.text.isNotEmpty ||
        taskdescriptionController.text.isNotEmpty ||
        definitionOfDoneController.text.isNotEmpty ||
        taskDateController.text.isNotEmpty ||
        taskExpectedTimeIntValue != 0 ||
        priorityController.text.isNotEmpty ||
        _voiceRecordingFile != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {},
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGenericTextFiled(
                  taskNameController,
                  maxLength: 100,
                  hintText: "taskName",
                  maxLines: 3,
                  validator: (value) => GenericNameTextFiledValidator(
                    maxLengthValidator: 100,
                    minLength: 0,
                  ).validate(value!).maybeMap(
                        orElse: () => null,
                        invalid: (rules) => rules.reasons.first,
                      ),
                  textStyle: TextStyle(
                    height: 1.2,
                    fontSize: 22,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: Theme.of(context)
                      .inputDecorationTheme
                      .hintStyle!
                      .copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                ),
                const SizedBox(height: 8),
                CustomGenericTextFiled(
                  taskdescriptionController,
                  isOptionalField: true,
                  hintText: "writeTaskDescribiton",
                  maxLength: 200,
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) => GenericNameTextFiledValidator(
                          maxLengthValidator: 200, minLength: 1)
                      .validate(value!)
                      .maybeWhen(
                        orElse: () => null,
                        invalid: (rules) => rules.first,
                      ),
                  textStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: Theme.of(context)
                      .inputDecorationTheme
                      .hintStyle!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 36.0),
                  child: Divider(
                    thickness: 1.0,
                    color: _showSubjectError
                        ? Theme.of(context).errorColor
                        : Theme.of(context).dividerColor,
                  ),
                ),
                Visibility(
                  visible: _showSubjectError,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Text(
                      "thisFieldIsRequired",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 36.0),
                  child: Divider(
                    thickness: 1.0,
                    color: _showClassesError
                        ? Theme.of(context).errorColor
                        : Theme.of(context).dividerColor,
                  ),
                ),
                Visibility(
                  visible: _showClassesError,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Text(
                      "thisFieldIsRequired",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: SvgPicture.asset(
                          "assets/svg/definition_of_done.svg",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GenericTextField(
                          definitionOfDoneController,
                          isAuthorized: true,
                          isOptionalField: true,
                          maxLength: 100,
                          textInputType: TextInputType.multiline,
                          maxLines: 3,
                          hintText: "addDefinitionOfDone",
                          contentPadding: const EdgeInsets.only(bottom: 12),
                          validator: (value) => GenericNameTextFiledValidator(
                                  maxLengthValidator: 100, minLength: 0)
                              .validate(value)
                              .maybeWhen(
                                orElse: () => null,
                                invalid: (rules) => rules.first,
                              ),
                          colorStyle: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                _createTaskBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createTaskBtn({bool isLoading = false}) => MainButton(
        "createTask",
        isEnabled: true,
        textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
        isIndicator: isLoading,
        onTap: isLoading
            ? () {}
            : () async {
                setState(() {
                  _showTaskStartDateAndEndDateError =
                      _startDate == null && _endDate == null;
                  _showTaskExpectedTimeError =
                      taskExpectedTimeController.text.isEmpty;
                  _showTaskPriorityError = priorityController.text.isEmpty;
                });
                if (_startDate != null &&
                    _startDate!.isBefore(DateTime.now())) {
                  setState(() {
                    _showTaskStartDateShouldBeAfterCurrentDateError = true;
                  });
                }
                final bool isValidCustomFields =
                    !_showTaskStartDateAndEndDateError &&
                        !_showTaskExpectedTimeError &&
                        !_showTaskPriorityError &&
                        !_showTaskAssigneesError &&
                        !_showTaskStartDateShouldBeAfterCurrentDateError &&
                        !_showSubjectError &&
                        !_showClassesError;
                final bool isValidForm = _formKey.currentState!.validate();
                if (isValidForm && isValidCustomFields) {
                  final List<int> teamIds = [];
                  final List<String> todoItems = [];
                  final List<String> userIdsInChatCollection = [];
                }
              },
      );
}
