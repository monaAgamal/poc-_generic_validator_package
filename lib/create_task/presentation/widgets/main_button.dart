import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:taskedin/utilities/theme/color_scheme_extension.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool hasBorderRadius;
  final bool isIndicator;
  final bool isEnabled;
  final Color? btnBackgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? width;

  const MainButton(
    this.text, {
    @required this.onTap,
    this.hasBorderRadius = true,
    this.isIndicator = false,
    this.isEnabled = false,
    this.textStyle,
    this.btnBackgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: width,
        height: MediaQuery.of(context).size.height * 0.075,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isEnabled
              // ignore: deprecated_member_use
              ? btnBackgroundColor ?? Theme.of(context).accentColor
              : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isIndicator
            ? const SpinKitCircle(color: Colors.white, size: 32)
            : Text(
                text,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: textColor ??
                              Theme.of(context).colorScheme.onSecondary,
                        ),
              ),
      ),
    );
  }
}
