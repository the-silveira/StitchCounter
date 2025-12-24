// screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:stitchcounter/controller/counterController.dart';
import 'package:stitchcounter/widgets/roundCounterWidget.dart';
import 'package:stitchcounter/widgets/stitchCounterWidget.dart';

class CounterUI extends StatefulWidget {
  const CounterUI({super.key});

  @override
  State<CounterUI> createState() => _CounterUIState();
}

class _CounterUIState extends State<CounterUI> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45), // Reduced from default 56
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.eco,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 24, // Slightly smaller icon
              ),
              const SizedBox(width: 8), // Reduced spacing
              const Text(
                'Crochet Helper',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Reduced font size
                ),
              ),
              const SizedBox(width: 8), // Reduced spacing
              Icon(
                Icons.eco,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 24, // Slightly smaller icon
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 2, // Reduced elevation
          centerTitle: true,
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Force landscape layout
          return Row(
            children: [
              // Left side - Stitch Counter (takes half)
              Expanded(
                child: StitchCounterWidget(
                  counter: _controller.stitchCounter,
                  onIncrement: () =>
                      setState(() => _controller.incrementStitch()),
                  onReset: () => setState(() => _controller.resetStitch()),
                  onDecrease: () =>
                      setState(() => _controller.decreaseStitch()),
                ),
              ),

              // Vertical Divider
              Container(
                width: 1,
                color: Colors.grey[300],
              ),

              // Right side - Round Counter (takes half)
              Expanded(
                child: RoundCounterWidget(
                  counter: _controller.roundCounter,
                  onIncrement: () =>
                      setState(() => _controller.incrementRound()),
                  onReset: () => setState(() => _controller.resetRound()),
                  onDecrease: () => setState(() => _controller.decreaseRound()),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.resetAll();
          });
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
