extension DateTimeTools on DateTime {
  DateTime get date => DateTime(year, month, day);

  DateTime pureAdd(int days) => DateTime(
      year, month, day + days, hour, minute, second, millisecond, microsecond);

  DateTime pureSub(int days) => DateTime(
      year, month, day - days, hour, minute, second, millisecond, microsecond);
}
