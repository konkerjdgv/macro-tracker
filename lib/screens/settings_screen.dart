import 'package:flutter/material.dart';
import '../logic/user_goals.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selecciona tu Objetivo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RadioListTile<UserGoal>(
              title: const Text("Ganancia de Masa Muscular"),
              subtitle: const Text("Alto en proteínas y carbohidratos"),
              value: UserGoal.muscleGain,
              groupValue: UserGoalsService.currentGoal,
              onChanged: (UserGoal? value) {
                if (value != null) {
                  setState(() {
                    UserGoalsService.setGoal(value);
                  });
                }
              },
            ),
            RadioListTile<UserGoal>(
              title: const Text("Pérdida de Peso"),
              subtitle: const Text("Déficit calórico y carbohidratos controlados"),
              value: UserGoal.weightLoss,
              groupValue: UserGoalsService.currentGoal,
              onChanged: (UserGoal? value) {
                if (value != null) {
                  setState(() {
                    UserGoalsService.setGoal(value);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
