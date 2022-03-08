import 'package:flutter/material.dart';
import 'package:generic_validator_poc/create_task/domain/entities/input_time.dart';
import 'package:generic_validator_poc/create_task/presentation/utils/time_target.dart';
import 'package:generic_validator_poc/create_task/presentation/widgets/main_button.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:numberpicker/numberpicker.dart';

class TaskInputTime extends StatefulWidget {
  final DateTime? taskStartDate;
  final DateTime? taskEndDate;
  final Function(InputTime?) onTimeSelected;
  final TimeTarget target;
  final bool isLoading;

  const TaskInputTime({
    Key? key,
    this.target = TimeTarget.expected,
    this.taskStartDate,
    this.taskEndDate,
    this.isLoading = false,
    required this.onTimeSelected,
  })  : assert(
          !(target == TimeTarget.expected &&
              taskStartDate == null &&
              taskEndDate == null),
          "Task bounds are required to calculate expected time validation",
        ),
        super(key: key);

  @override
  _TaskInputTimeState createState() => _TaskInputTimeState();
}

class _TaskInputTimeState extends State<TaskInputTime> {
  @override
  void initState() {
    super.initState();
    if (widget.target == TimeTarget.expected) {
      taskDuration =
          widget.taskStartDate!.difference(widget.taskEndDate!).inMinutes * 60;
    }
    model = InputTime(
      numOfMinutes: _currentMinuteValue,
      numOfHours: _currentHourValue,
    );
  }

  int? taskDuration;
  late InputTime model;
  int _currentMinuteValue = 0;
  int _currentHourValue = 0;
  bool _isErrorSelectionExpectedTime = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 12),
            child: Text(
              widget.target.title(context),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
            ),
          ),
          Visibility(
            visible: widget.target == TimeTarget.estimation,
            child: Text(
              "youHaveToSetEstimation",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (taskDuration != null && taskDuration! < 1)
                  const SizedBox.shrink()
                else
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NumberPicker(
                        itemWidth: MediaQuery.of(context).size.width * 0.22,
                        textMapper: (item) {
                          // final locale = Provider.of<ThemeCubit>(context)
                          //     .locale
                          //     .toString();
                          // final formatter =
                          // NumberFormat.compact(locale: locale);
                          // final parsedNumber = int.parse(item);
                          return NumberFormat.compact().format(item);
                        },
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).hintColor),
                        selectedTextStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                        value: _currentHourValue,
                        minValue: 0,
                        maxValue: 99,
                        onChanged: (value) {
                          setState(() {
                            _currentHourValue = value;
                            model = model.copyWith(numOfHours: value);
                          });
                        },
                      ),
                      Text("hour"),
                    ],
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NumberPicker(
                      itemWidth: MediaQuery.of(context).size.width * 0.22,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).hintColor),
                      selectedTextStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                      textMapper: (item) {
                        // final locale =
                        //     Provider.of<ThemeCubit>(context).locale.toString();
                        // final formatter = NumberFormat.compact(locale: locale);
                        // final parsedNumber = int.parse(item);
                        return item;
                        //formatter.format(parsedNumber);
                      },
                      value: _currentMinuteValue,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (value) {
                        setState(() {
                          model = model.copyWith(numOfMinutes: value);
                          _currentMinuteValue = value;
                        });
                      },
                    ),
                    Text("minute"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: _isErrorSelectionExpectedTime,
            child: Text(
              // S.of(context).
              "expectedTimeMustBeLessThanTaskDurationErrorMsg",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.error, height: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          MainButton(
            // S.of(context).
            "select",
            isIndicator: widget.isLoading,
            isEnabled: !model.isEmpty,
            onTap: widget.isLoading
                ? null
                : () {
                    if (validateSelectedTime()) {
                      widget.onTimeSelected.call(
                        model,
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }

  bool validateSelectedTime() {
    if (model.isEmpty) {
      return false;
    }
    if (widget.target == TimeTarget.expected && model.value > taskDuration!) {
      setState(() {
        _isErrorSelectionExpectedTime = true;
      });
      return false;
    }
    return true;
  }
}
