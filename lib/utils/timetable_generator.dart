import 'dart:math';
import 'dart:ui';

import 'package:easistent_client/easistent_client.dart';

TimeTable generateTimeTable(DateTime date) => date.weekday > 5
    ? TimeTable([], [], [])
    : TimeTable(
        List.generate(
            17,
            (index) => [
                  SchoolHourEvent(
                    DateTime(date.year, date.month, date.day, index + 7),
                    DateTime(date.year, date.month, date.day, index + 8),
                    _getRandomColor(),
                    _getRandomSubject(),
                    null,
                    [_getRandomDepartment()],
                    _getRandomClassroom(),
                    [_getRandomTeacher()],
                    [_getRandomGroup()],
                  ),
                  if (Random().nextDouble() > 0.7)
                    SchoolHourEvent(
                      DateTime(date.year, date.month, date.day, index + 7),
                      DateTime(date.year, date.month, date.day, index + 8),
                      _getRandomColor(),
                      _getRandomSubject(),
                      null,
                      [_getRandomDepartment()],
                      _getRandomClassroom(),
                      [_getRandomTeacher()],
                      [_getRandomGroup()],
                    ),
                ]).expand((e) => e),
        [],
        [],
      );

const _subjects = [
  'MAT',
  'SLO',
  'PSI',
  'ANG',
  'FRA',
  'RUS',
  'ŠPA',
  'ZGO',
  'SOC'
];

String _getRandomSubject() => _subjects[Random().nextInt(_subjects.length)];

const _departments = ['Dep1', 'Dep2', 'Dep3'];

String _getRandomDepartment() =>
    _departments[Random().nextInt(_departments.length)];

final _classrooms = List.generate(7, (index) => 'CS$index');

String _getRandomClassroom() =>
    _classrooms[Random().nextInt(_classrooms.length)];

const _teachers = [
  'Janez Novak',
  'Franc Horvat',
  'Marko Kovač',
  'Marija Kranjc',
  'Irena Zupančič',
  'Mojca Potočnik',
];

String _getRandomTeacher() => _teachers[Random().nextInt(_teachers.length)];

final _groups = List.generate(3, (index) => 'G$index');

String _getRandomGroup() => _groups[Random().nextInt(_groups.length)];

const _colors = [
  0xff3cb13d,
  0xff3c9d61,
  0xff403f9c,
  0xff52cd87,
  0xff43a67c,
  0xffcec561,
  0xffbb8d55,
  0xffb78e33,
  0xffbd536e,
  0xff3765a1,
  0xffaa4048,
];

Color _getRandomColor() => Color(_colors[Random().nextInt(11)]);
