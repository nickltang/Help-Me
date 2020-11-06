# low-key

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Low-key is a mental wellness app that assists users in notifying their friends and family about their current emotional wellbeing and needs.

### App Evaluation
- **Category:** Health and Fitness
- **Mobile:** This app is designed for mobile use, as its purpose is to be an accessible health tool for the user.
- **Story:** Allows users to send selected contacts a list of emotions they’re feeling and what their needs are in times of emotional/mental distress.
- **Market:** Individuals who would like to notify their family/friends about their emotional distress.
- **Habit:** This app can be used anytime a user is feeling emotionally distressed.
- **Scope:** It will start off with a few people and their trusted circle, but the user base may grow as this app gains traction.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [ ] User can make an account.
- [ ] User can sign in.
- [ ] User can stay signed in.
- [ ] User can log out. 
- [ ] User can set a mental health status.
- [ ] User can share status with friends & family.
- [ ] User can sync contacts. 
- [ ] User can share location.  

**Optional Nice-to-have Stories**

- [ ] User’s apple watch detection suggests breathing app.
- [ ] User can connect with other users on app.
- [ ] User sees feed of feelings/statuses.

### 2. Screen Archetypes

* Login
   * User can make an account.
   * User can sign in.
* Send a new status.
   * User can set a mental health status. 
   * User can share status with friends & family. 
* Settings
   * User can sync contacts.
   * User can share location. 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Send New Status
* Settings

**Flow Navigation** (Screen to Screen)

* Login -> Send New Status
* Send New Status -> Settings

## Wireframes
![Wireframes](wireframes1.PNG)
![Wireframe GIF](low-key.gif)

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Firestore Schema
![Models](firestore-schema.PNG)

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
