import 'package:flutter/material.dart';
import '../data/foods_data.dart';
import '../data/daily_intake.dart';
import '../logic/storage.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  FoodCategory? _selectedCategory;
  FoodItem? _selectedFood;

  void _addFood() async {
    if (_selectedFood != null) {
      // Add to daily intake
      DailyIntake().addFood(_selectedFood!);
      await StorageService.saveDailyIntake();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${_selectedFood!.name} añadido!')),
        );
        Navigator.pop(context); // Return to previous screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get list of foods based on selected category
    List<FoodItem> availableFoods = _selectedCategory != null
        ? categorizedFoods[_selectedCategory] ?? []
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Comida"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "1. Selecciona el Tipo de Comida",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<FoodCategory>(
              isExpanded: true,
              value: _selectedCategory,
              hint: const Text("Selecciona una categoría"),
              items: FoodCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _selectedFood = null; // Reset selection
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedCategory != null) ...[
              const Text(
                "2. Selecciona el Alimento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<FoodItem>(
                isExpanded: true,
                value: _selectedFood,
                hint: const Text("Selecciona un alimento"),
                items: availableFoods.map((food) {
                  return DropdownMenuItem(
                    value: food,
                    child: Text(
                        "${food.name} (${food.calories} cal | P: ${food.protein}g)"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFood = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _selectedFood != null ? _addFood : null,
                icon: const Icon(Icons.add),
                label: const Text("AGREGAR ALIMENTO"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
