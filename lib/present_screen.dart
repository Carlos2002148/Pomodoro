import 'package:flutter/material.dart';
import 'styles.dart';
import 'setup_screen.dart'; // Importamos la pantalla de inicio del Pomodoro

class PresentScreen extends StatelessWidget {
  const PresentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Color hoja de papel blanco
      body: SafeArea(
        // Agregamos el fondo de líneas de cuaderno
        child: NotebookBackgroundWrapper(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // --- LOGO UNISON ESTILO BOCETO ---
                  Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    // Usamos nuestro contenedor asimétrico en lugar de un círculo perfecto
                    decoration: HandDrawnStyles.containerDecoration(Colors.white),
                    child: Image.asset(
                      'assets/logo_unison.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- TÍTULO DEL PROYECTO ---
                  Text(
                    'Pomodoro App',
                    textAlign: TextAlign.center,
                    style: HandDrawnStyles.titleStyle.copyWith(
                      fontSize: 48,
                      color: const Color(0xFF2B5B84), // Azul de bolígrafo
                    ),
                  ),

                  const SizedBox(height: 50),

                  // --- SECCIÓN DE INTEGRANTES ---
                  Text(
                    'Equipo de Desarrollo',
                    style: HandDrawnStyles.titleStyle.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 16),

                  // Contenedor de nombres estilo libreta
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: HandDrawnStyles.containerDecoration(Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Carlos Guadalupe Grijalva Castillo', style: HandDrawnStyles.normalStyle, textAlign: TextAlign.center),
                        const Divider(color: Colors.black54, thickness: 1.5, height: 24),
                        Text('Jorge Luis Ruiz Muños', style: HandDrawnStyles.normalStyle, textAlign: TextAlign.center),
                        const Divider(color: Colors.black54, thickness: 1.5, height: 24),
                        Text('Isaac Moreno Gonzalez', style: HandDrawnStyles.normalStyle, textAlign: TextAlign.center),
                        const Divider(color: Colors.black54, thickness: 1.5, height: 24),
                        Text('Carlos Rene Quijada Ruiz Lopez', style: HandDrawnStyles.normalStyle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // --- BOTÓN DE ACCIÓN ---
                  GestureDetector(
                    onTap: () {
                      // Usamos pushReplacement para que no puedan volver atrás a esta pantalla
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SetupScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: HandDrawnStyles.containerDecoration(const Color(0xFFE07A5F)), // Naranja rústico
                      child: Center(
                        child: Text(
                          '¡Abrir Cuaderno!',
                          style: HandDrawnStyles.titleStyle.copyWith(color: Colors.white, fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}