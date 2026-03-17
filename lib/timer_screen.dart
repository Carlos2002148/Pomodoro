import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'pomodoro_state.dart';
import 'styles.dart';
import 'results_screen.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroState>(
      builder: (context, state, child) {
        // El color activo se usará para el círculo y los botones, no para el fondo
        Color activeColor = state.currentPhase == PomodoroPhase.work
            ? const Color(0xFFE07A5F) // Naranja rústico
            : const Color(0xFF2A9D8F); // Verde/Azul para descanso

        if (state.currentPhase == PomodoroPhase.finished) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultsScreen()));
          });
        }

        int totalSeconds = state.currentPhase == PomodoroPhase.work
            ? state.workMinutes * 60
            : state.breakMinutes * 60;
        double progress = totalSeconds == 0 ? 0 : 1 - (state.timeRemainingSeconds / totalSeconds);

        String minutesStr = (state.timeRemainingSeconds ~/ 60).toString().padLeft(2, '0');
        String secondsStr = (state.timeRemainingSeconds % 60).toString().padLeft(2, '0');

        return Scaffold(
          backgroundColor: const Color(0xFFFDFBF7), // Color hoja de papel blanco
          body: SafeArea(
            child: NotebookBackgroundWrapper(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.currentPhase == PomodoroPhase.work ? "Tiempo de Trabajo" : "Tiempo de Descanso",
                      style: HandDrawnStyles.titleStyle.copyWith(color: activeColor), // Título cambia de color
                    ),
                    Text(
                      "Ciclo ${state.currentCycle} / ${state.totalCycles}",
                      style: HandDrawnStyles.normalStyle.copyWith(color: Colors.black87), // Texto oscuro
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: progress),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            builder: (context, value, _) {
                              return CircularProgressIndicator(
                                value: value,
                                strokeWidth: 12,
                                backgroundColor: Colors.black12,
                                valueColor: AlwaysStoppedAnimation<Color>(activeColor), // Círculo animado con color
                              );
                            },
                          ),
                        ),
                        Text(
                          "$minutesStr:$secondsStr",
                          style: HandDrawnStyles.titleStyle.copyWith(fontSize: 60, color: Colors.black87), // Reloj oscuro
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: HandDrawnStyles.containerDecoration(Colors.white),
                      child: Text(
                        state.currentQuote,
                        textAlign: TextAlign.center,
                        style: HandDrawnStyles.normalStyle,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          iconSize: 48,
                          color: activeColor, // Botones cambian de color
                          icon: Icon(state.isRunning ? PhosphorIcons.pause() : PhosphorIcons.play()),
                          onPressed: () {
                            state.isRunning ? state.pauseTimer() : state.startTimer();
                          },
                        ),
                        IconButton(
                          iconSize: 48,
                          color: activeColor,
                          icon: Icon(PhosphorIcons.stop()),
                          onPressed: () => state.finishSession(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}