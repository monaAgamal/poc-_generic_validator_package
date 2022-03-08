// import 'dart:developer';
// // import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// // import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// // import 'package:taskedin/core/presentation/widgets/directionality_mirrorer.dart';
// // import 'package:taskedin/core/presentation/widgets/main_button.dart';
// // import 'package:taskedin/features/task_cycle/core/domain/repeitition_options.dart';
// // import 'package:taskedin/generated/l10n.dart';
// // import 'package:taskedin/utilities/theme/color_scheme_extension.dart';
// // import 'package:taskedin/utilities/theme/cubit/cubit.dart';

// class TaskDurationSelection extends StatefulWidget {
//   final TextEditingController taskDurationController;
//   final bool showTaskStartDateAndEndDateError;
//   final Function(DateTime, DateTime)? onTaskDateValidatationAccepted;
//   final bool isDatesCleared;

//   const TaskDurationSelection({
//     Key? key,
//     required this.taskDurationController,
//     required this.onTaskDateValidatationAccepted,
//     this.showTaskStartDateAndEndDateError = false,
//     this.isDatesCleared = false,
//   }) : super(key: key);

//   @override
//   State<TaskDurationSelection> createState() => _TaskDurationSelectionState();
// }

// class _TaskDurationSelectionState extends State<TaskDurationSelection> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           isDismissible: true,
//           isScrollControlled: true,
//           builder: (BuildContext context) => SafeArea(
//             child: SelectDate(
//               onTaskDateValidatationAccepted: (startDate, endDate) => widget
//                   .onTaskDateValidatationAccepted!
//                   .call(startDate, endDate),
//             ),
//           ),
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {},
//                 child: SvgPicture.asset("assets/svg/selected_date.svg"),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 "taskDateAndTime",
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: Theme.of(context).hintColor.withOpacity(0.6),
//                     ),
//               ),
//             ],
//           ),
//           Visibility(
//             visible: widget.taskDurationController.text.isNotEmpty,
//             child: const SizedBox(height: 12),
//           ),
//           Visibility(
//             visible: widget.taskDurationController.text.isNotEmpty,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.only(start: 8.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color:
//                               Theme.of(context).disabledColor.withOpacity(0.4),
//                         ),
//                       ),
//                       DottedLine(
//                         direction: Axis.vertical,
//                         dashColor:
//                             Theme.of(context).disabledColor.withOpacity(0.4),
//                         lineLength: 24,
//                       ),
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).errorColor.withRed(220),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.only(start: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.taskDurationController.text,
//                         style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                               fontWeight: FontWeight.w500,
//                               color: Theme.of(context)
//                                   .colorScheme
//                                   .onBackground
//                                   .withOpacity(0.5),
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 6),
//           Divider(
//             indent: 32,
//             thickness: 1.0,
//             color: widget.showTaskStartDateAndEndDateError &&
//                     widget.taskDurationController.text.isEmpty
//                 ? Theme.of(context).errorColor
//                 : Theme.of(context).dividerColor,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SelectDate extends StatefulWidget {
//   const SelectDate({Key? key, required this.onTaskDateValidatationAccepted})
//       : super(key: key);
//   final Function(DateTime, DateTime)? onTaskDateValidatationAccepted;

//   @override
//   _SelectDateState createState() => _SelectDateState();
// }

// class _SelectDateState extends State<SelectDate> {
//   final TextEditingController taskDateController = TextEditingController();
//   String _range = '';
//   final DateTime _initialStartDate =
//       DateTime.now().add(const Duration(minutes: 10));
//   DateTime _startDate = DateTime.now().add(const Duration(minutes: 10));
//   DateTime _endDate = DateTime.now().add(const Duration(hours: 1, minutes: 10));
//   TimeOfDay _startTime =
//       TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 10)));

//   TimeOfDay _endTime = TimeOfDay.fromDateTime(
//       DateTime.now().add(const Duration(hours: 1, minutes: 10)));

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool isDateSelected = false;
//   bool _isTaskDurationBoundariesValid = true;
//   bool _isButtonSelectionENabled = true;

//   // List<RepeititionOption> repeititionOptions = [];

//   late DateRangePickerController _datePickerController;
//   DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

//   @override
//   void initState() {
//     super.initState();
//     _datePickerController = DateRangePickerController();
//     _datePickerController.view = DateRangePickerView.month;
//     _datePickerController.selectedRange = PickerDateRange(
//       DateTime(_startDate.year, _startDate.month, _startDate.day),
//       DateTime(_endDate.year, _endDate.month, _endDate.day),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final monthFormatter = DateFormat('MMM yyyy');
//     return Container(
//       padding: const EdgeInsets.all(12.0),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12.0),
//           topRight: Radius.circular(12.0),
//         ),
//       ),
//       child: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 12),
//               Text(
//                 S.of(context).taskDateAndTime,
//                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 24,
//                     ),
//               ),
//               const SizedBox(height: 8),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           _datePickerController.forward?.call();
//                           final nextMonth = DateTime(
//                             currentMonth.year,
//                             currentMonth.month + 1,
//                           );
//                           setState(() {
//                             currentMonth =
//                                 DateTime(nextMonth.year, nextMonth.month);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios_rounded,
//                           color: Colors.grey[700],
//                           size: 16,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(monthFormatter.format(currentMonth),
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(fontWeight: FontWeight.bold)),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           _datePickerController.backward?.call();
//                           final newDate = DateTime(
//                             currentMonth.year,
//                             currentMonth.month - 1,
//                           );
//                           if (!newDate.isBefore(
//                             DateTime(
//                               DateTime.now().year,
//                               DateTime.now().month,
//                             ),
//                           )) {
//                             setState(() {
//                               currentMonth = newDate;
//                             });
//                           }
//                         },
//                         icon: Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           color: Colors.grey[700],
//                           size: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SfDateRangePicker(
//                     controller: _datePickerController,
//                     monthViewSettings: DateRangePickerMonthViewSettings(
//                       weekendDays: const [5, 6],
//                       viewHeaderStyle: DateRangePickerViewHeaderStyle(
//                         textStyle: TextStyle(
//                           color: Theme.of(context).colorScheme.onBackground,
//                         ),
//                       ),
//                     ),
//                     monthCellStyle: DateRangePickerMonthCellStyle(
//                       disabledDatesTextStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.hintColor,
//                       ),
//                       todayTextStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontSize: 16,
//                       ),
//                       textStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontSize: 16,
//                       ),
//                     ),
//                     selectionRadius: 20,
//                     headerHeight: 0,
//                     cellBuilder: (context, details) {
//                       final isCellSelected =
//                           _datePickerController.selectedRange!.startDate ==
//                                   details.date ||
//                               _datePickerController.selectedRange!.endDate ==
//                                   details.date;
//                       final isCellDisabled = details.date.isBefore(
//                         DateTime(
//                           DateTime.now().year,
//                           DateTime.now().month,
//                           DateTime.now().day,
//                         ),
//                       );
//                       bool isCellInTheSelectedRange = false;
//                       if (_datePickerController.selectedRange?.startDate !=
//                               null &&
//                           _datePickerController.selectedRange?.endDate !=
//                               null) {
//                         isCellInTheSelectedRange = details.date.isAfter(
//                                 _datePickerController
//                                     .selectedRange!.startDate!) &&
//                             details.date.isBefore(
//                                 _datePickerController.selectedRange!.endDate!);
//                       }
//                       if (_datePickerController.view ==
//                           DateRangePickerView.month) {
//                         final locale =
//                             Provider.of<ThemeCubit>(context, listen: false)
//                                 .locale;
//                         final formatter =
//                             NumberFormat.compact(locale: locale.toString());
//                         return Container(
//                           decoration: BoxDecoration(
//                             shape: isCellInTheSelectedRange
//                                 ? BoxShape.rectangle
//                                 : BoxShape.circle,
//                             color: isCellSelected
//                                 ? Theme.of(context)
//                                     .colorScheme
//                                     .dateSelectionColor
//                                 : !isCellInTheSelectedRange
//                                     ? Colors.white
//                                     : Theme.of(context)
//                                         .colorScheme
//                                         .dateRangeSelectionColor,
//                           ),
//                           width: details.bounds.width,
//                           height: details.bounds.width,
//                           alignment: Alignment.center,
//                           child: Text(
//                             formatter.format(details.date.day),
//                             style:
//                                 Theme.of(context).textTheme.subtitle1!.copyWith(
//                                       fontWeight: FontWeight.normal,
//                                       color: !isCellDisabled
//                                           ? isCellSelected
//                                               ? Colors.white
//                                               : Colors.black
//                                           : Colors.grey[400],
//                                     ),
//                           ),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                     rangeTextStyle: TextStyle(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 16,
//                     ),
//                     allowViewNavigation: false,
//                     onSelectionChanged:
//                         (DateRangePickerSelectionChangedArgs args) {
//                       setState(() {
//                         if (args.value is PickerDateRange) {
//                           _range =
//                               '${DateFormat("dd MMMM yyyy").format(args.value.startDate)} \n${DateFormat("dd MMMM yyyy").format(args.value.endDate ?? args.value.startDate)}';
//                           taskDateController.text = _range;
//                           _startDate = args.value.startDate;
//                           _startDate = DateTime(
//                             _startDate.year,
//                             _startDate.month,
//                             _startDate.day,
//                             _startTime.hour,
//                             _startTime.minute,
//                           );
//                           _endDate = args.value.endDate ?? args.value.startDate;
//                           _endDate = DateTime(
//                             _endDate.year,
//                             _endDate.month,
//                             _endDate.day,
//                             _endTime.hour,
//                             _endTime.minute,
//                           );
//                           isDateSelected = true;
//                           _isButtonSelectionENabled = true;
//                         }
//                       });
//                     },
//                     selectionTextStyle: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     headerStyle: DateRangePickerHeaderStyle(
//                       textStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontSize: 16,
//                       ),
//                     ),
//                     rangeSelectionColor:
//                         Theme.of(context).colorScheme.dateRangeSelectionColor,
//                     selectionMode: DateRangePickerSelectionMode.range,
//                     minDate: DateTime.now().add(const Duration(minutes: 10)),
//                     initialSelectedDates: [
//                       DateTime.now().add(const Duration(minutes: 10))
//                     ],
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const SizedBox(height: 16),
//               _TaskTimeSelection(
//                 label: S.of(context).startTime,
//                 initial: _startDate,
//                 dateTimeBoundry: _initialStartDate,
//                 onChanged: (DateTime startTime) {
//                   setState(() {
//                     _isButtonSelectionENabled = true;
//                     _startTime = TimeOfDay.fromDateTime(startTime);
//                     _startDate = DateTime(
//                       _startDate.year,
//                       _startDate.month,
//                       _startDate.day,
//                       _startTime.hour,
//                       _startTime.minute,
//                     );
//                   });
//                 },
//               ),
//               const SizedBox(height: 12),
//               _TaskTimeSelection(
//                 label: S.of(context).endTime,
//                 initial: _endDate,
//                 dateTimeBoundry: _startDate,
//                 isStartTime: false,
//                 onChanged: (DateTime endTime) {
//                   setState(() {
//                     _isButtonSelectionENabled = true;
//                     _endTime = TimeOfDay.fromDateTime(endTime);
//                     _endDate = DateTime(
//                       _endDate.year,
//                       _endDate.month,
//                       _endDate.day,
//                       _endTime.hour,
//                       _endTime.minute,
//                     );
//                   });
//                 },
//               ),
//               const SizedBox(height: 12),
//               Visibility(
//                 visible: !_isTaskDurationBoundariesValid,
//                 child: Text(
//                   _getTaskDateValidationMessages(
//                         context: context,
//                         startDateTime: _startDate,
//                         endDateTime: _endDate,
//                       ) ??
//                       "",
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                         color: Theme.of(context).errorColor,
//                         height: 1,
//                       ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               MainButton(
//                 S.of(context).select,
//                 isEnabled: _isButtonSelectionENabled,
//                 textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).colorScheme.onSecondary,
//                     ),
//                 onTap: () {
//                   if (_isButtonSelectionENabled) {
//                     _startDate = DateTime(
//                       _startDate.year,
//                       _startDate.month,
//                       _startDate.day,
//                       _startTime.hour,
//                       _startTime.minute,
//                     );
//                     _endDate = DateTime(
//                       _endDate.year,
//                       _endDate.month,
//                       _endDate.day,
//                       _endTime.hour,
//                       _endTime.minute,
//                     );
//                     _isTaskDurationBoundariesValid =
//                         _validateTaskDurationBoundaries(
//                       context: context,
//                       startDateTime: _startDate,
//                       endDateTime: _endDate,
//                     );
//                     setState(
//                       () {
//                         log("_isTaskDurationBoundariesValid $_isTaskDurationBoundariesValid");
//                         if (_isTaskDurationBoundariesValid) {
//                           widget.onTaskDateValidatationAccepted!
//                               .call(_startDate, _endDate);
//                           Navigator.of(context).pop();
//                         }
//                       },
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TaskTimeSelection extends StatefulWidget {
//   final Function(DateTime)? onChanged;
//   final DateTime initial;
//   final DateTime dateTimeBoundry;
//   final String label;
//   final bool isStartTime;

//   const _TaskTimeSelection({
//     Key? key,
//     required this.onChanged,
//     required this.label,
//     required this.dateTimeBoundry,
//     this.isStartTime = true,
//     required this.initial,
//   }) : super(key: key);

//   @override
//   __TaskTimeSelectionState createState() => __TaskTimeSelectionState();
// }

// class __TaskTimeSelectionState extends State<_TaskTimeSelection> {
//   final taskTimeSelectionHourController = TextEditingController();
//   final taskTimeSelectionMinuteController = TextEditingController();
//   DateTime? currentlySelectedTime;

//   @override
//   void initState() {
//     super.initState();
//     currentlySelectedTime = widget.initial;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.30,
//           child: Text(
//             widget.label,
//             style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: InkWell(
//               onTap: () => showCupertinoModalPopup(
//                 context: context,
//                 builder: (_) => CupertinoAlertDialog(
//                   title: Text(
//                     widget.label,
//                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   content: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.25,
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     child: CupertinoTheme(
//                       data: CupertinoThemeData(
//                         textTheme: CupertinoTextThemeData(
//                           dateTimePickerTextStyle:
//                               Theme.of(context).textTheme.bodyText2,
//                         ),
//                       ),
//                       child: CupertinoDatePicker(
//                         initialDateTime: widget.initial,
//                         minimumDate: widget.dateTimeBoundry,
//                         mode: CupertinoDatePickerMode.time,
//                         onDateTimeChanged: (value) {
//                           setState(() {
//                             currentlySelectedTime = value;
//                             widget.onChanged!.call(value);
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   actions: [
//                     CupertinoDialogAction(
//                       isDefaultAction: true,
//                       onPressed: () => Navigator.of(context).pop(),
//                       textStyle:
//                           Theme.of(context).textTheme.bodyText1?.copyWith(
//                                 color: Theme.of(context).accentColor,
//                               ),
//                       child: Text(
//                         S.of(context).ok,
//                       ),
//                     ),
//                     CupertinoDialogAction(
//                       isDestructiveAction: true,
//                       onPressed: () {
//                         setState(() {
//                           currentlySelectedTime = widget.initial;
//                         });
//                         Navigator.of(context).pop();
//                       },
//                       textStyle:
//                           Theme.of(context).textTheme.bodyText1?.copyWith(
//                                 color: Colors.red,
//                               ),
//                       child: Text(S.of(context).cancel),
//                     )
//                   ],
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).dividerColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18.0,
//                   vertical: 4.0,
//                 ),
//                 child: Text(
//                   DateFormat("hh:mm a").format(currentlySelectedTime!),
//                   style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                         fontSize: 20.0,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// String? _getTaskDateValidationMessages({
//   required BuildContext context,
//   required DateTime startDateTime,
//   required DateTime endDateTime,
// }) {
//   if (startDateTime.isBefore(DateTime.now())) {
//     return S.of(context).inValidStartTime;
//   }
//   if (endDateTime.isBefore(startDateTime)) {
//     return S.of(context).startDateMustBeBeforeEndDate;
//   }
//   if (endDateTime.isAfter(startDateTime.add(const Duration(days: 90)))) {
//     return S.of(context).taskEndDateCanNotBeMoreThanThreeMonths;
//   } else if (endDateTime.isAtSameMomentAs(startDateTime)) {
//     return S.of(context).startDateMustBeBeforeEndDate;
//   }
// }

// bool _validateTaskDurationBoundaries({
//   required BuildContext context,
//   required DateTime startDateTime,
//   required DateTime endDateTime,
// }) {
//   if (startDateTime.isBefore(DateTime.now())) {
//     return false;
//   }
//   if (endDateTime.isBefore(startDateTime)) {
//     return false;
//   } else if (endDateTime.isAtSameMomentAs(startDateTime)) {
//     return false;
//   }
//   if (endDateTime.isAfter(startDateTime.add(const Duration(days: 90)))) {
//     return false;
//   }
//   return true;
// }
