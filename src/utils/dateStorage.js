// Date Storage Utilities

/**
 * Get current date in YYYY-MM-DD format
 */
function getCurrentDate() {
    const now = new Date();
    return now.toISOString().split('T')[0];
}

/**
 * Get storage key for a specific date
 */
function getDateKey(date) {
    return `foods_${date}`;
}

/**
 * Save foods for a specific date
 */
function saveDailyData(date, foods) {
    localStorage.setItem(getDateKey(date), JSON.stringify(foods));

    // Update dates index
    const dates = getAllDates();
    if (!dates.includes(date)) {
        dates.push(date);
        dates.sort().reverse(); // Most recent first
        localStorage.setItem('foodDates', JSON.stringify(dates));
    }
}

/**
 * Get foods for a specific date
 */
function getDailyData(date) {
    const stored = localStorage.getItem(getDateKey(date));
    return stored ? JSON.parse(stored) : [];
}

/**
 * Get all dates with data
 */
function getAllDates() {
    const stored = localStorage.getItem('foodDates');
    return stored ? JSON.parse(stored) : [];
}

/**
 * Get foods for today
 */
function getTodaysFoods() {
    return getDailyData(getCurrentDate());
}

/**
 * Add food to today's data
 */
function addFoodToday(food) {
    const today = getCurrentDate();
    const foods = getDailyData(today);
    foods.push(food);
    saveDailyData(today, foods);
}

/**
 * Delete food from today's data
 */
function deleteFoodToday(id) {
    const today = getCurrentDate();
    const foods = getDailyData(today);
    const filtered = foods.filter(f => f.id !== id);
    saveDailyData(today, filtered);
}

/**
 * Reset today's data
 */
function resetToday() {
    const today = getCurrentDate();
    saveDailyData(today, []);
}

/**
 * Group dates by week
 */
function groupByWeek(dates) {
    const weeks = {};

    dates.forEach(dateStr => {
        const date = new Date(dateStr);
        const weekStart = new Date(date);
        weekStart.setDate(date.getDate() - date.getDay()); // Sunday
        const weekKey = weekStart.toISOString().split('T')[0];

        if (!weeks[weekKey]) {
            weeks[weekKey] = [];
        }
        weeks[weekKey].push(dateStr);
    });

    return weeks;
}

/**
 * Group dates by month
 */
function groupByMonth(dates) {
    const months = {};

    dates.forEach(dateStr => {
        const monthKey = dateStr.substring(0, 7); // YYYY-MM

        if (!months[monthKey]) {
            months[monthKey] = [];
        }
        months[monthKey].push(dateStr);
    });

    return months;
}

/**
 * Calculate totals for a date
 */
function calculateDailyTotals(date) {
    const foods = getDailyData(date);
    return foods.reduce((acc, food) => {
        acc.calories += food.calories || 0;
        acc.protein += food.protein || 0;
        acc.carbs += food.carbs || 0;
        acc.fats += food.fats || 0;
        return acc;
    }, { calories: 0, protein: 0, carbs: 0, fats: 0 });
}

/**
 * Calculate average for multiple dates
 */
function calculateAverage(dates) {
    if (dates.length === 0) return { calories: 0, protein: 0, carbs: 0, fats: 0 };

    const totals = dates.reduce((acc, date) => {
        const daily = calculateDailyTotals(date);
        acc.calories += daily.calories;
        acc.protein += daily.protein;
        acc.carbs += daily.carbs;
        acc.fats += daily.fats;
        return acc;
    }, { calories: 0, protein: 0, carbs: 0, fats: 0 });

    return {
        calories: Math.round(totals.calories / dates.length),
        protein: Math.round(totals.protein / dates.length),
        carbs: Math.round(totals.carbs / dates.length),
        fats: Math.round(totals.fats / dates.length)
    };
}
