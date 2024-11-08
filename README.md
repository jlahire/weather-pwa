PROJECT CLOSED 11/05/2024 @jlahire


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
updated file structure:

```
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
app.py
build.sh
netlify.toml
README.md
requirements.txt
runtime.txt
```

updated file structure again:

```
/frontend
  /css
    style.css
  /js
    app.js
  icon.png
  index.html
  manifest.json
  sw.js
/netlify
  /functions
    python.toml
    weather.js
weather.py
build.sh
netlify.toml
README.md
requirements.txt
runtime.txt
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
11. Used https://www.netlify.com/blog/2017/10/31/service-workers-explained/ to learn a little more about using service workers with netlify. It helped with some of the writing of that code. I definitely copy & pasted some of it directly to my code because it was easier than typing it out myself.
12. Link GitHub repo with Netlify and run a deploy.
13. Spend a few hours reading Netlify + Python deploy blog posts becuase of build issues.


## Challenges and Solutions

1. How do I integrate my existing python file into app.py for backend functionality.
2. Realized the Heroku is no longer free so had to switch to Netlify as my backend host. I've done a lot of projects in the past with Netlify so I knew I needed to change a ton of things in these files. I had to redo my whole backend, dropped flask, and everything that was a Heroku thing and redid a lot of the styles. Redoing app.js/index.html was difficult because I don't really know .js or .html. For most of the information to build a Netlify backend I went to Vite PWA (see resources).
3. Realizing that Netlify doesn't have great Python support. Unfortunately Netlify only supports Python 3.8...and I wrote this using Python 3.11...So I've got a few issues to figure out.
Once I had my PWA up on Netlify I attempted to fetch some weather. Here is the error I got in my Netlify log: 
```
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR  Error: Error: Command failed: python3 app.py 30350 US 7
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR  /bin/sh: python3: command not found
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at ChildProcess.exithandler (node:child_process:422:12)
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at ChildProcess.emit (node:events:517:28)
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at maybeClose (node:internal/child_process:1098:16)
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at Socket.<anonymous> (node:internal/child_process:450:11)
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at Socket.emit (node:events:517:28)
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR      at Pipe.<anonymous> (node:net:350:12) {
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    code: 127,
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    killed: false,
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    signal: null,
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    cmd: 'python3 app.py 30350 US 7',
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    stdout: '',
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR    stderr: '/bin/sh: python3: command not found\n'
Oct 12, 05:52:33 PM: 8f3cb5eb ERROR  }
```
  1. Left me pretty distraught. I had zero idea how to fix this issue because what this tells me is that python isn't found in the environment where my Netlify function is funning which did not initailly make sense to me. 
---
After doing a little research it turns out this is a common issue with Netlify.
---
So I had a few things I needed to do to resolve this issue.
  1. look up how to make netlify run python effectively so I don't have to rewrite the program in java/node.js.
  2. read this: https://docs.netlify.com/configure-builds/manage-dependencies/ 
4. So I found out I need to use nvm(Node Version Manager) to get pyenv installed and added to my $PATH so I can have Netlify use it to install python 3.8.
  1.  So I went to the nvm repo: https://github.com/nvm-sh/nvm/blob/master/README.md#install--update-script and found this .sh to install and update nvm: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash 
5. So I started building a build.sh file.
  1. Because I've worked with Linux machines for a few years I'm thankfully atleast familiar with building a .sh script to be executed. 
  2. I went to the pyenv repo to learn about it and how to call it in a script appropriately: https://github.com/pyenv/pyenv 
  3. I added lines to install python and upgrade it
  4. added my pip install -r requirements.txt here so that it is still executed.
6. Needed to restructure my files since I'm changing the build. 
  1. I moved app.py to root. 
  2. Deleted backend directory since it is now empty.
7. The most difficult part of all of this is checking/updating my files to make sure that everything will work together.
  1. weather.js: This file was probably the most difficult for me to put together and keep up with. I knew from previous projects using .js that I needed to manage error handling. This slideshow presentation: https://www.slideshare.net/slideshow/enterprise-javascript-error-handling-presentation/630870 was extremely helpful in getting an idea of how I wanted to set everything up.. I welcome input on this as I'm still very inexperienced with java anything. The most difficult part was learning the child process of running a python file and then writing the code to execute the python script. I definitely copy and pasted this part and added my sanitized strings. The error handling was difficult to figure out. I ended up finding an image on google that had error codes along with descriptions and used that for writing my error messages.
8. Well I got the netlify to deploy but still ran into the same issue. I htink that I need to recheck my build.sh.
  1. I'm glad I checked this. I ran through the build logs for my netlify and figured instaed of using pyenv to install python 3.8 I would "manually install 3.8 and run app.py with the python command not python3. I have had this work for me in some situations so maybe i'll get lucky with this fix. 
9. Nope. Still can't figure out why this wont run app.py. Here is the error i'm getting now and I'm not sure it's much different from the last one that I got. 
```
Oct 12, 10:11:21 PM: 62582187 ERROR  Error: Error: spawn /var/task/python/bin/python ENOENT
Oct 12, 10:11:21 PM: 62582187 ERROR      at ChildProcess._handle.onexit (node:internal/child_process:284:19)
Oct 12, 10:11:21 PM: 62582187 ERROR      at onErrorNT (node:internal/child_process:477:16)
Oct 12, 10:11:21 PM: 62582187 ERROR      at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
Oct 12, 10:11:21 PM: 62582187 ERROR    errno: -2,
Oct 12, 10:11:21 PM: 62582187 ERROR    code: 'ENOENT',
Oct 12, 10:11:21 PM: 62582187 ERROR    syscall: 'spawn /var/task/python/bin/python',
Oct 12, 10:11:21 PM: 62582187 ERROR    path: '/var/task/python/bin/python',
Oct 12, 10:11:21 PM: 62582187 ERROR    spawnargs: [ '/var/task/app.py', '30120', 'US', '14' ],
Oct 12, 10:11:21 PM: 62582187 ERROR    cmd: '/var/task/python/bin/python /var/task/app.py 30120 US 14',
Oct 12, 10:11:21 PM: 62582187 ERROR    stdout: '',
Oct 12, 10:11:21 PM: 62582187 ERROR    stderr: ''
Oct 12, 10:11:21 PM: 62582187 ERROR  }
```
10. So after taking a break and coming back to it I realize that my virtual environment isn't working. So I went and spent a hour reading the venv library: https://docs.python.org/3/library/venv.html and found a ton of really helpful information there. Well...hopefully.
  1. So I decided to add some venv stuff to my build.sh to see if this resolves the issue I'm running into. I got this directly from the doc above. 
```
# virtual environment stuff
echo "Creating virtual environment..."
python -m venv venv
source venv/bin/activate
```
11. So I got a different error this time:
```
9:21:23 PM: "build.command" failed                                        
9:21:23 PM: ────────────────────────────────────────────────────────────────
9:21:23 PM: ​
9:21:23 PM:   Error message
9:21:23 PM:   Command failed with exit code 1: bash build.sh (https://ntl.fyi/exit-code-1)
9:21:23 PM: ​
9:21:23 PM:   Error location
9:21:23 PM:   In build.command from netlify.toml:
9:21:23 PM:   bash build.sh
9:21:23 PM: ​
9:21:23 PM:   Resolved config
9:21:23 PM:   build:
9:21:23 PM:     command: bash build.sh
9:21:23 PM:     commandOrigin: config
9:21:23 PM:     environment:
9:21:23 PM:       - PYTHON_VERSION
9:21:23 PM:     publish: /opt/build/repo/frontend
9:21:23 PM:     publishOrigin: config
9:21:23 PM:   functionsDirectory: /opt/build/repo/netlify/functions
9:21:23 PM:   redirects:
9:21:23 PM:     - from: /api/*
      status: 200
      to: /.netlify/functions/:splat
  redirectsOrigin: config
9:21:23 PM: Build failed due to a user error: Build script returned non-zero exit code: 2
9:21:23 PM: Failing build: Failed to build site
9:21:24 PM: Finished processing build request in 2m54.817s
```
I ran the debug function with Netlify and it came back with this:
```
Diagnosis
The build failure is caused by the inability to locate Tcl/Tk libs and/or headers while trying to build the '_struct' extension in Python.

Solution
To resolve this issue, you need to install the required Tcl/Tk development libraries and headers. On Ubuntu/Debian-based systems, you can do this with the following command:

sudo apt-get install tcl-dev tk-dev
Once the necessary libraries are installed, you can retry the build process.
```
12. Soooooo I found some odd rabbit hole with Netlify that was somewhat resolved back in March of 2023: https://answers.netlify.com/t/headers-in-toml-not-applying/87328/9 
  1. But after reading more I realized that it isn't related to my issue and I wasted an hour reading...
  2. Seems like everthing related to an error with tcl and tk is all from 2012. So I looked up how to write a build process in python: https://packaging.python.org/en/latest/tutorials/packaging-projects/?form=MG0AV3 
  3. So i'm going to try adding this line to my build.sh as part of the python stuff:
```
./configure --with-tcltk-includes='-I/usr/include' --with-tcltk-libs='-L/usr/lib -ltcl8.6 -ltk8.6'
```
13. I feel like I'm getting closer. I got another build error in the same area, _struct. I went through the netlify debug again and got a compilation error in the python extensions modules. The debug suggested adding a flag to the linker command: -lgcc_s
14. So I was able to get the pwa to deploy but now i'm back to the issue with path. I'm adding some error handling to my service worker file, specifically to the fetch part because I think that's where the biggest issue is. Honestly though I'm not sure exactly where to look for the issue. Probably going to sleep on it and revisit tomorrow. Here is the current error I get from netlify when I attempt to "fetch weather":
```
Oct 13, 10:33:05 PM: d6b7fd1a ERROR  Error: Error: spawn /var/task/python/bin/python ENOENT
    at ChildProcess._handle.onexit (node:internal/child_process:284:19)
    at onErrorNT (node:internal/child_process:477:16)
    at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'spawn /var/task/python/bin/python',
  path: '/var/task/python/bin/python',
  spawnargs: [ '/var/task/app.py', '30120', 'US', '7' ],
  cmd: '/var/task/python/bin/python /var/task/app.py 30120 US 7',
  stdout: '',
  stderr: ''
}
```
15. maybe the issue is that I had my netlify.toml and runtime.txt using python 3.8 instead of python 3.8.12....
16. So I'm back at it with the same issue. This time I was able to get the correct URL for python 3.8.0. Still got the same error though, so I changed the venv path to be a local $HOME path like I had to change all the other paths to. Not sure how I forgot to change the venv path but lets see if this works...finger crossed...
  1. So this didn't work either. I decided to add some commands to give me the directory to atleast confirm it's there. And I changed up the copy everything to functions part and trimmed off the local copy to see if that sorts out the issue. That was a copy&paste that I edited anyways so I'm not sure it was necessary. Fingers crossed. 
17. Still no luck, so i've returned to netlify docs to read more about python use with netlify functions: https://docs.netlify.com/configure-builds/manage-dependencies/#python 
  1. I remember in the rabbit hole I went down previously that I though wasn't related mentioned needing to add "/*" to something for it to appropriately link or something like that. I'll revisit that discussion to see if it actually does relate.
  2. So after revisiting that article I found something to try. I realize now that I'm able to see my direcory listings and where exactly python is in my build that adding the "/*" actually might fix this issue i've been running into. Here is the line in my build.sh that i'm editing:
```
cp -r $HOME/.netlify/venv/* .netlify/functions/python/
```
18. This "/*" homefully will just copy all the venv files directly into the .netlify/functions/python/ dir. 
  1. Now i'm checking my .toml file to make sure it is using .netlify/function/python. 
    1. DUDE!!!! MAYBE THIS IS THE ISSUE!?!?!
  2. So I went to my .toml, which I haven't updated because everytime I changed something in there the build would fail. I hope that this is the issue: 
  3. old .toml function path:
  ```
  [build]
  publish = "frontend"
  functions = "netlify/functions"
  command = "bash build.sh"
  ```
  4. new .toml funciton path:
  ```
  [build]
  publish = "frontend"
  functions = "netlify/functions/python"
  command = "bash build.sh"
  ```
19. Hopefully this works.
  1. It worked but still got the path error. So now i'm going to be looking at altering my app.py to see what needs to change there.
  2. I read through: https://www.netlify.com/platform/core/functions/ to get a better understanding of netlify functions in general. 
  3. Read through this document: https://daily.dev/blog/serverless-functions-netlify-a-beginners-guide 
  4. I've heard of handler functions before. in the document above it talks about writing a function using a .js file. I'm going to look up if this is also a thing in python. https://stackoverflow.com/questions/58628653/what-are-handlers-in-python-in-plain-english 
  5. In the serverless funcitons netlify beginners guide it give the handler function as 
```
exports.handler = async (event, context) => {
return {
  statusCode: 200,
  body: JSON.stringify({
    message: "Hello World"
   })
 }
}
```
  6. But I'll have to come back to this.
  7. Ok I'm back after a few hours. So I did a little digging and found this: https://docs.python.org/3/library/logging.handlers.html and this: https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
20. After reading through those dev guides and docs I think I'm ready to start trying to write my own handler. Here is the format I'm thinking to use this schema for writing the handler function: (https://www.geeksforgeeks.org/lambda-function-handler-in-python/#)
```
import json

def lambda_handler(event, context):
    value_1 = event['key1']
    value_2 = event['key2']
    value_3 = event['key3']
    
    # Concatenating values
    result = value_1 + value_2 + value_3
    
    # demonstrating context methods and properties
    remaining_time = context.get_remaining_time_in_millis()
    fun_name = context.function_name
    fun_version = context.function_version
    memory = context.memory_limit_in_mb
    
    return {
        "StatusCode": 200,
        "Concat_value": result,
        "Remaining time": remaining_time,
        "Function Name": fun_name,
        "Function Version": fun_version,
        "Memory allocated": memory
    }
```
21. So I know that this is a lambda function, which i'm not really using, but i'm going to use this as a schema to build my own. I know I need to grab zipcode, country, and period data to send to noaa to get my data. I'm going to play with this for a while and see what I can get to work.
22. Alright! I feel kinda confident. I used some examples from stack overflow to keep it as clean as possible. I also used this: https://www.geeksforgeeks.org/10-most-common-http-status-codes/ for my status codes so I could use the right ones.



## Resources

- Stack Overflow
- GeeksforGeeks
- freeCodeCamp YouTube tutorial
- Vite PWA Plugin
- Copy and Paste CSS
- Netlify Blogs/Docs

## Next Steps

WIP

## Contribution

This is a personal learning project, but suggestions and advice are welcome!

Helpful projects I found that had some useful content: 
  https://github.com/noazark/weatherjs.com
  https://www.npmjs.com/package/weather-js
