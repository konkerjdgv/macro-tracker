
enum UserGoal { muscleGain, weightLoss }

class UserGoalsService {
  static UserGoal _currentGoal = UserGoal.muscleGain;

  static UserGoal get currentGoal => _currentGoal;

  static void setGoal(UserGoal goal) {
    _currentGoal = goal;
  }

  // Recommended macros based on goal (generic values for now)
  static Map<String, int> get targetMacros {
    if (_currentGoal == UserGoal.muscleGain) {
      return {
        'protein': 150, // High protein
        'carbs': 250,
        'fats': 70,
      };
    } else {
      return {
        'protein': 120,
        'carbs': 100, // Low carb
        'fats': 50,
      };
    }
  }
}
