import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;

class GenericTextField extends StatefulWidget {
  final TextEditingController editingController;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? Function(String)? validator;
  final TextInputType textInputType;
  final bool isOptionalField;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final String? label;
  final int? maxLength;
  final bool isAuthorized;
  final bool isEnabled;
  final TextStyle? hintStyle;
  final Color colorStyle;
  final int maxLines;
  final int minLines;
  final List<TextInputFormatter>? inputFormatter;

  ///this style is passed when the style of label is bold in some forms ex: set company form
  final TextStyle? labelStyle;
  final EdgeInsets contentPadding;
  final String? hintText;

  const GenericTextField(
    this.editingController, {
    this.focusNode,
    this.inputFormatter,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefix,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.isOptionalField = false,
    this.obscureText = false,
    this.labelStyle,
    this.textInputType = TextInputType.text,
    this.suffix,
    this.onChanged,
    this.label,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
    this.hintText,
    this.colorStyle = Colors.black45,
    this.maxLength,
    this.isAuthorized = false,
    this.isEnabled = true,
    this.hintStyle,
  });

  @override
  _GenericTextFieldState createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: !widget.isOptionalField
          ? (val) {
              return textValidator(
                val!,
                context,
                widget.validator,
              );
            }
          : null,
      controller: widget.editingController,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onEditingComplete: widget.textInputAction == TextInputAction.next
          ? () => FocusScope.of(context).requestFocus(widget.nextFocusNode)
          : null,
      maxLength: widget.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) {
        if (maxLength != null) {
          // final isRTL = Directionality.of(context) == TextDirection.rtl;
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
            currentLength.toString(),
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7),
                ),
          );
        }
      },
      cursorHeight: 20,
      obscuringCharacter: "*",
      cursorColor: Theme.of(context).colorScheme.secondary,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: widget.colorStyle,
          ),
      inputFormatters: widget.inputFormatter,
      decoration: widget.isAuthorized
          ? InputDecoration(
              isCollapsed: true,
              enabled: widget.isEnabled,
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  Theme.of(context).inputDecorationTheme.hintStyle,
              enabledBorder: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(),
              errorBorder: UnderlineInputBorder(),
              disabledBorder: UnderlineInputBorder(),
              errorStyle: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Theme.of(context).errorColor),
              focusedErrorBorder: UnderlineInputBorder(),
              filled: false,
              isDense: true,
              contentPadding: widget.contentPadding,
            )
          : InputDecoration(
              hintText: widget.hintText,
              suffixIcon: widget.suffix,
              isDense: true,
              contentPadding: widget.contentPadding,
              errorStyle: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Theme.of(context).errorColor),
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
