enum GoalType { loseWeight, gainMuscle, maintain }

class UserGoals {
  GoalType goalType;

  double dailyCalories;
  double dailyProtein;
  double dailyCarbs;
  double dailyFats;

  UserGoals({
    required this.goalType,
    required this.dailyCalories,
    required this.dailyProtein,
    required this.dailyCarbs,
    required this.dailyFats,
  });

  factory UserGoals.fromUserMetrics({
    required double weight,
    required double height,
    required int age,
    required String gender,
    required GoalType goalType,
  }) {
    // Metabolismo basal (Mifflin–St Jeor)
    final bmr = gender == "male"
        ? 10 * weight + 6.25 * height - 5 * age + 5
        : 10 * weight + 6.25 * height - 5 * age - 161;

    // Actividad ligera
    double maintenance = bmr * 1.3;

    double calories;
    switch (goalType) {
      case GoalType.loseWeight:
        calories = maintenance - 350;
        break;
      case GoalType.gainMuscle:
        calories = maintenance + 350;
        break;
      default:
        calories = maintenance;
    }

    return UserGoals(
      goalType: goalType,
      dailyCalories: calories,
      dailyProtein: weight * 2.0,
      dailyCarbs: (calories * 0.45) / 4,
      dailyFats: (calories * 0.25) / 9,
    );
  }
}
