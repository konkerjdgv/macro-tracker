import 'package:flutter/material.dart';
import '../data/daily_intake.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current state
    final state = DailyIntake().avatarState;

    IconData icon;
    Color color;
    String message;

    switch (state) {
      case AvatarState.muscular:
        icon = Icons.fitness_center;
        color = Colors.green;
        message = "¡Estás ganando músculo!";
        break;
      case AvatarState.chubby:
        icon = Icons.fastfood;
        color = Colors.orange;
        message = "¡Cuidado con los carbos!";
        break;
      case AvatarState.normal:
      default:
        icon = Icons.sentiment_satisfied_alt;
        color = Colors.blue;
        message = "Manteniendo el equilibrio.";
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 4),
          ),
          child: Icon(
            icon,
            size: 100,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
