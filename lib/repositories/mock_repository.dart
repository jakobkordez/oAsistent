import 'package:easistent_client/easistent_client.dart';
import 'package:o_asistent/utils/timetable_generator.dart';

import 'eas_repository.dart';

class MockEAsRepository implements EAsRepository {
  @override
  Future<TimeTable> getTimeTable(
    DateTime date, [
    bool clearCache = false,
  ]) async =>
      generateTimeTable(date);
}
