import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovingSquarePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// A stateful widget to display and move the square.
class MovingSquarePage extends StatefulWidget {
  const MovingSquarePage({super.key});

  @override
  State<MovingSquarePage> createState() => _MovingSquarePageState();
}

class _MovingSquarePageState extends State<MovingSquarePage> {
  Alignment _squarePosition = Alignment.center;
  bool _isAnimating = false;

  /// Triggers the square to move to a new alignment with animation.
  Future<void> moveSquare(Alignment newPosition) async {
    setState(() {
      _squarePosition = newPosition;
      _isAnimating = true;
    });

    // Wait for animation to complete (1 second)
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAtLeft = _squarePosition == Alignment.centerLeft;
    final bool isAtRight = _squarePosition == Alignment.centerRight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moving Square'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// The animated red square
          Expanded(
            child: AnimatedAlign(
              alignment: _squarePosition,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),

          // Control buttons to move the square
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (_isAnimating || isAtLeft)
                    ? null
                    : () => moveSquare(Alignment.centerLeft),
                child: const Text('To Left'),
              ),
              ElevatedButton(
                onPressed: (_isAnimating || isAtRight)
                    ? null
                    : () => moveSquare(Alignment.centerRight),
                child: const Text('To Right'),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
} 