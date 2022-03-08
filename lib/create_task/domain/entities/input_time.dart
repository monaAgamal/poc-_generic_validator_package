
import 'package:equatable/equatable.dart';

class InputTime extends Equatable {
  final int numOfHours;
  final int numOfMinutes;

  const InputTime({
    required this.numOfHours,
    required this.numOfMinutes,
  });
  InputTime copyWith({
    int? numOfHours,
    int? numOfMinutes,
  }) {
    return InputTime(
      numOfMinutes: numOfMinutes ?? this.numOfMinutes,
      numOfHours: numOfHours ?? this.numOfHours,
    );
  }

  bool get isEmpty => numOfMinutes == 0 && numOfHours == 0;
  int get value => numOfMinutes * 60 + numOfHours * 60 * 60;

  @override
  List<Object?> get props => [
        numOfMinutes,
        numOfHours,
      ];
}
