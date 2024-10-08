document.addEventListener('DOMContentLoaded', () => {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js')
            .then((reg) => console.log('Service worker registered:', reg))
            .catch((err) => console.log('Service worker registration failed:', err));
    }

    const fetchWeatherBtn = document.getElementById('fetchWeather');
    fetchWeatherBtn.addEventListener('click', fetchWeather);
});

async function fetchWeather() {
    const zipcode = document.getElementById('zipcode').value;
    const country = document.getElementById('country').value;
    const period = document.getElementById('period').value;

    try {
        const response = await fetch('https://YOUR_HEROKU_APP_URL/get_weather', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ zipcode, country, period }),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();

        // Update weather text
        document.getElementById('weatherData').value = data.weather_text;

        // Update images
        document.getElementById('weatherImage').src = data.weather_image;
        document.getElementById('boxplotImage').src = data.boxplot_image;

        // Show the weather result section
        document.getElementById('weatherResult').style.display = 'block';
    } catch (error) {
        console.error('Error fetching weather data:', error);
        alert('Failed to fetch weather data. Please try again.');
    }
}