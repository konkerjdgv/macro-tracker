// Nutritional Calculator Utilities

/**
 * Calculate Basal Metabolic Rate using Mifflin-St Jeor equation
 * @param {string} gender - 'male' or 'female'
 * @param {number} weight - Weight in kg
 * @param {number} height - Height in cm
 * @param {number} age - Age in years
 * @returns {number} BMR in kcal/day
 */
function calculateBMR(gender, weight, height, age) {
    const base = (10 * weight) + (6.25 * height) - (5 * age);
    return gender === 'male' ? base + 5 : base - 161;
}

/**
 * Calculate Total Daily Energy Expenditure
 * @param {number} bmr - Basal Metabolic Rate
 * @param {string} activityLevel - Activity level key
 * @returns {number} TDEE in kcal/day
 */
function calculateTDEE(bmr, activityLevel) {
    const activityFactors = {
        'sedentary': 1.2,        // Little or no exercise
        'light': 1.375,          // Light exercise 1-3 days/week
        'moderate': 1.55,        // Moderate exercise 3-5 days/week
        'intense': 1.725,        // Hard exercise 6-7 days/week
        'very_intense': 1.9      // Very hard exercise, physical job
    };

    return Math.round(bmr * (activityFactors[activityLevel] || 1.2));
}

/**
 * Adjust calories based on goal
 * @param {number} tdee - Total Daily Energy Expenditure
 * @param {string} goal - 'loss', 'maintenance', or 'gain'
 * @returns {number} Adjusted calories
 */
function adjustForGoal(tdee, goal) {
    const adjustments = {
        'loss': -500,        // Deficit for weight loss
        'maintenance': 0,    // Maintain current weight
        'gain': 300          // Surplus for muscle gain
    };

    return Math.round(tdee + (adjustments[goal] || 0));
}

/**
 * Calculate macro distribution
 * @param {number} calories - Target daily calories
 * @param {number} weight - Weight in kg
 * @param {string} goal - 'loss', 'maintenance', or 'gain'
 * @returns {object} Macros in grams {protein, carbs, fats}
 */
function calculateMacros(calories, weight, goal) {
    // Protein: 1.6-2.2g per kg (higher for loss/gain)
    const proteinPerKg = goal === 'maintenance' ? 1.6 : 2.0;
    const protein = Math.round(weight * proteinPerKg);
    const proteinCalories = protein * 4;

    // Fats: 25-30% of total calories
    const fatPercentage = 0.27;
    const fatCalories = Math.round(calories * fatPercentage);
    const fats = Math.round(fatCalories / 9);

    // Carbs: Remaining calories
    const carbCalories = calories - proteinCalories - fatCalories;
    const carbs = Math.round(carbCalories / 4);

    return {
        calories,
        protein,
        carbs,
        fats
    };
}

/**
 * Calculate complete user profile
 * @param {object} userData - User input data
 * @returns {object} Complete nutritional profile
 */
function calculateUserProfile(userData) {
    const { gender, weight, height, age, activityLevel, goal } = userData;

    const bmr = calculateBMR(gender, weight, height, age);
    const tdee = calculateTDEE(bmr, activityLevel);
    const targetCalories = adjustForGoal(tdee, goal);
    const macros = calculateMacros(targetCalories, weight, goal);

    return {
        // Original user data
        gender,
        age,
        weight,
        height,
        activity: activityLevel,
        goal,

        // Calculated values
        bmr: Math.round(bmr),
        tdee,
        calories: targetCalories,
        protein: macros.protein,
        carbs: macros.carbs,
        fats: macros.fats
    };
}
