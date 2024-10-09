const { exec } = require('child_process');
const util = require('util');
const execPromise = util.promisify(exec);

exports.handler = async function(event, context) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  try {
    const { zipcode, country, period } = JSON.parse(event.body);
    
 
    const { stdout, stderr } = await execPromise(`python3 app.py ${zipcode} ${country} ${period}`);

    if (stderr) {
      console.error(`stderr: ${stderr}`);
      return { statusCode: 500, body: JSON.stringify({ error: stderr }) };
    }


    const result = JSON.parse(stdout);

    return {
      statusCode: 200,
      body: JSON.stringify(result)
    };
  } catch (error) {
    console.error('Error:', error);
    return { statusCode: 500, body: JSON.stringify({ error: 'Failed to process request' }) };
  }
};