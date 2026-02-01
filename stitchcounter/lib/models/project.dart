import 'package:stitchcounter/models/roundCounter.dart';
import 'package:stitchcounter/models/stitchCounter.dart';

class Project {
  String id;
  String name;
  StitchCounter stitch;
  RoundCounter round;
  
  Project({
    required this.id,
    required this.name,
    StitchCounter? stitch,
    RoundCounter? round,
  }) : stitch = stitch ?? StitchCounter(0),
        round = round ?? RoundCounter(0);
  
  void updateCounters(int stitchCount, int roundCount) {
    stitch.count = stitchCount;
    round.count = roundCount;
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stitchCount': stitch.count,
      'roundCount': round.count,
    };
  }
  
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      stitch: StitchCounter(map['stitchCount'] ?? 0),
      round: RoundCounter(map['roundCount'] ?? 0),
    );
  }
}