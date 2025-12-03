function setupForm(onSubmit) {
    const form = document.getElementById('food-form');
    const selectInput = document.getElementById('food-select');
    const datalist = document.getElementById('food-options');
    const quantityInput = document.getElementById('food-quantity');
    const unitSelect = document.getElementById('unit-select');
    const unitDisplay = document.getElementById('unit-display');
    const nameInput = document.getElementById('food-name');
    const categoryGroup = document.getElementById('category-group');
    const categorySelect = document.getElementById('food-category');

    // Macro inputs
    const calInput = document.getElementById('calories');
    const protInput = document.getElementById('protein');
    const carbInput = document.getElementById('carbs');
    const fatInput = document.getElementById('fats');

    let foodsMap = {};

    // Populate datalist with all foods
    function populateDatalist() {
        const grouped = getFoodsByCategory();
        let html = '<option value="+ Personalizado">+ Personalizado</option>';
        foodsMap = { '+ Personalizado': 'custom' };

        Object.keys(grouped).forEach(categoryKey => {
            const foods = grouped[categoryKey];
            const categoryName = FOOD_CATEGORIES[categoryKey];

            foods.forEach(food => {
                const displayName = `${food.name} (${categoryName})`;
                html += `<option value="${displayName}"></option>`;
                foodsMap[displayName] = food.id;
            });
        });

        datalist.innerHTML = html;
    }

    // Handle Selection Change
    function updateFormFromSelection() {
        const selectedText = selectInput.value.trim();
        const foodId = foodsMap[selectedText];

        if (!foodId) return;

        if (foodId === 'custom') {
            // Custom: Show category selector, empty fields
            categoryGroup.style.display = 'block';
            unitSelect.style.display = 'block';
            unitDisplay.style.display = 'none';

            quantityInput.value = '';
            unitSelect.value = 'g';
            nameInput.value = '';
            calInput.value = '';
            protInput.value = '';
            carbInput.value = '';
            fatInput.value = '';
            categorySelect.value = 'personalizado';
        } else {
            // Predefined: Hide category selector
            categoryGroup.style.display = 'none';
            const food = findFoodById(foodId);

            if (!food) return;

            unitSelect.style.display = 'none';
            unitDisplay.style.display = 'block';

            // Set unit display text
            if (food.unit === 'unidad') {
                unitDisplay.textContent = 'ud';
            } else if (food.unit === 'ml') {
                unitDisplay.textContent = 'ml';
            } else {
                unitDisplay.textContent = 'g';
            }

            unitSelect.value = food.unit;

            if (food.unit === 'unidad') {
                quantityInput.value = 1;
            } else {
                quantityInput.value = 100;
            }

            nameInput.value = food.name;
            calculateMacros(food);
        }
    }

    function calculateMacros(food) {
        if (!food) return;

        const quantity = Number(quantityInput.value) || 0;
        const ratio = quantity / food.baseAmount;

        calInput.value = Math.round(food.calories * ratio);
        protInput.value = Math.round(food.protein * ratio);
        carbInput.value = Math.round(food.carbs * ratio);
        fatInput.value = Math.round(food.fats * ratio);
    }

    // Event Listeners
    selectInput.addEventListener('change', updateFormFromSelection);
    selectInput.addEventListener('blur', updateFormFromSelection);

    quantityInput.addEventListener('input', () => {
        const selectedText = selectInput.value.trim();
        const foodId = foodsMap[selectedText];
        if (foodId && foodId !== 'custom') {
            const food = findFoodById(foodId);
            calculateMacros(food);
        }
    });

    // Initialize
    populateDatalist();

    form.addEventListener('submit', (e) => {
        e.preventDefault();

        const name = nameInput.value;
        const calories = Number(calInput.value) || 0;
        const protein = Number(protInput.value) || 0;
        const carbs = Number(carbInput.value) || 0;
        const fats = Number(fatInput.value) || 0;
        const quantity = Number(quantityInput.value) || 0;
        const unit = unitSelect.value;

        if (!name) return;

        // Check if it's a custom food being saved
        const selectedText = selectInput.value.trim();
        const foodId = foodsMap[selectedText];
        const isCustom = foodId === 'custom';

        if (isCustom) {
            // Save to custom foods database
            const customFood = {
                id: 'custom_' + Date.now(),
                name: name,
                category: categorySelect.value,
                unit: unit,
                baseAmount: unit === 'unidad' ? 1 : 100,
                calories: unit === 'unidad' ? calories : Math.round(calories / quantity * 100),
                protein: unit === 'unidad' ? protein : Math.round(protein / quantity * 100),
                carbs: unit === 'unidad' ? carbs : Math.round(carbs / quantity * 100),
                fats: unit === 'unidad' ? fats : Math.round(fats / quantity * 100)
            };

            saveCustomFood(customFood);
            populateDatalist(); // Refresh list
        }

        // Add to daily log
        const logEntry = {
            id: Date.now(),
            name: `${name} (${quantity}${unit === 'unidad' ? 'ud' : unit === 'ml' ? 'ml' : 'g'})`,
            calories,
            protein,
            carbs,
            fats,
            timestamp: new Date().toISOString()
        };

        onSubmit(logEntry);

        // Reset
        selectInput.value = '';
        nameInput.value = '';
        calInput.value = '';
        protInput.value = '';
        carbInput.value = '';
        fatInput.value = '';
        quantityInput.value = '';
        categoryGroup.style.display = 'none';
        selectInput.focus();
    });
}
