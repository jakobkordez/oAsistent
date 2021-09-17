import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: const [
            Center(
              child: Icon(
                Icons.calendar_today,
                size: 70,
                color: Colors.white,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'oA',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
}
