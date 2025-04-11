import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: SquareAnimation(),
        ),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const double _squareSize = 50.0;
  double _position = 0.0; // Horizontal offset in pixels
  double _maxPosition = 0.0; // Max distance square can move
  bool _isAnimating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Calculate center position when layout is available
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _maxPosition = screenWidth - _squareSize - 64; // 64 for padding (32 left + 32 right)
      _position = _maxPosition / 2;
    });
  }

  void _moveLeft() async {
    setState(() => _isAnimating = true);
    await Future.delayed(const Duration(milliseconds: 10)); // allow state update
    setState(() => _position = 0.0);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isAnimating = false);
  }

  void _moveRight() async {
    setState(() => _isAnimating = true);
    await Future.delayed(const Duration(milliseconds: 10));
    setState(() => _position = _maxPosition);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                left: _position,
                top: 50,
                child: Container(
                  width: _squareSize,
                  height: _squareSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (_isAnimating || _position <= 0) ? null : _moveLeft,
              child: const Text('To Left'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: (_isAnimating || _position >= _maxPosition) ? null : _moveRight,
              child: const Text('To Right'),
            ),
          ],
        ),
      ],
    );
  }
}



