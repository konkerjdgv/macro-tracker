// Imports removed for file:// compatibility


// Load goals from user profile or use defaults
const PROFILE_KEY = 'userProfile';
let GOALS = {
    calories: 2000,
    protein: 150,
    carbs: 200,
    fats: 70
};

// Check if user has a profile
const savedProfile = localStorage.getItem(PROFILE_KEY);
if (savedProfile) {
    const profile = JSON.parse(savedProfile);
    GOALS = {
        calories: profile.calories,
        protein: profile.protein,
        carbs: profile.carbs,
        fats: profile.fats
    };
}

function init() {
    // Initial render
    updateUI();

    // Delete handler
    window.handleDelete = (id) => {
        deleteFoodToday(id);
        updateUI();
    };

    // Reset button
    document.getElementById('reset-btn').addEventListener('click', () => {
        if (confirm('¿Estás seguro de que quieres reiniciar el día?')) {
            resetToday();
            updateUI();
        }
    });

    // Menu toggle for mobile
    const menuToggle = document.getElementById('menu-toggle');
    const mainNav = document.getElementById('main-nav');

    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            mainNav.classList.toggle('active');
        });

        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!menuToggle.contains(e.target) && !mainNav.contains(e.target)) {
                mainNav.classList.remove('active');
            }
        });
    }

    // Edit profile button
    document.getElementById('edit-profile-btn').addEventListener('click', () => {
        window.location.href = 'setup.html';
    });

    // Toggle history visibility
    const toggleBtn = document.getElementById('toggle-history');
    const foodList = document.getElementById('food-list');
    let isHistoryVisible = true;

    toggleBtn.addEventListener('click', () => {
        isHistoryVisible = !isHistoryVisible;

        if (isHistoryVisible) {
            foodList.style.display = 'flex';
            toggleBtn.classList.remove('collapsed');
        } else {
            foodList.style.display = 'none';
            toggleBtn.classList.add('collapsed');
        }
    });

    // Setup form
    setupForm((newFood) => {
        addFoodToday(newFood);
        updateUI();
    });
}

function updateUI() {
    const foods = getTodaysFoods();
    renderFoodList(foods, 'food-list');
    renderProgress(foods, GOALS, 'progress-section');
}

init();
