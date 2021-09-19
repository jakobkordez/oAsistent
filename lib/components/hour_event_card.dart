import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO events.count > 3

String _hm(DateTime time) => DateFormat.Hm().format(time);

Color _whiten(Color color) =>
    Color.alphaBlend(color.withAlpha(60), Colors.white);

class HourEventsCard extends StatelessWidget {
  final List<SchoolHourEvent> events;

  const HourEventsCard({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shadowColor: events.length == 1 ? events.first.color : null,
        child: ClipRRect(
          borderRadius:
              (Theme.of(context).cardTheme.shape as RoundedRectangleBorder)
                  .borderRadius as BorderRadius,
          child: HourEventsContainer(events: events),
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
              .map((e) => Expanded(
                    child: HourEventContainer(event: e),
                  ))
              .toList(),
        ),
      );
}

class HourEventContainer extends StatelessWidget {
  final SchoolHourEvent event;

  const HourEventContainer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: _whiten(event.color),
        child: _HourEventContent(event: event),
      );
}

class _HourEventContent extends StatelessWidget {
  static const _color = Color(0xbb000000);

  final SchoolHourEvent event;

  const _HourEventContent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: IconTheme(
          data: const IconThemeData(size: 16, color: _color),
          child: DefaultTextStyle(
            style: const TextStyle(color: _color, fontSize: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.subject,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text('${_hm(event.timeFrom)} - ${_hm(event.timeTo)}'),
                const SizedBox(height: 6),
                Text('${event.teachers.join(', ')}, ${event.classroom}'),
              ],
            ),
          ),
        ),
      );
}
