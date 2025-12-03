const CACHE_NAME = 'macro-tracker-v1';
const urlsToCache = [
    '/',
    '/index.html',
    '/history.html',
    '/setup.html',
    '/about.html',
    '/style.css',
    '/nav.css',
    '/toggle.css',
    '/main.js',
    '/src/data/foods.js',
    '/src/components/FoodInput.js',
    '/src/components/FoodList.js',
    '/src/components/MacroProgress.js',
    '/src/components/Setup.js',
    '/src/utils/calculator.js',
    '/src/utils/dateStorage.js'
];

self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(urlsToCache))
    );
});

self.addEventListener('fetch', event => {
    event.respondWith(
        caches.match(event.request)
            .then(response => response || fetch(event.request))
    );
});
