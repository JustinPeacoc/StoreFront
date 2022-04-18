/*!
* Start Bootstrap - Shop Homepage v5.0.4 (https://startbootstrap.com/template/shop-homepage)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-shop-homepage/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project

function toggleTheme() {
    let currentTheme = document.getElementById('theme');
    console.log(currentTheme.getAttribute('href'));

    if (currentTheme.getAttribute('href').includes('dark')) {
        currentTheme.setAttribute('href', '/Content/css/styles.css');

    }
    else {
        currentTheme.setAttribute('href', '/Content/css/custom-dark-theme.css');
    }
}