import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const int maxSeed = 250;

void main() => runApp(const Sunflower extends StatefulWidget());

class Sunflower extends StatefulWidget {
  const Sunflower ({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  int seeds = maxSeed ~/2;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(elevation: 2),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sunflower')
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SunflowerWidget (seeds),
              ),
              const SizedBox(height: 20),
              Text('Showing ${seeds.round()} seeds'),
              SizedBox(
                width: 300,
                child: Slider(
                  min: 1,
                  max: maxSeed.toDouble(),
                  value: seeds.toDouble(),
                  onChanged: (val) {
                    setState(()=>seeds=val.round());
                  },
                ),
              ),
              const SizedBox(height: 20,)
            ],
          )
        ),
      )
    )
  }
}

class SunflowerWidget extends StatelessWidget {
  static const tau = math.pi *2;
  static const scaleFactor = 1/40;
  static const size = 600.0;
  static final phi = (math.sqrt(5)+1)/2;
  static final rng = math.Random();
  final int seeds;
  const SunflowerWidget(this.seeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final seedWidgets = <Widget> [];
    for(var i = 0; i < seeds; i++){
      final theta = i * tau/phi;
      final r = math.sqrt(i)*scaleFactor;
      seedWidgets.add(AnimatedAlign(
          key: ValueKey(i),
          duration: Duration(microseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(r+math.cos(theta), -1 * r * math.sin(theta)),
          child: const Dot (true),));
    }
  }
}

class Dot extends StatelessWidget {
  static const size = 5.0;
  static const radius = 5.0;
  final bool lit;
  const Dot (this.lit, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: decoration)
  }
}
