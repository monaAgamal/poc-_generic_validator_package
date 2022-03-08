import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomGenericTextFiled extends StatefulWidget {
  final TextEditingController editingController;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  // final String? Function(String)? validator;
  final TextInputType textInputType;
  final bool isOptionalField;
  final bool obscureText;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final String? label;
  final int? maxLength;
  final bool isAuthorized;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double? cursorHeight;
  final EdgeInsets contentPadding;
  final String? hintText;
  final int? maxLines;
  final int minLines;
  final FormFieldValidator<String>? validator;

  const CustomGenericTextFiled(
    this.editingController, {
    this.focusNode,
    this.maxLines,
    this.minLines = 1,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.isOptionalField = false,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.suffix,
    this.textStyle,
    this.onChanged,
    this.label,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 5),
    this.hintText,
    this.hintStyle,
    this.maxLength,
    this.cursorHeight,
    this.isAuthorized = false,
  });

  @override
  __CustomTextFiledState createState() => __CustomTextFiledState();
}

class __CustomTextFiledState extends State<CustomGenericTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.editingController,
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      onEditingComplete: widget.textInputAction == TextInputAction.next
          ? () => FocusScope.of(context).requestFocus(widget.nextFocusNode)
          : null,
      style: widget.textStyle,
      cursorHeight: widget.cursorHeight,
      maxLength: widget.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) {
        if (maxLength != null) {
          final isRTL = Directionality.of(context) == TextDirection.rtl;
          // final currentCount = NumberFormat(
          //       "##",
          //       BlocProvider.of<ThemeCubit>(context, listen: false)
          //           .locale
          //           .toString(),
          //     ).format(isRTL ? maxLength : currentLength) +
          //     NumberFormat(
          //       "/##",
          //       BlocProvider.of<ThemeCubit>(context, listen: false)
          //           .locale
          //           .toString(),
          //     ).format(isRTL ? currentLength : maxLength);
          return Text(
            maxLength.toString(),
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7),
                ),
          );
        }
      },
      decoration: InputDecoration(
        hintStyle: widget.hintStyle ??
            Theme.of(context)
                .inputDecorationTheme
                .hintStyle!
                .copyWith(fontSize: 18),
        suffixIcon: widget.suffix,
        hintText: widget.hintText,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: UnderlineInputBorder(),
        disabledBorder: InputBorder.none,
        errorStyle:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
        focusedErrorBorder: UnderlineInputBorder(),
        filled: false,
        isDense: true,
        contentPadding: widget.contentPadding,
        counterStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .hintStyle
                  ?.color!
                  .withOpacity(0.5),
            ),
      ),
    );
  }

  String? textValidator(
    String val,
    BuildContext context,
    String? Function(String)? validator,
  ) {
    if (val.isEmpty) {
      return "thisFieldIsRequired";
    }
    return validator != null ? validator(val) : null;
  }
}
