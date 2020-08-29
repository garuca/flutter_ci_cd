import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController _controller;
  double value = 0.5;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = 0.74
      ..addListener(() {
        setState(() {
          // Rebuild the widget at each frame to update the "progress" label.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animation control'),
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Lottie.asset(
              'assets/toggle-day-and-night.json',
              controller: _controller,
              height: 300,
              onLoaded: (composition) {
                setState(() {
                  _controller.duration = composition.duration;
                });
              },
            ),
            Text('${_controller.value.toStringAsFixed(4)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Play backward
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    _controller.animateTo(7.4);
                  },
                ),
                // Pause
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    _controller.stop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.repeat),
                  onPressed: () {
                    _controller.repeat();
                  },
                ),
                // Play forward
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    _controller.animateTo(0.5);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Slider(
              value: value,
              min: 0.50,
              max: 0.74,
              onChanged: (value) {
                setState(() {
                  this.value = value;
                  _controller.value = value = 0.74 + (0.5 - value);
                  print(value = 0.74 + (0.5 - value));
                });

                //_controller.value = 0.74+(0.5-_controller.value);
              },
            )
          ],
        ),
      ),
    );
  }
}
