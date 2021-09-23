import 'package:collection/collection.dart';

extension IterableGrouper<T> on Iterable<T> {
  Iterable<List<T>> group(dynamic Function(T a) selector) =>
      groupBy(this, selector).values;
}
