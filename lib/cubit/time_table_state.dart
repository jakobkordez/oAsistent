part of 'time_table_cubit.dart';

abstract class TimeTableState extends Equatable {
  const TimeTableState();

  @override
  List<Object?> get props => [];
}

abstract class StateWithDate {
  DateTime get date;
}

class TimeTableInitial extends TimeTableState {
  const TimeTableInitial();
}

class TimeTableError extends TimeTableState implements StateWithDate {
  @override
  final DateTime date;
  final String error;

  const TimeTableError(this.date, this.error);

  @override
  List<Object?> get props => [date, error];
}

class TimeTableLoading extends TimeTableState implements StateWithDate {
  @override
  final DateTime date;

  const TimeTableLoading(this.date);

  @override
  List<Object?> get props => [date];
}

class TimeTableLoaded extends TimeTableState implements StateWithDate {
  @override
  final DateTime date;
  final TimeTable timeTable;

  const TimeTableLoaded(this.date, this.timeTable);

  @override
  List<Object?> get props => [date, timeTable];
}
