import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color _whiten(Color color) =>
    Color.alphaBlend(color.withAlpha(60), Colors.white);

class HourEventCard extends StatelessWidget {
  final SchoolHourEvent event;

  const HourEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        color: _whiten(event.color),
        shadowColor: event.color,
        child: _HourEventContent(event: event),
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
            style: const TextStyle(color: _color),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(event.subject, textScaleFactor: 1.4),
                    Text('${_hm(event.timeFrom)} - ${_hm(event.timeTo)}')
                  ],
                ),
                const SizedBox(height: 5),
                _SubInfo(
                  icon: const Icon(Icons.location_on),
                  text: Text(event.classroom),
                ),
                _SubInfo(
                  icon: const Icon(Icons.person),
                  text: Text(event.teachers.join(', ')),
                ),
              ],
            ),
          ),
        ),
      );

  static String _hm(DateTime time) => DateFormat.Hm().format(time);
}

class _SubInfo extends StatelessWidget {
  final Widget icon;
  final Widget text;

  const _SubInfo({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 3),
            text,
          ],
        ),
      );
}
