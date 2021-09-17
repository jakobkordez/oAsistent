import 'package:bloc/bloc.dart';
import 'package:easistent_client/easistent_client.dart';
import 'package:equatable/equatable.dart';
import 'package:o_asistent/repositories/eas_repository.dart';

part 'time_table_state.dart';

class TimeTableCubit extends Cubit<TimeTableState> {
  final EAsRepository eAsRepository;

  TimeTableCubit(this.eAsRepository) : super(const TimeTableInitial());

  Future<void> _getTimeTable({DateTime? date, bool clearCache = false}) async {
    if (state is TimeTableInitial && date == null) return;

    final datet = date ?? (state as StateWithDate).date;

    emit(TimeTableLoading(datet));
    try {
      final timeTable = await eAsRepository.getTimeTable(datet, clearCache);
      emit(TimeTableLoaded(datet, timeTable));
    } on EAsError catch (e, _) {
      emit(TimeTableError(datet, e.userMessage ?? e.developerMessage));
    }
  }

  Future<void> setDate(DateTime date, [bool refresh = false]) =>
      _getTimeTable(date: date, clearCache: refresh);

  Future<void> refresh() => _getTimeTable(clearCache: true);
}
