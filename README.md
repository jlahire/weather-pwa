# LaHire Weather PWA

This project is an extension of my final project for CEIS110, figuring out the process of transforming a working Python application into a Progressive Web App (PWA) for easy mobile access. Because I dont have the time to learn how to make iOS/Android apps. Maybe down the road..

## Project Overview

For this project I'm attempting to do all of the actual coding and debugging entirely by myself. I've relied on resources like Stack Overflow and GeeksforGeeks for code structure guidance, as my experience with JS/HTML/JSON/CSS outside of guided tutorials is limited.

This README will document my progress, including the challenges and solutions along the way.

## Getting Started

This whole project came about while I was attending the live class for my CEIS110 course. The final project was discussed and during the course of the class I was able to create and complete the final project before the class ended. This isn't because it is a simple project it is because I have done many of the things involved in the project on some of my personal projects and was able to use that experience. Once that was done I decided I wanted it on my phone and remembered doing a PWA project previously and well...now you are reading this.

### Initial Setup

1. Created a basic file structure with separate frontend and backend directories.
2. Included a Procfile for Heroku deployment. (I am new to heroku, I've previously used Netlify)
3. Set up empty files in the following structure:

```
/backend
  app.py
  Procfile
  requirements.txt
/frontend
  /css
    style.css
  /js
    app.js
  index.html
  manifest.json
  sw.js
README.md
```
4. Set up Heroku
5. Realize Heroku isn't free
6. Set up Netlify
7. Mourn the loss of my sleep

Updated file structure for Netlify:

```
/backend
  app.py
  requirements.txt
/frontend
  /css
    style.css
  /js
    app.js
  index.html
  manifest.json
  sw.js
/netlify
  /functions
    weather.js
netlify.toml
README.md
```

### Development Process

1. Used Google to find templates for frontend files (index.html, manifest.json, sw.js).
  a. Becaue of the previous projects I've done creating PWA's I knew that at minimum I needed to have these files. It didn't take long to find templates to get me started. I also used https://copy-paste-css.com/ for most of the styles.
3. I integrated existing Python functions into app.py for backend functionality.
  a. I have no idea how to do this. Probably going to spend a lot of time researching this. I am actively avoiding using any AI in this process. The temptation is very real to just plug my .py into GPT and say "make this into a flask app."
5. Researched common Python libraries for PWA backends using Heroku through Stack Overflow.
6. Discovered Flask as a popular choice, aligning with my previous experience.
7. Found a helpful freeCodeCamp video tutorial on Flask PWA projects with Heroku hosting: [Flask Course - Python Web Application Development](https://youtu.be/Z1RJmh_OqeA?si=dsNZxf5VmjPw_G4g)
8. Realized I needed to use Netlify instead of Heroku so it's back to the drawing board.
9. Back to google...found https://vite-pwa-org.netlify.app/deployment/netlify.html and started reading.
10. Basically rewrote my app.py. I scoured https://www.netlify.com/blog/tags/python/ looking for something similar and while I found a few I ended up getting bits and pieces from overstock and geekforgeeks and just random google results...this is difficult.

## Challenges and Solutions

1. How do I integrate my existing python file into app.py for backend functionality.
2. Realized the Heroku is no longer free so had to switch to Netlify as my backend host. I've done a lot of projects in the past with Netlify so I knew I needed to change a ton of things in these files. I had to redo my whole backend, dropped flask, and everything that was a Heroku thing and redid a lot of the styles. Redoing app.js/index.html was difficult because I don't really know .js or .html. For most of the information to build a Netlify backend I went to Vite PWA (see resources). 

## Resources

- Stack Overflow
- GeeksforGeeks
- freeCodeCamp YouTube tutorial
- Vite PWA Plugin
- Copy and Paste CSS

## Next Steps

WIP

## Contribution

This is a personal learning project, but suggestions and advice are welcome!
