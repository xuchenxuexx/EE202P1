## Project Topic: A Pedestrian Alert System using “earables”

### Team Members: Jingjie Wu, Xuchen Xue

### Abstract

In this project, we are required to build a system with Nokia’s eSense earables. This system can record audio and IMU information and use the information to recognize approaching cars alert the user if user is not aware of approaching cars. Since computation ability of eSense earables is limited, we will also design an Android application connecting eSense earables via bluetooth. The application will provide basic UI to help users manipulate eSense earables and also help us to develop different functions of eSense earables. Also, the Android mobile phone is responsible for computation mission. 

For the first requirement, we need to use the audio information to recognize the approaching cars and their direction. We first need to develop an algorithm that could recognize the noise of car motion. We need to collect a lot of vocal data of car motion then analyze the features to distinguish them from other common noise (such as people talking or foot step). By comparing signal amplitude of two microphones, we are able to find out the direction of the car (left, right, front and back).
  
For the second requirement, we will access the in-build IMU unit of eSense earables to obtain data of user’s facing direction.	
With enough number of trials, we could find out the human eye diopter (typically 188° with two eyes). Then, we compare the direction of approaching car and user facing direction to decide whether alert user about unseen approaching car.

