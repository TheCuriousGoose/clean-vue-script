#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Vue 3 project setup..."

# Step 1: Remove all assets that are not SASS
echo "Removing all non-SASS assets..."
mkdir -p src/assets/scss
find src/assets -type f ! -name '*.scss' -delete

# Step 2: Add SASS and Bootstrap
echo "Adding SASS and Bootstrap..."
npm install sass bootstrap

# Step 3: Set up basics of SASS and Bootstrap

# Create SASS files
echo "Creating SASS files..."

# Default Bootstrap SCSS variables
cat > src/assets/scss/_variables.scss <<EOL
// Bootstrap SCSS Variables
\$primary: #0d6efd;
\$secondary: #6c757d;
\$success: #198754;
\$danger: #dc3545;
\$warning: #ffc107;
\$info: #0dcaf0;
\$light: #f8f9fa;
\$dark: #212529;
\$body-bg: #fff;
\$body-color: #212529;
EOL

cat > src/assets/scss/app.scss <<EOL
@import "variables";
@import "bootstrap";

EOL

# Step 4: Update main.js to import SASS and Bootstrap
echo "Updating main.js to import SASS and Bootstrap..."
cat > src/main.js <<EOL
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import './assets/scss/app.scss';
import 'bootstrap';

createApp(App)
  .use(router)
  .mount('#app')
EOL

# Step 5: Reset App.vue to include basic RouteView and Bootstrap nav
echo "Resetting App.vue..."
cat > src/App.vue <<EOL
<script setup>
</script>

<template>
  <div id="app">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">Brand</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <router-link class="nav-link active" to="/">Home</router-link>
            </li>
            <!-- Add more nav items here -->
          </ul>
        </div>
      </div>
    </nav>
    <router-view></router-view>
  </div>
</template>
EOL

# Step 6: Remove all components
echo "Removing all components..."
rm -rf src/components

# Step 7: Reset the router/index.js to only the HomeView
echo "Resetting router/index.js..."
cat > src/router/index.js <<EOL
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
EOL

# Step 8: Remove the AboutView
echo "Removing AboutView..."
rm src/views/AboutView.vue || true

# Step 9: Reset HomeView.vue to only the script and template tags
echo "Resetting HomeView.vue..."
cat > src/views/HomeView.vue <<EOL
<script setup>

</script>


<template>
  <main></main>
</template>
EOL

echo "Vue 3 project setup complete!"
