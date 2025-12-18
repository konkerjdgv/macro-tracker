const STORAGE_KEY = 'foods';

function getFoods() {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored ? JSON.parse(stored) : [];
}

function addFood(food) {
    const foods = getFoods();
    foods.push(food);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(foods));
}

function deleteFood(id) {
    const foods = getFoods();
    const filtered = foods.filter(f => f.id !== id);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(filtered));
}

function renderFoodList(foods, containerId) {
    const list = document.getElementById(containerId);

    if (foods.length === 0) {
        list.innerHTML = '<li style="text-align: center; color: var(--text-secondary); padding: 20px;">No has agregado alimentos hoy.</li>';
        return;
    }

    // Sort by newest first
    const sortedFoods = [...foods].reverse();

    list.innerHTML = sortedFoods.map(food => `
        <li class="food-item">
            <div class="food-info">
                <h4>${food.name}</h4>
                <div class="food-macros">
                    <span class="color-cal">${food.calories} kcal</span> • 
                    <span class="color-prot">${food.protein}g P</span> • 
                    <span class="color-carb">${food.carbs}g C</span> • 
                    <span class="color-fat">${food.fats}g G</span>
                </div>
            </div>
            <button class="delete-btn" onclick="handleDelete(${food.id})" title="Eliminar">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            </button>
        </li>
    `).join('');
}
