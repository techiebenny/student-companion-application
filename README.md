# Student Companion Application
### _Prototype application made for project of Future Ready Talent Internship_ 


### Live hosted links 

In case the pages are slow / buggy please try again as the service would've gone into sleep due to inactivity.


**Student UI Web page** [was originally meant for mobile only but has been ported to web for prototyping, still fixing bugs ]

```
> https://orange-bay-073982310.1.azurestaticapps.net 
> Username : abcd@gmail.com
> Password : password
```

**College / Department pages**
```
>https://agreeable-pond-059f0e210.1.azurestaticapps.net/#/

~~~ College Login ~~~
Username : rit@gmail.com
Password : rit

~~~ Department Login ~~~
Username :  iseadmin@gmail.com
Password : password
```

**Root Admin Pages**
```
> https://proud-meadow-0f340e010.1.azurestaticapps.net/#/
> Username : root@gmail.com
> Password : root
```

# What this app does 

This application suite is a full suite program that can also be deployed to Desktop as well as Android and iOS platform that will share the same backend and database, allowing users of all platforms to make use of this app.

It allows students to login into their particular classrooms, to check up on their deadlines and reminders as well as share notes of their own as well as others all in one place without having to search back and forth in their download folders, mails and platfroms such as whatsapp which is meant for general purpose communication. 

This app also allows college authorites and parent department officials to get in touch with students by sharing only official authorized documents, leading to lesser amount of fake ciruclars being in rotation that spreads false news. 

There are other application features in line and in development such as bringing fully fledged alarm reminders, groups for students to create and participate in such as college clubs that can keep them posted on notifications of events and hackathons or just a general group for their needs like official cultural events, job postings, newletters and so on. 


**Techincal Specifications**
Languages / Frameworks Used
- Frontend : Dart with Flutter framework (Allows cross platform publishing of code to web and mobile)
- Backend : NodeJS, Express in Javascript language to create the API 
- Database : MySQL 

----

#### Industry: Ed-Tech

#### Project Title: Student Companion Application

**Problem Statement/Opportunity:**
    
    Since the rise of online classes and blended / hybrid methods of teaching, 
    students have been finding it difficult to share notes and keep track of test / assignment submission dates 
    along with sharing general information on their college happenings such as hackathons, events and so on. 
    Students need a centralized solution to keep up with the announcements from college as well,
    instead of just depending on their official website
    that will take time to update in case of any notification. 
    They also need an official channel straight from the college officials and offices, 
    without being fooled by the rise of fake circulars being shared. 
    This project aims to be a centralized solution to students, having an official channel
    without depending on the college system for timely updates.. 
    The app also allows to set deadlines and reminders for their classes

**Project Description** :

    This project aims to create a streamlined method of communication between students,
    their department officials and the main college office itself.
    It has separated login systems for each user type, allowing restricted access to posting information. 
    This allows higher authorities to post and share official authorized documents and circulars. 
    The same applies to department offices and their approved notices.
    The students can login into a section / classroom entity
    created by the department and have their homework / assignment news shared there.
    This allows all students to keep track of what is happening in their classroom.
    Even though transfer of information has become more fluent, there is an absence
    of a means of filtering the useful and important information from the huge amount of information.
    Instead of depending on whatsapp message groups which tend to get overloaded with unecessary information
    leading out to important messages being missed out. This is especially a major problem for students where each
    student is involved in multiple groups with a huge overflow of useful and non relevant information.
    This project aims to solve this problem of filtering.
    The main objective of the project is to provide a bank of information
    such as tasks to be performed by an individual, keep track of relevant information regarding
    the college, specialized section for notes, and group related content. recently, due to the pandemic,
    the shift from in campus to online classes have seriously affected the flow of information in institutions.
    Multiple groups created, leads to confusion and loss of important details regarding notes, institutional announcements, etc.


#### Primary Azure Technology:
- App Service, 
- Web Apps, 
- Azure Database for MySQL



## Features

- Students being able to be join specific classrooms that only have announcements and notes specific to them
- Get official news from college channels 
- Share notes on a department level with other sections, but pertaining only to their batch year 
- Ability to join groups for culturals, fests, events and job postings 
- Notification remainders if the app is used on iOS / Android 


## Tech

- [Flutter] - UI framework that is cross platform, works on Dart language
- [node.js] - evented I/O for the backend
- [Express] - fast node.js network app framework
- [mysql] - Database for backend 



#### Install Instructions
- Main Backend App

    Clone the repository
    Install [node.js] 
    and then the express framework by opening a terminal and typing  
```
    npm install -g express
```
    
Navigate to the main folder where the repo is cloned, locate app.js and open a terminal in that location and run in terminal 
    
```
    npm init
    node app.js
```

- Front End Service

    Clone the other branches from the repo as well, and install [flutter] 
    Build the required output files by executing in terminal in the folder containing pubsec files [navigate to the respective folder within the branches uploaded and locate the files as necessary]
    
```  
  flutter pub get
  
  flutter build web --release
```  
Use express to run the code locally after making changes to the serve location (if you want to locally host it) or open the build output files which should be index.html in the  build/web folder 


- Database 
    Download and Install [mysql] and load the database values from the dump file to have table structure ready
    Use XAMPP to run the server or use MYSQL Workbench to import tables 
    Make note of the connection string and username/password combo you create to access the database in the application 

Make sure to change the connection strings and other variables as necessary in the files to locally host the entire application independently.


[//]: # (reference links)
   [node.js]: <http://nodejs.org>
   [flutter]: <https://docs.flutter.dev/get-started/install>
   [mysql]: <https://www.mysql.com/downloads/>
   [Express]: <https://expressjs.com/>
