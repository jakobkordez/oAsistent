import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _hm(DateTime time) => DateFormat.Hm().format(time);

Color _whiten(Color color) =>
    Color.alphaBlend(color.withAlpha(60), Colors.white);

class HourEventsCard extends StatelessWidget {
  final List<SchoolHourEvent> events;

  const HourEventsCard({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) => events.length > 2
      ? LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: events
                  .map((e) => SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: HourEventCard(event: e),
                      ))
                  .toList(),
            ),
          ),
        )
      : Row(
          children: events
              .map((e) => Expanded(child: HourEventCard(event: e)))
              .toList(),
        );
}

class HourEventCard extends StatelessWidget {
  final SchoolHourEvent event;

  const HourEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shadowColor: event.color,
        child: ClipRRect(
          borderRadius:
              (Theme.of(context).cardTheme.shape as RoundedRectangleBorder)
                  .borderRadius as BorderRadius,
          child: HourEventContainer(event: event),
        ),
      );
}

class HourEventsContainer extends StatelessWidget {
  final List<SchoolHourEvent> events;

  const HourEventsContainer({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: events
              .map((e) => Expanded(child: HourEventContainer(event: e)))
              .toList(),
        ),
      );
}

class HourEventContainer extends StatelessWidget {
  final SchoolHourEvent event;

  const HourEventContainer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        color: _whiten(event.color),
        child: _HourEventContent(event: event),
      );
}

class _HourEventContent extends StatelessWidget {
  static const _color = Color(0xbb000000);

  final SchoolHourEvent event;

  const _HourEventContent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          if (event.specialHourType != null)
            Positioned(
              top: 10,
              right: 10,
              height: 18,
              width: 18,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _getSpecialHourColor(),
                ),
                alignment: Alignment.center,
                child: Text(
                  _getSpecialHourLetter(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: DefaultTextStyle(
              style:
                  Theme.of(context).textTheme.subtitle1!.apply(color: _color),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.subject,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.apply(color: _color),
                  ),
                  const SizedBox(height: 6),
                  Text('${_hm(event.timeFrom)} - ${_hm(event.timeTo)}'),
                  const SizedBox(height: 6),
                  Text('${_getTeachers()}, ${event.classroom}'),
                ],
              ),
            ),
          ),
        ],
      );

  Color _getSpecialHourColor() {
    switch (event.specialHourType!) {
      case SpecialHourType.assignment:
        return Colors.purple.shade400;
      case SpecialHourType.cancelled:
        return Colors.red.shade700;
      case SpecialHourType.exam:
        return Colors.green;
      case SpecialHourType.substitution:
        return Colors.blue;
    }
  }

  String _getSpecialHourLetter() {
    switch (event.specialHourType!) {
      case SpecialHourType.assignment:
        return 'Z';
      case SpecialHourType.cancelled:
        return 'O';
      case SpecialHourType.exam:
        return 'I';
      case SpecialHourType.substitution:
        return 'N';
    }
  }

  String _getTeachers() => event.teachers
      .map((e) => e.split(' '))
      .map((e) =>
          '${e.take(e.length - 1).map((e) => '${e.characters.first}. ').join()}${e.last}')
      .join(', ');
}
