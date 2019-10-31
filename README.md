# Repository for EEM202A Fall 2019 UCLA
# Project Topic: A Pedestrian Alert System using “earables”

__Team Member:__ Xuchen Xue, Jingjie Wu

__Abstract__ 

In this project, we will develop a Pedestrian Alert System that alerting pedestrians if there are unseen cars approaching. We will use multiple microphones (at least 2) to detect the direction of the car. Also, we will track the position of head via eSense earables with in-build IMUs. Finally, we'll compare the direction of the car and the direction of pedestrians to decide if we need to alert user about approaching car. 

__Content__
  * Project Proposal (GitHub Page: https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/Proposal.md)
  * Purchase Requirement (GitHub Page: https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/PurchaseRequirement.md)
  
__Timeline__ 
  * Week 4: Read papers and discuss with professor with detail process
  * Week 5: Learn algorithm to train data and sound detection, have hardware setup.
  * Week 6: Collecting enough audio sample and train data, develop Android app with eSense earables.
  * Week 7: Finish car noise detection and start to develop car direction detection
  * Week 8: Keep developing car direction detection and finish Android app development with eSense earables.
  * Week 9: Finish car direction detection and start to integrate everything on Android app
  * Week 10: Finish developing Pedestrian Alert System and record demo video.

__Literature Review__

  Nowadays, smartphones provide us with many conveniences that a normal computer or laptop gives us. It is common to see people listen to music, watch TV series and go on social media anywhere and anytime. As the pedestrians are more involved in their phones, the problems of their safety arise since they are more likely to ignore the auditory and visual information around them [1]. The number of injuries and deaths from incidents caused by smartphones usage has greatly increased in recent years [2].
  In order to improve the pedestrians’ safety, several works on detecting and localizing the approaching vehicles based on sound information have been presented. Kodera proposed a direction estimation method based on a microphone array that uses the cross correlation method and cubic spline interpolation [3]. However, it can work when there is only one approaching vehicle. Lee presented an audio-based early warning system of vehicle approaching event where multiple feature techniques were applied to short-time frames of audio samples and multiple machine learning classifiers were applied to classify the audio frames to effectively detect vehicle approaching sound [4]. Xia presented a smartphone platform that utilizes an embedded wearable headset system with an array of MEMS microphones to help detect, localize and warn pedestrians of approaching cars [5]. First, the NBIP feature is extracted from audio samples and a Random Forest classifier is applied to detect cars. Once a car is detected, the localization module is activated. The direction as the angle of arrival is computed through the delay of arrival between microphones while the distance is obtained by regression model which takes the signal energy features. Nevertheless, there is no experimental results or accuracy.
  Our goal is to utilize several microphones as fewer as possible to detect the approaching vehicle and compute its direction, distance as well as velocity. Then the system will alert the user when the facial direction obtained by IMU on esense is not covering the direction of vehicle.

__Success Metrics__

  * When a car is approaching pedestrian,  Pedestrian Alert System is able to recognize car noise from all other noise.
  * After detect the noise of car, determine the direction of approaching car with multiple  microphones.
  * Design an Android app that can determine the position of hard with eSense earables in-build IMU
  * Alert user if approaching car is out of the user's vision

__Reference__

[1] K. Shaver. Safety experts to pedestrians: Put the smartphones down and pay attention,          September 2014. [Online]
[2] Lichenstein, Richard, et al. "Headphone use and pedestrian injury and death in the United        States: 2004–2011." Injury prevention 18.5 (2012): 287-290.
[3] Kodera, Kenji, Akitoshi Itai, and Hiroshi Yasukawa. "Sound localization of approaching vehicles using uniform microphone array." 2007 IEEE Intelligent Transportation Systems Conference. IEEE, 2007.
[4] Lee, Chih-Jung, Yu-Hao Tseng, and Pao-Chi Chang. Audio-based early warning system of vehicle approaching event for improving pedestrian's safety. 2018 IEEE 8th International Conference on Consumer Electronics-Berlin (ICCE-Berlin). IEEE, 2018.
[5] Xia, Stephen, et al. A Smartphone-Based System for Improving Pedestrian Safety. 2018 IEEE Vehicular Networking Conference (VNC). IEEE, 2018.
