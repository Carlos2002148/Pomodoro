import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pomodoro_state.dart';
import 'styles.dart';
import 'timer_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  double _workMins = 25;
  double _breakMins = 5;
  double _cycles = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B5B84), // Azul de portada de cuaderno
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Configura tu Sesión",
                  style: HandDrawnStyles.titleStyle.copyWith(fontSize: 40, color: Colors.white)
              ),
              const SizedBox(height: 40),
              _buildSliderCard("Trabajo (min)", _workMins, 1, 60, (val) => setState(() => _workMins = val)),
              const SizedBox(height: 20),
              _buildSliderCard("Descanso (min)", _breakMins, 1, 10, (val) => setState(() => _breakMins = val)),
              const SizedBox(height: 20),
              _buildSliderCard("Ciclos", _cycles, 1, 10, (val) => setState(() => _cycles = val)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  final state = Provider.of<PomodoroState>(context, listen: false);
                  state.setup(_workMins.toInt(), _breakMins.toInt(), _cycles.toInt());
                  state.startTimer();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TimerScreen()));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: HandDrawnStyles.containerDecoration(const Color(0xFFE9C46A)),
                  child: Center(child: Text("¡Empezar!", style: HandDrawnStyles.titleStyle)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderCard(String title, double value, double min, double max, Function(double) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: HandDrawnStyles.containerDecoration(Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: HandDrawnStyles.normalStyle),
              Text(value.toInt().toString(), style: HandDrawnStyles.titleStyle),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF2B5B84), // Slider azul a juego
            inactiveColor: Colors.black12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}