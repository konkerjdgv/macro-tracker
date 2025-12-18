import 'package:flutter/material.dart';
import '../widgets/avatar_widget.dart';
import '../data/daily_intake.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh state when returning to this screen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final intake = DailyIntake();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Avatar Section
              const AvatarWidget(),
              const SizedBox(height: 40),
              
              // Nutrient Summary
              _buildNutrientBar("Proteína", intake.totalProtein, intake.goalProtein, Colors.green),
              const SizedBox(height: 15),
              _buildNutrientBar("Carbohidratos", intake.totalCarbs, intake.goalCarbs, Colors.orange),
              const SizedBox(height: 15),
              _buildNutrientBar("Grasas", intake.totalFats, intake.goalFats, Colors.red),
              
              const SizedBox(height: 40),
              
              // Call to Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context, 
                    "Registrar Comida", 
                    Icons.add, 
                    Colors.blue, 
                    () async {
                      await Navigator.pushNamed(context, '/add-food');
                      setState(() {});
                    }
                  ),
                   _buildActionButton(
                    context, 
                    "Configurar Metas", 
                    Icons.settings, 
                    Colors.grey, 
                    () async {
                       await Navigator.pushNamed(context, '/settings');
                       setState(() {});
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientBar(String label, int current, int target, Color color) {
    double progress = (current / target).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("$current / $target g", style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: color.withOpacity(0.2),
          color: color,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: color,
          heroTag: label, // Unique tag
          child: Icon(icon),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
