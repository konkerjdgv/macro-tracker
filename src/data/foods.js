// Food Database with Categories
const FOOD_CATEGORIES = {
    'carnes': 'Carnes y Aves',
    'pescados': 'Pescados y Mariscos',
    'lacteos': 'Lácteos y Sustitutos',
    'frutas': 'Frutas',
    'granos': 'Granos y Cereales',
    'verduras': 'Verduras',
    'bebidas': 'Bebidas',
    'personalizado': 'Personalizados'
};

const FOOD_DATABASE = [
    // Carnes y Aves
    {
        id: 'chicken_breast',
        name: 'Pechuga de Pollo (Parrilla)',
        category: 'carnes',
        unit: 'g',
        baseAmount: 100,
        calories: 165,
        protein: 31,
        carbs: 0,
        fats: 3.6
    },

    // Huevos (Lácteos)
    {
        id: 'egg_jumbo',
        name: 'Huevo Jumbo (>70g)',
        category: 'lacteos',
        unit: 'unidad',
        baseAmount: 1,
        calories: 85,
        protein: 6.5,
        carbs: 0.5,
        fats: 6.5
    },
    {
        id: 'egg_aa',
        name: 'Huevo AA (60g)',
        category: 'lacteos',
        unit: 'unidad',
        baseAmount: 1,
        calories: 85,
        protein: 7,
        carbs: 0.5,
        fats: 6.5
    },
    {
        id: 'egg_a',
        name: 'Huevo A (55g)',
        category: 'lacteos',
        unit: 'unidad',
        baseAmount: 1,
        calories: 65,
        protein: 5.5,
        carbs: 0.5,
        fats: 4.5
    },

    // Lácteos
    {
        id: 'milk_lactose_free',
        name: 'Leche Deslactosada Semidescremada',
        category: 'lacteos',
        unit: 'ml',
        baseAmount: 100,
        calories: 52,
        protein: 3.3,
        carbs: 5.0,
        fats: 2.1
    },

    // Carnes
    {
        id: 'pork_loin',
        name: 'Lomo de Cerdo (Cocido)',
        category: 'carnes',
        unit: 'g',
        baseAmount: 100,
        calories: 145,
        protein: 28,
        carbs: 0,
        fats: 4.5
    },
    {
        id: 'beef_sirloin',
        name: 'Bistec de Solomillo/Lomo',
        category: 'carnes',
        unit: 'g',
        baseAmount: 100,
        calories: 160,
        protein: 29,
        carbs: 0,
        fats: 5
    },

    // Bebidas
    {
        id: 'black_coffee',
        name: 'Café Negro (sin azúcar)',
        category: 'bebidas',
        unit: 'ml',
        baseAmount: 100,
        calories: 1,
        protein: 0.1,
        carbs: 0,
        fats: 0
    }
];

// Get foods grouped by category
function getFoodsByCategory() {
    const grouped = {};

    // Initialize all categories
    Object.keys(FOOD_CATEGORIES).forEach(key => {
        if (key !== 'personalizado') {
            grouped[key] = [];
        }
    });

    // Group predefined foods
    FOOD_DATABASE.forEach(food => {
        if (grouped[food.category]) {
            grouped[food.category].push(food);
        }
    });

    // Add custom foods from localStorage
    const customFoods = getCustomFoods();
    if (customFoods.length > 0) {
        grouped['personalizado'] = customFoods;
    }

    return grouped;
}

// Get custom foods from localStorage
function getCustomFoods() {
    const stored = localStorage.getItem('customFoods');
    return stored ? JSON.parse(stored) : [];
}

// Save custom food
function saveCustomFood(foodData) {
    const customFoods = getCustomFoods();
    customFoods.push(foodData);
    localStorage.setItem('customFoods', JSON.stringify(customFoods));
}

// Get all foods (predefined + custom)
function getAllFoods() {
    return [...FOOD_DATABASE, ...getCustomFoods()];
}

// Find food by ID
function findFoodById(id) {
    return getAllFoods().find(f => f.id === id);
}
