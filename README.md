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

### Development Process

1. Used Google to find templates for frontend files (index.html, manifest.json, sw.js).
     a. Becaue of the previous projects I've done creating PWA's I knew that at minimum I needed to
        have these files. It didn't take long to find templates to get me started. 
3. I integrated existing Python functions into app.py for backend functionality.
     a. I have no idea how to do this. Probably going to spend a lot of time researching this. I am
        actively avoiding using any AI in this process. The temptation is very real to just plug my
        .py into GPT and say "make this into a flask app."
5. Researched common Python libraries for PWA backends using Heroku through Stack Overflow.
6. Discovered Flask as a popular choice, aligning with my previous experience.
7. Found a helpful freeCodeCamp video tutorial on Flask PWA projects with Heroku hosting: [Flask Course - Python Web Application Development](https://youtu.be/Z1RJmh_OqeA?si=dsNZxf5VmjPw_G4g)

## Challenges and Solutions

1. How do I integrate my existing python file into app.py for backend functionality.

## Resources

- Stack Overflow
- GeeksforGeeks
- freeCodeCamp YouTube tutorial

## Next Steps

WIP

## Contribution

This is a personal learning project, but suggestions and advice are welcome!
