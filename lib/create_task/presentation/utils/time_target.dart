import 'package:flutter/widgets.dart';

extension TimeTargetMappers on TimeTarget {
  String title(BuildContext context) {
    switch (this) {
      case TimeTarget.expected:
        return "expectedTime";
      case TimeTarget.actual:
        return "actualTime";
      case TimeTarget.estimation:
        return "estimatedTime";
    }
  }
}

enum TimeTarget { expected, actual, estimation }
