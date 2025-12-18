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

  void _showCreateFoodDialog() {
    final nameController = TextEditingController();
    final calController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatsController = TextEditingController();
    FoodCategory dialogCategory = _selectedCategory ?? FoodCategory.others;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Crear Alimento Nuevo"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nombre")),
                TextField(controller: calController, decoration: const InputDecoration(labelText: "Calorías"), keyboardType: TextInputType.number),
                TextField(controller: proteinController, decoration: const InputDecoration(labelText: "Proteínas (g)"), keyboardType: TextInputType.number),
                TextField(controller: carbsController, decoration: const InputDecoration(labelText: "Carbos (g)"), keyboardType: TextInputType.number),
                TextField(controller: fatsController, decoration: const InputDecoration(labelText: "Grasas (g)"), keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                DropdownButton<FoodCategory>(
                  value: dialogCategory,
                  isExpanded: true,
                  items: FoodCategory.values.map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase()))).toList(),
                  onChanged: (val) => setDialogState(() => dialogCategory = val ?? dialogCategory),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCELAR")),
            ElevatedButton(
              onPressed: () async {
                final newFood = FoodItem(
                  name: nameController.text,
                  calories: int.tryParse(calController.text) ?? 0,
                  protein: int.tryParse(proteinController.text) ?? 0,
                  carbs: int.tryParse(carbsController.text) ?? 0,
                  fats: int.tryParse(fatsController.text) ?? 0,
                  category: dialogCategory,
                );
                setState(() {
                  customFoods.add(newFood);
                  _selectedCategory = dialogCategory; // Switch to the category of the new food
                });
                await StorageService.saveCustomFoods();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("GUARDAR"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get list of foods based on selected category including custom ones
    List<FoodItem> availableFoods = _selectedCategory != null
        ? getFoodsByCategory(_selectedCategory!)
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Comida"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _showCreateFoodDialog,
            tooltip: "Crear alimento personalizado",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "1. Selecciona la Categoría",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _showCreateFoodDialog, 
                  icon: const Icon(Icons.add, size: 18), 
                  label: const Text("Nuevo")
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: FoodCategory.values.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category.name.toUpperCase()),
                      selected: isSelected,
                      selectedColor: Colors.blueAccent,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                          _selectedFood = null;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            if (_selectedCategory != null) ...[
              const Text(
                "2. Selecciona el Alimento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: availableFoods.length,
                  itemBuilder: (context, index) {
                    final food = availableFoods[index];
                    final isSelected = _selectedFood == food;
                    return Card(
                      elevation: isSelected ? 4 : 1,
                      color: isSelected ? Colors.blue[50] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent.withOpacity(0.1),
                          child: const Icon(Icons.restaurant, color: Colors.blueAccent, size: 20),
                        ),
                        title: Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          "${food.calories} kcal | P: ${food.protein}g C: ${food.carbs}g G: ${food.fats}g",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedFood = food;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _selectedFood != null ? _addFood : null,
                icon: const Icon(Icons.add),
                label: const Text("AGREGAR ALIMENTO SELECCIONADO"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ] else ...[
              const Expanded(
                child: Center(
                  child: Text(
                    "Selecciona una categoría para ver los alimentos",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
