import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pomodoro_state.dart';
import 'styles.dart';
import 'setup_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PomodoroState>(context, listen: false);
    final int minutesWorked = state.totalTimeWorkedSeconds ~/ 60;

    return Scaffold(
      backgroundColor: const Color(0xFFE07A5F), // Naranja contraportada
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("¡Sesión Terminada!", style: HandDrawnStyles.titleStyle.copyWith(fontSize: 40, color: Colors.white)),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: HandDrawnStyles.containerDecoration(Colors.white),
                child: Column(
                  children: [
                    Text("Resumen", style: HandDrawnStyles.titleStyle),
                    const Divider(color: Colors.black87, thickness: 2),
                    const SizedBox(height: 16),
                    Text("Ciclos alcanzados: ${state.currentCycle} / ${state.totalCycles}", style: HandDrawnStyles.normalStyle),
                    const SizedBox(height: 8),
                    Text("Tiempo total enfocado: $minutesWorked min", style: HandDrawnStyles.normalStyle),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SetupScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  decoration: HandDrawnStyles.containerDecoration(const Color(0xFF2B5B84)), // Botón azul como la portada
                  child: Text("Nueva Sesión", style: HandDrawnStyles.titleStyle.copyWith(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}