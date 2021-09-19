extension IterableGrouper<T> on Iterable<T> {
  Iterable<List<T>> group(dynamic Function(T a) selector) {
    final res = <dynamic, List<T>>{};
    for (var item in this) {
      final key = selector(item);
      if (res.containsKey(key)) {
        res[key]!.add(item);
      } else {
        res[key] = [item];
      }
    }
    return res.values;
  }
}
