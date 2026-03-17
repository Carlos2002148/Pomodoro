import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Líneas color azul clásico de cuaderno
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.4)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    double spacing = 36.0;

    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Este widget envolverá el contenido de tus pantallas para aplicar el fondo
class NotebookBackgroundWrapper extends StatelessWidget {
  final Widget child;

  const NotebookBackgroundWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usamos CustomPaint para dibujar las líneas DEBAJO del contenido (child)
    return CustomPaint(
      painter: NotebookPainter(),
      child: child, // Aquí va todo tu diseño de UI (tarjetas, botones, etc.)
    );
  }
}

class HandDrawnStyles {
  static BoxDecoration containerDecoration(Color bgColor) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(22),
        bottomRight: Radius.circular(12),
      ),
      border: Border.all(color: Colors.black87, width: 2.5),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(4, 4),
          blurRadius: 0, // Sombra dura para estilo papel
        )
      ],
    );
  }

  static TextStyle titleStyle = GoogleFonts.indieFlower(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static TextStyle normalStyle = GoogleFonts.caveat(
    fontSize: 24,
    color: Colors.black87,
  );
}