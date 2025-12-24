// widgets/round_counter_widget.dart
import 'package:flutter/material.dart';
import 'package:stitchcounter/models/roundCounter.dart';

class RoundCounterWidget extends StatefulWidget {
  final RoundCounter counter;
  final VoidCallback onIncrement;
  final VoidCallback onReset;
  final VoidCallback onDecrease;

  const RoundCounterWidget({
    super.key,
    required this.counter,
    required this.onIncrement,
    required this.onReset,
    required this.onDecrease,
  });

  @override
  State<RoundCounterWidget> createState() => _RoundCounterWidgetState();
}

class _RoundCounterWidgetState extends State<RoundCounterWidget> {
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
              ? colorScheme.primary.withOpacity(0.8)
              : colorScheme.primary.withOpacity(0.7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ROUNDS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 15), // Reduced

            // Counter Display
            Container(
              width: 130, // Reduced
              height: 130, // Reduced
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary,
                  width: 3,
                ),
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
                    size: 18, // Reduced
                    color: colorScheme.primary,
                  ),
                  label: Text(
                    'Reset',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 14, // Reduced
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // Reduced
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: colorScheme.primary,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                // Decrease Button
                ElevatedButton.icon(
                  onPressed: widget.onDecrease,
                  icon: Icon(
                    Icons.remove,
                    size: 18, // Reduced
                    color: colorScheme.primary,
                  ),
                  label: Text(
                    'Decrease',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 14, // Reduced
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // Reduced
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: colorScheme.primary,
                        width: 1,
                      ),
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
