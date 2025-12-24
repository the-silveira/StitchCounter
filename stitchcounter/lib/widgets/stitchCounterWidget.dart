// widgets/stitch_counter_widget.dart
import 'package:flutter/material.dart';
import 'package:stitchcounter/models/stitchCounter.dart';

class StitchCounterWidget extends StatefulWidget {
  final StitchCounter counter;
  final VoidCallback onIncrement;
  final VoidCallback onReset;
  final VoidCallback onDecrease;

  const StitchCounterWidget({
    super.key,
    required this.counter,
    required this.onIncrement,
    required this.onReset,
    required this.onDecrease,
  });

  @override
  State<StitchCounterWidget> createState() => _StitchCounterWidgetState();
}

class _StitchCounterWidgetState extends State<StitchCounterWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onIncrement();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: _isPressed
              ? colorScheme.primary.withOpacity(0.2)
              : colorScheme.primary.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'STITCHES',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 15), // Reduced

            // Counter Display
            Container(
              width: 130, // Reduced
              height: 130, // Reduced
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${widget.counter.count}',
                  style: TextStyle(
                    fontSize: 44, // Reduced
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Reduced

            // Buttons Row - Place both buttons in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reset Button
                ElevatedButton.icon(
                  onPressed: widget.onReset,
                  icon: Icon(
                    Icons.refresh,
                    size: 18, color: colorScheme.onPrimary, // Reduced
                  ),
                  label: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 14), // Reduced
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // Reduced
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                // Decrease Button
                ElevatedButton.icon(
                  onPressed: widget.onDecrease,
                  icon: Icon(Icons.remove,
                      size: 18, color: colorScheme.onPrimary // Reduced
                      ),
                  label: const Text(
                    'Decrease',
                    style: TextStyle(fontSize: 14), // Reduced
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // Reduced
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
