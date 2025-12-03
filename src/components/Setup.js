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

// Load existing profile on page load
loadExistingProfile();
