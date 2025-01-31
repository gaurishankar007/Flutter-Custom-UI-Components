import 'dart:async';

import 'package:flutter/material.dart';

import 'text/text_widget.dart';

extension DurationExtension on Duration {
  /// Returns the duration in string format HH:MM:SS.
  String durationToHMS() {
    String hours = "$inHours";
    String minutes = "${inMinutes.remainder(60)}";
    String seconds = "${inSeconds.remainder(60)}";

    if (hours.length == 1) hours = "0$hours";
    if (minutes.length == 1) minutes = "0$minutes";
    if (seconds.length == 1) seconds = "0$seconds";

    return "$hours:$minutes:$seconds";
  }
}

class StopwatchWidget extends StatefulWidget {
  final Stopwatch stopwatch;
  const StopwatchWidget({super.key, required this.stopwatch});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  late Stopwatch stopwatch;
  late final Timer timer;
  String elapsedDuration = "";

  @override
  void initState() {
    super.initState();
    stopwatch = widget.stopwatch;
    elapsedDuration = stopwatch.elapsed.durationToHMS();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StopwatchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stopwatch != oldWidget.stopwatch) {
      stopwatch = widget.stopwatch;
      setState(
          () => elapsedDuration = widget.stopwatch.elapsed.durationToHMS());
    }
  }

  @override
  Widget build(BuildContext context) => TextWidget(elapsedDuration);

  /// Update stop watch elapsed time
  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(
        () => elapsedDuration = stopwatch.elapsed.durationToHMS(),
      ),
    );
  }

  /// Stop updating stop watch elapsed time
  stopTimer() => timer.cancel();
}
