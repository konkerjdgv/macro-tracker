import '../data/daily_intake.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = dailyIntake.dailyHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Consumo"),
        backgroundColor: Colors.blueAccent,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No hay historial registrado aún.",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final day = history[index];
                final date = DateTime.parse(day['date']);
                final formattedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(date);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildHistoryMacro("Calorías", "${day['calories']} kcal", Colors.black87),
                            _buildHistoryMacro("P", "${day['protein']}g", Colors.green),
                            _buildHistoryMacro("C", "${day['carbs']}g", Colors.orange),
                            _buildHistoryMacro("G", "${day['fats']}g", Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildHistoryMacro(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
