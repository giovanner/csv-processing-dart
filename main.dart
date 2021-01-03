import 'dart:ffi';
import 'dart:io';

import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Error, Use: dart main.dart <inputFile.csv>');
    exit(1);
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  final durationByTag = <String, double>{};
  lines.removeAt(0);
  for (var line in lines) {
    final values = line.split(',');
    final durationInString = values[3];
    final dirationDoubble = double.parse(durationInString.replaceAll("\"", ""));
    final tag = values[5].replaceAll("\"", "");
    final prevTotalDuration = durationByTag[tag];
    if (prevTotalDuration == null) {
      durationByTag[tag] = dirationDoubble;
    } else {
      durationByTag[tag] = prevTotalDuration + dirationDoubble;
    }
  }
  for (var entry in durationByTag.entries) {
    print('${entry.key} : ${entry.value.toStringAsFixed(1)}');
  }
}
