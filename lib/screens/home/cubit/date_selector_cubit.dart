import 'package:bloc/bloc.dart';
import 'package:o_asistent/utils/datetime_utils.dart';

final _minDate = DateTime(_getStartSchoolYear(), DateTime.september);
final _maxDate = DateTime(_getStartSchoolYear() + 1, DateTime.september, -1);

class DateSelectorCubit extends Cubit<DateTime> {
  DateSelectorCubit() : super(_getDefaultDate());

  void nextDay() {
    int add = 1;
    switch (state.date.weekday) {
      case DateTime.friday:
        add += 2;
        break;
      case DateTime.sunday:
        ++add;
        break;
    }

    final newDate = state.date.pureAdd(add);

    if (newDate.isAfter(_maxDate)) return;
    emit(newDate);
  }

  void prevDay() {
    int sub = 1;
    switch (state.date.weekday) {
      case DateTime.monday:
        sub += 2;
        break;
      case DateTime.sunday:
        ++sub;
        break;
    }

    final newDate = state.date.pureSub(sub);

    if (newDate.isBefore(_minDate)) return;
    emit(newDate);
  }
}

int _getStartSchoolYear() {
  final now = DateTime.now();
  return now.month < DateTime.september ? now.year - 1 : now.year;
}

DateTime _getDefaultDate() {
  final now = DateTime.now();
  return now.date.pureAdd(now.weekday > DateTime.friday ? 8 - now.weekday : 0);
}
