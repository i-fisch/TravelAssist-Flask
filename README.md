# TravelAssist
### An App to Connect Travelers with Planners and Hosts to Make Better Vacation Memories

## Project Description
TravelAssist is a data-driven app designed for multiple types of users to help people plan and host vacation trips. The three types of users are **travelers**, **planners**, and **hosts**. Some of the data we have in our app includes demographic and contact information for every user, as well as more topical information depending on the type of user. Our product has different aims depending on the user. For travelers, we want to help them figure out what to do in a location, or at least give them a starting point for planning. For planners and hosts, we want to help them find new clients and advertise their services. 

We used **Docker Desktop** to create and run the database, web, and **Appsmith** containers. These containers were built and created in a docker-compose.yml file. We used the **Python Flask** library to build blueprints for each user persona and the routes that were needed to fulfill their goals as a user. We created our database in a **MySQL** file in **DataGrip**, and populated the database with fake data from **Mockaroo**. We pulled all parts together using **VS Code** to manage the project. 

In the future, we hope to expand the usability of the app for hosts and travelers to include more options to manage vacations. Additionally, we would like to add pages for the planners user persona.

## How to Setup and Start the Containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## How to Use this Project
After installing the containers, the project can be started by typing localhost:8080 into the search bar of a browser. The app can be imported from the partner GitHub repository TravelAssistApp. From there users can view different user personas and demo their actions. We also recorded a [short video](https://drive.google.com/file/d/1vvhZ_5ySUZjJUbOkTWAd8jkttcu8jeUf/view?usp=sharing) that has an overview of our project's goals and code, and also demos the app.

## Contributions
The contributors of this project were Isabella Fisch, Lavanya Goel, and Hannah Szeto. All group members contributed equally to the conceptual development and database creation. Once the project progressed into the UI phase, Hannah focused more on the data population and debugging  any errors in the database container. Isabella created the UI pages to make sure they were functional, aesthetically pleasing, and compliant with the blueprint routes. Lavanya connected the UI pages to the API queries and ensured the routes were producing the correct output.
