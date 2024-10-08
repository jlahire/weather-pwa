from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
from noaa_sdk import NOAA
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
import io
import base64

app = Flask(__name__)
CORS(app)

@app.route('/get_weather', methods=['POST'])
def get_weather():
    data = request.json
    zipcode = data['zipcode']
    country = data['country']
    period = int(data['period'])

    # Calculate date range
    end_date = datetime.now()
    start_date = end_date - timedelta(days=period)

    n = NOAA()
    observations = n.get_observations(zipcode, country, 
                                      start=start_date.strftime('%Y-%m-%d'),
                                      end=end_date.strftime('%Y-%m-%d'))

    temp = []
    humidity = []
    descriptions = []

    for obs in observations:
        if obs['temperature']['value'] is not None:
            temp.append(obs['temperature']['value'])
        if obs['relativeHumidity']['value'] is not None:
            humidity.append(obs['relativeHumidity']['value'])
        descriptions.append(f"{obs['timestamp']}: {obs['textDescription']}")

    # Generate plots
    weather_img = generate_weather_plot(temp, humidity)
    boxplot_img = generate_boxplot(temp, humidity)

    # Calculate statistics
    avg_temp = sum(temp) / len(temp) if temp else None
    low_temp = min(temp) if temp else None
    high_temp = max(temp) if temp else None

    weather_text = f"Weather Statistics for {zipcode}, {country}\n"
    weather_text += f"Period: {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}\n"
    weather_text += f"Average temperature: {avg_temp:.2f}°C\n"
    weather_text += f"Lowest temperature: {low_temp:.2f}°C\n"
    weather_text += f"Highest temperature: {high_temp:.2f}°C\n\n"
    weather_text += "Recent observations:\n"
    weather_text += "\n".join(descriptions[-5:])  # Last 5 observations

    return jsonify({
        'weather_text': weather_text,
        'weather_image': weather_img,
        'boxplot_image': boxplot_img
    })

def generate_weather_plot(temp, humidity):
    plt.figure(figsize=(10, 6))
    plt.plot(temp, label="Temperature (°C)")
    plt.plot(humidity, label='Humidity (%)')
    plt.legend()
    plt.title('Temperature vs Humidity')
    
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format='png')
    img_buf.seek(0)
    img_base64 = base64.b64encode(img_buf.getvalue()).decode()
    plt.close()
    
    return f"data:image/png;base64,{img_base64}"

def generate_boxplot(temp, humidity):
    plt.figure(figsize=(10, 6))
    box_data = [temp, humidity]
    plt.boxplot(box_data, labels=['Temperature (°C)', 'Humidity (%)'])
    plt.title('Box Plot of Temperature and Humidity')
    
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format='png')
    img_buf.seek(0)
    img_base64 = base64.b64encode(img_buf.getvalue()).decode()
    plt.close()
    
    return f"data:image/png;base64,{img_base64}"

if __name__ == '__main__':
    app.run(debug=True)