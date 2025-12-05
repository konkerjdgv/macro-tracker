// Setup form handler
const form = document.getElementById('setup-form');

// Load existing profile if available
function loadExistingProfile() {
    const savedProfile = localStorage.getItem('userProfile');
    if (savedProfile) {
        const profile = JSON.parse(savedProfile);

        // Pre-fill form fields
        document.getElementById('gender').value = profile.gender || '';
        document.getElementById('age').value = profile.age || '';
        document.getElementById('weight').value = profile.weight || '';
        document.getElementById('height').value = profile.height || '';
        document.getElementById('activity').value = profile.activity || '';
        document.getElementById('goal').value = profile.goal || '';

        // Change button text to "Actualizar Información"
        const submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn) {
            submitBtn.textContent = 'Actualizar Información';
        }
    }
}

form.addEventListener('submit', (e) => {
    e.preventDefault();

    const userData = {
        gender: document.getElementById('gender').value,
        age: parseInt(document.getElementById('age').value),
        weight: parseFloat(document.getElementById('weight').value),
        height: parseInt(document.getElementById('height').value),
        activityLevel: document.getElementById('activity').value,
        goal: document.getElementById('goal').value
    };

    // Calculate nutritional requirements
    const profile = calculateUserProfile(userData);

    // Save to localStorage
    localStorage.setItem('userProfile', JSON.stringify(profile));

    // Show success message
    alert('¡Datos guardados correctamente!');

    // Redirect to main page
    window.location.href = 'index.html';
});

// Test Data Generator
const generateBtn = document.getElementById('generate-data-btn');
if (generateBtn) {
    generateBtn.addEventListener('click', () => {
        if (!confirm('Esto generará datos aleatorios para los últimos 5 días. ¿Continuar?')) return;

        const foods = [
            { name: 'Pollo', cal: 165, p: 31, c: 0, f: 3.6 },
            { name: 'Arroz', cal: 130, p: 2.7, c: 28, f: 0.3 },
            { name: 'Huevo', cal: 70, p: 6, c: 0.6, f: 5 },
            { name: 'Aguacate', cal: 160, p: 2, c: 8.5, f: 15 },
            { name: 'Manzana', cal: 52, p: 0.3, c: 14, f: 0.2 }
        ];

        const today = new Date();

        for (let i = 1; i <= 5; i++) {
            const date = new Date(today);
            date.setDate(date.getDate() - i);
            const offset = date.getTimezoneOffset() * 60000;
            const dateStr = new Date(date.getTime() - offset).toISOString().split('T')[0];

            const dailyFoods = [];
            const numFoods = Math.floor(Math.random() * 3) + 3; // 3-5 foods

            for (let j = 0; j < numFoods; j++) {
                const food = foods[Math.floor(Math.random() * foods.length)];
                dailyFoods.push({
                    id: Date.now() + Math.random(),
                    name: food.name,
                    calories: food.cal,
                    protein: food.p,
                    carbs: food.c,
                    fats: food.f,
                    timestamp: new Date().toISOString()
                });
            }

            // Save using the internal function logic (replicated here since we can't import easily in this file structure without modules)
            // Note: In a real module system we would import saveDailyData. 
            // Here we assume dateStorage.js functions are global or we manually save.
            // Since Setup.js is a module? No, it's loaded via script tag.
            // So saveDailyData should be available globally if dateStorage.js is loaded before.

            if (typeof saveDailyData === 'function') {
                saveDailyData(dateStr, dailyFoods);
            }
        }

        alert('Datos de prueba generados. Revisa el Historial.');
    });
}


// Load existing profile on page load
loadExistingProfile();
