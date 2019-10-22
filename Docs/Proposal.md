## Project Topic: A Pedestrian Alert System using “earables”

### Team Members: Jingjie Wu, Xuchen Xue

### Abstract

In this project, we are required to build a system with Nokia’s eSense earables. This system can record audio and IMU information and use the information to recognize approaching cars alert the user if user is not aware of approaching cars. Since computation ability of eSense earables is limited, we will also design an Android application connecting eSense earables via bluetooth. The application will provide basic UI to help users manipulate eSense earables and also help us to develop different functions of eSense earables. Also, the Android mobile phone is responsible for computation mission. 

For the first requirement, we need to use the audio information to recognize the approaching cars and their direction. In our case, eSense earables has one microphone embedded in each earphone but we can only activated one microphone when we connect it to our phone. It’s really hard to recognize the direction of the car by only one microphone so we have to modify our design. For early phase, we will use two wired microphones connecting our phone (or laptop) to collect voice data of car noise. After we obtain enough number of data, we need to perform signal processing on these vocal files to capture features to distinguish the direction of car. We will place two microphones horizontally with small distance (10cm to 30cm). If car from one side (left of right), there will be a small delay between two microphones to receive the noise of the car. If we can catch this small delay, we are able to distinguish the direction of the car (left or right). One challenge for us would be the limited sample rate of microphone. The sample rate of microphone is about 44kHz and the speed of sound is approximately 340m/s. By roughly computation, there are only about 15 samples which could help us to catch this feature. Also, we need to collect a lot of vocal data of car motion then analyze the features to distinguish them from other common noise (such as people talking or foot step). By comparing signal amplitude of two microphones, we are able to find out the direction of the car (left, right, front and back).
  
For the second requirement, we will access the in-build IMU unit of eSense earables to obtain data of user’s facing direction.	

With enough number of trials, we could find out the human eye diopter (typically 188° with two eyes). Then, we compare the direction of approaching car and user facing direction to decide whether alert user about unseen approaching car.

We will testing out algorithm by comparing three different situations: user remain still and car is moving; user is moving and car remain still and both are moving.

