import sys
import json
from noaa_sdk import NOAA
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
import io
import base64

def get_weather(zipcode, country, period):
    # data range stuff
    end_date = datetime.now()
    start_date = end_date - timedelta(days=int(period))
    # yay noaa 
    n = NOAA()
    observations = n.get_observations(zipcode, country, start=start_date.strftime('%Y-%m-%d'), end=end_date.strftime('%Y-%m-%d'))

    temp = []
    humidity = []
    descriptions = []

    for obs in observations:
        if obs['temperature']['value'] is not None:
            temp.append(obs['temperature']['value'])
        if obs['relativeHumidity']['value'] is not None:
            humidity.append(obs['relativeHumidity']['value'])
        descriptions.append(f"{obs['timestamp']}: {obs['textDescription']}")

    # plots
    weather_img = generate_weather_plot(temp, humidity)
    boxplot_img = generate_boxplot(temp, humidity)

    # stat
    avg_temp = sum(temp) / len(temp) if temp else None
    low_temp = min(temp) if temp else None
    high_temp = max(temp) if temp else None

    weather_text = f"Weather Statistics for {zipcode}, {country}\n"
    weather_text += f"Period: {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}\n"
    weather_text += f"Average temperature: {avg_temp:.2f}°C\n" if avg_temp is not None else "Average temperature: N/A\n"
    weather_text += f"Lowest temperature: {low_temp:.2f}°C\n" if low_temp is not None else "Lowest temperature: N/A\n"
    weather_text += f"Highest temperature: {high_temp:.2f}°C\n" if high_temp is not None else "Highest temperature: N/A\n"
    weather_text += "Recent observations:\n"
    weather_text += "\n".join(descriptions[-5:])  # Last 5 obs

    return json.dumps({
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
    # thank you overstack for this code to get base64 from png
    # geekforgeeks article talked about how this is much easier to push to frontend
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format='png')
    img_buf.seek(0)
    img_base64 = base64.b64encode(img_buf.getvalue()).decode()
    plt.close()
    
    return f"data:image/png;base64,{img_base64}"


def generate_boxplot(temp, humidity):
    # yay complicated boxplot
    plt.figure(figsize=(10, 6))
    box_data = [temp, humidity]
    plt.boxplot(box_data, tick_labels=['Temperature (°C)', 'Humidity (%)'])
    plt.title('Temperature and Humidity')
    
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format='png')
    img_buf.seek(0)
    img_base64 = base64.b64encode(img_buf.getvalue()).decode()
    plt.close()
    
    return f"data:image/png;base64,{img_base64}"

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print(json.dumps({'error': 'Invalid arguments'}))
        sys.exit(1)

    zipcode = sys.argv[1]
    country = sys.argv[2]
    period = int(sys.argv[3])

    result = get_weather(zipcode, country, period)
    print(json.dumps(result))  # <-- hopefully Netlify catches this!