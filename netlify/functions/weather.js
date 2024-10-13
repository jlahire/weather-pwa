const { execFile } = require('child_process');
const util = require('util');
const path = require('path');
const execFilePromise = util.promisify(execFile);

exports.handler = async function(event, context) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  try {
    const { zipcode, country, period } = JSON.parse(event.body);

    // input stuff and filtering
    if (!zipcode || !country || !period) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Missing required parameters' }) };
    }

    // sanitize input, this was recommended by a friend.
    const sanitizedZipcode = zipcode.replace(/[^a-zA-Z0-9]/g, '');
    const sanitizedCountry = country.replace(/[^a-zA-Z]/g, '');
    const sanitizedPeriod = parseInt(period, 10);

    if (isNaN(sanitizedPeriod) || sanitizedPeriod <= 0) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Invalid period' }) };
    }

    // .exe Python
    const pythonPath = path.join(process.env.LAMBDA_TASK_ROOT, 'python', 'bin', 'python3');
    const scriptPath = path.join(process.env.LAMBDA_TASK_ROOT, 'app.py');

    const { stdout, stderr } = await execFilePromise(pythonPath, [
      scriptPath,
      sanitizedZipcode,
      sanitizedCountry,
      sanitizedPeriod.toString()
    ]);

    if (stderr) {
      console.error(`stderr: ${stderr}`);
      return { statusCode: 500, body: JSON.stringify({ error: 'Python script error' }) };
    }

    // output stuff and filtering
    let result;
    try {
      result = JSON.parse(stdout);
      if (!result.weather_text || !result.weather_image || !result.boxplot_image) {
        throw new Error('Invalid script output');
      }
    } catch (parseError) {
      console.error('Error parsing Python output:', parseError);
      return { statusCode: 500, body: JSON.stringify({ error: 'Invalid script output' }) };
    }

    return {
      statusCode: 200,
      body: JSON.stringify(result)
    };
  } catch (error) {
    console.error('Error:', error);
    return { statusCode: 500, body: JSON.stringify({ error: 'Failed to process request' }) };
  }
};