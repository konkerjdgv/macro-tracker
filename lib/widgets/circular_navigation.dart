import 'package:flutter/material.dart';
import '../screens/add_food_screen.dart';
import '../screens/summary_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_screen.dart';

class CircularNavigation extends StatelessWidget {
  const CircularNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Círculo central
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: const Center(
              child: Text(
                "Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          // Iconos alrededor
          _buildIcon(context, Icons.bar_chart, '/summary', Alignment.topCenter),
          _buildIcon(context, Icons.settings, '/settings', Alignment.bottomCenter),
          _buildIcon(context, Icons.calendar_today, '/history', Alignment.centerLeft),
          _buildIcon(context, Icons.restaurant, '/add-food', Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, String route, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTapDown: (details) {
          final position = details.globalPosition;
          _navigateWithAnimation(context, route, position);
        },
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, String route, Offset position) {
    final size = MediaQuery.of(context).size;
    final maxRadius = (size.width + size.height);

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          // Devuelve directamente la pantalla final según la ruta
          switch (route) {
            case '/summary':
              return const SummaryScreen();
            case '/settings':
              return const SettingsScreen();
            case '/history':
              return const HistoryScreen();
            case '/add-food':
              return const AddFoodScreen();
            default:
              return const Scaffold(body: Center(child: Text("Pantalla no encontrada")));
          }
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Stack(
            children: [
              // Animación del círculo
              Positioned(
                left: position.dx - 50,
                top: position.dy - 50,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (_, __) {
                    return Container(
                      width: 100 + maxRadius * animation.value,
                      height: 100 + maxRadius * animation.value,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                    );
                  },
                ),
              ),
              FadeTransition(
                opacity: animation,
                child: child, // La pantalla final
              ),
            ],
          );
        },
      ),
    );
  }
}
