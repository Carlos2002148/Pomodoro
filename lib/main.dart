import 'package:flutter/material.dart';
import 'package:pomodoro/present_screen.dart';
import 'package:provider/provider.dart';
import 'pomodoro_state.dart';
import 'setup_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PomodoroState(),
      child: const HandDrawnPomodoroApp(),
    ),
  );
}

class HandDrawnPomodoroApp extends StatelessWidget {
  const HandDrawnPomodoroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Hand-Drawn',
      debugShowCheckedModeBanner: false,
      home: PresentScreen(),
    );
  }
}