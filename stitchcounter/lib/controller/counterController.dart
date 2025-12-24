import 'package:stitchcounter/models/roundCounter.dart';
import 'package:stitchcounter/models/stitchCounter.dart';

class CounterController {
  final StitchCounter stitchCounter;
  final RoundCounter roundCounter;

  CounterController()
      : stitchCounter = StitchCounter(0),
        roundCounter = RoundCounter(0);

  void incrementStitch() {
    stitchCounter.increment();
  }

  void decreaseStitch() {
    stitchCounter.decrease();
  }

  void incrementRound() {
    roundCounter.increment();
    stitchCounter.reset();
  }

  void decreaseRound() {
    roundCounter.decrease();
  }

  void resetStitch() {
    stitchCounter.reset();
  }

  void resetRound() {
    roundCounter.reset();
  }

  void resetAll() {
    resetStitch();
    resetRound();
  }
}
