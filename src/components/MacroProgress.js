// Macro Progress Component

const MACRO_ICONS = {
    calories: '🔥',
    protein: '🥩',
    carbs: '🍞',
    fats: '🥑'
};

function renderProgress(foods, goals, containerId) {
    const container = document.getElementById(containerId);

    // Calculate totals
    const totals = foods.reduce((acc, food) => {
        acc.calories += food.calories || 0;
        acc.protein += food.protein || 0;
        acc.carbs += food.carbs || 0;
        acc.fats += food.fats || 0;
        return acc;
    }, { calories: 0, protein: 0, carbs: 0, fats: 0 });

    // Render progress bars
    container.innerHTML = `
        ${renderMacro('Calorías', 'calories', totals.calories, goals.calories, 'kcal')}
        ${renderMacro('Proteínas', 'protein', totals.protein, goals.protein, 'g')}
        ${renderMacro('Carbohidratos', 'carbs', totals.carbs, goals.carbs, 'g')}
        ${renderMacro('Grasas', 'fats', totals.fats, goals.fats, 'g')}
    `;
}

function renderMacro(label, key, current, goal, unit) {
    const percentage = Math.min((current / goal) * 100, 100);
    const isOver = current > goal;
    const icon = MACRO_ICONS[key] || '';

    return `
        <div class="macro-card">
            <div class="macro-header">
                <span class="macro-icon">${icon}</span>
                <span class="macro-label">${label}</span>
                <span class="macro-value color-${key}">
                    ${Math.round(current)} / ${goal} ${unit}
                </span>
            </div>
            <div class="progress-bar">
                <div class="progress-fill color-${key}" style="width: ${percentage}%"></div>
            </div>
            ${isOver ? '<span class="over-label">⚠️ Meta superada</span>' : ''}
        </div>
    `;
}
