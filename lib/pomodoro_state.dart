import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum PomodoroPhase { work, breakTime, finished }

class PomodoroState extends ChangeNotifier with WidgetsBindingObserver {
  // Configuraciones iniciales
  int workMinutes = 25;
  int breakMinutes = 5;
  int totalCycles = 4;

  // Estado actual
  int currentCycle = 1;
  int timeRemainingSeconds = 0;
  int totalTimeWorkedSeconds = 0; // Para la pantalla de resultados
  PomodoroPhase currentPhase = PomodoroPhase.work;
  Timer? _timer;
  bool isRunning = false;

  String currentQuote = "¡Preparado para enfocarte!";
  DateTime? _pausedTime;

  final List<String> workQuotes = [
    "¡Concéntrate, tú puedes!",
    "Un paso a la vez, mantén el ritmo.",
    "El esfuerzo de hoy es el éxito de mañana.",
    "Fluye con el código."
  ];

  final List<String> breakQuotes = [
    "Respira profundo, te lo has ganado.",
    "Desconecta un momento y recarga.",
    "Estira las piernas, buen trabajo.",
    "El descanso es parte del proceso."
  ];

  PomodoroState() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  // Persistencia en segundo plano
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && isRunning) {
      _pausedTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed && isRunning && _pausedTime != null) {
      final difference = DateTime.now().difference(_pausedTime!).inSeconds;
      timeRemainingSeconds -= difference;
      if (timeRemainingSeconds <= 0) {
        _handlePhaseTransition();
      }
      _pausedTime = null;
      notifyListeners();
    }
  }

  void setup(int work, int breakTime, int cycles) {
    workMinutes = work;
    breakMinutes = breakTime;
    totalCycles = cycles;
    currentCycle = 1;
    totalTimeWorkedSeconds = 0;
    currentPhase = PomodoroPhase.work;
    timeRemainingSeconds = workMinutes * 60;
    _updateQuote();
    notifyListeners();
  }

  void startTimer() {
    // 1. Seguro de vida: Evitamos crear temporizadores duplicados si ya hay uno corriendo
    if (_timer != null && _timer!.isActive) return;

    isRunning = true;

    // 2. ¡CRUCIAL! Le avisamos a la interfaz de inmediato para que el ícono cambie a "Pausa"
    notifyListeners();

    // 3. Arrancamos el ciclo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemainingSeconds > 0) {
        timeRemainingSeconds--;
        if (currentPhase == PomodoroPhase.work) totalTimeWorkedSeconds++;
        notifyListeners();
      } else {
        _handlePhaseTransition();
      }
    });
  }

  void pauseTimer() {
    isRunning = false;
    _timer?.cancel();
    // Le avisamos a la interfaz de inmediato para que el ícono vuelva a "Play"
    notifyListeners();
  }

  void _handlePhaseTransition() {
    if (currentPhase == PomodoroPhase.work) {
      if (currentCycle >= totalCycles) {
        finishSession();
      } else {
        currentPhase = PomodoroPhase.breakTime;
        timeRemainingSeconds = breakMinutes * 60;
      }
    } else {
      currentPhase = PomodoroPhase.work;
      timeRemainingSeconds = workMinutes * 60;
      currentCycle++;
    }
    _updateQuote();
    notifyListeners();
  }

  void _updateQuote() {
    final random = Random();
    currentQuote = currentPhase == PomodoroPhase.work
        ? workQuotes[random.nextInt(workQuotes.length)]
        : breakQuotes[random.nextInt(breakQuotes.length)];
  }

  void finishSession() {
    _timer?.cancel();
    isRunning = false;
    currentPhase = PomodoroPhase.finished;
    notifyListeners();
  }
}