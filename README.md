# Elevator API

## Introduction

Congratulatiosn!, you have been selected to develop a new API to control elevators in
buildings.

In the age of IoT everything has to be controlled via an API and our civil engineers
have developed a set of elevators that can be controlled via an API.

Also you don't need to build a UI for this, because we already selected a great UI/UX
person that is going to built that part.

Instead, you have to create a robust API that they can use to perform operations on
the backend.

You have a week for this task because we need to present this to our stake hodlers.

_Please fork this repository to your personal github and create a PR on your github for code review_


## Challenge

The elevator API it's simple we need to store elevators and buildings where the elevators are stored.

An elevator is composed by just a few fields like "model", "capacity" (the number of kilograms
it can lift).

A building is composed by only three fields "floors", "street", "city", "country".

We need to perform CRUD operations for books and authors in our API.

The API must send and receive JSON files.


## Constraints

Even though this is an MVP we have some constraints about the system that were listed as
requirements for our MVP.

First, the same model of elevator can be installed in multiple building and a building can hold one
or many elevators (because our clients sometimes have skyscrapers which require several
elevators to be installed).

The second request is a request from our stakeholders is that they want to control the elevators
from the API, but just for the API they only want to control if it goes to the ground floor or the
top of the building.

You only need to have the following restrictions:

- All elevators start from the ground floor
- If they go UP, they go all the way to the top floor
- If they go down, they go all the way to the ground floor
- It takes 3 seconds per floor

Along with the elevator information, the API must tell me if the elevator on the ground floor,
on the top floor, or traveling if the elevator hasn't reached the top or the ground floor.

The elevator cannot change directions while traveling.


## Bonus points

- If you add some business logic to the tests (i.e. elevator cannot go up if it's on the top floor)

- If you build the system inside docker containers.

- If you add tests to the application

- If you handle errors gracefully

- If you check the JSON schemas

- If only authenticated users can create, update, delete, or change directions on the elevators.
