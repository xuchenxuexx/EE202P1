# Repository for EEM202A Fall 2019 UCLA
# Project Topic: A Pedestrian Alert System using “earables”

__Team Member:__ Xuchen Xue

## Abstract ##

    With the development of technology and mobile phone functionality, more and more pedestrians and joggers tend to play with their phones or listen to music while they are walking or jogging. On the other hand, if we could make use of sensor and data processing ability of mobile phones, we could also design a system to alert the user for unseen dangers. In this article, we present a pedestrian alert system with eSense earables and wired microphones to detect the direction of an approaching car and warn the user of the danger. Also, we propose some possibilities in this system that could be discovered in the future. 
    
## Content ##

  * Project Proposal (GitHub Page: https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/Proposal.md)
  * eSense IMU app could be found under /eSense_IMU_app/ folder
  * Document could be found under /Docs/ folder
  * 

## Introduction ## 

    Technology provides us with many conveniences nowadays. Compared with computers and laptops,  smartphones have strong advantages on its portability. You can bring your smartphone anywhere with you and listen to music, browse websites or go on social media. People are playing with their phones all the time and engaged with their phones while walking. This behavior is very dangerous since there could be unseen approaching cars which may hurt pedestrians. From a study by Injury Prevention, it shows that the number of serious injuries and deaths of pedestrians who has headsets on their head while walking has increased by three times in the last few years in the United States. Thus, the safety of the pedestrian becomes a serious problem and it provides us a motivation to solve it. Our goal is to develop an alert system with mobile phone and eSense earables to send pedestrians alert of unseen approaching cars.
    In this article, we use two phones with wired microphones to record audio information into two channels and analyze them as a synchronized stereo signal offline. The reason will be explained in the hardware setup section. We used a tone generator to generate a 1kHz tone for synchronization purposes. We choose an Audi A4 as our car model and the test case is in a garage. Then we extract the the feature called NBIP from each audio file in order to train our classification machine learning model. Finally, we do some experiments to evaluate its performance and robustness, which seems to be reasonable.

## Hardware Setup ##

_A. Phase One: Nokia eSense earables/Y cable & wired microphones_
    First step of alert system is to create a system which could collect audio information and process it in real-time. It has to split input audio information into two different channels with two microphone so that we could compare the delay between two microphones to determine the direction of the cars. Our original idea is using Nokia eSense earables shown in fig.1 to collect audio information and pass it to an Android phone to process it. We soon realize that Nokia eSense can’t complete this mission because the mechanism eSense earables use to talk with mobile phone. When eSense earables connect to mobile phone, one earable become “main” earable to talk to mobile phone and the other earable talk to the “main” earable to achieve synchronization. During this process, only one microphone will be activated, Thus, we can’t collect stereo audio information with this limitation. Due to bluetooth protocol, we can’t connect two different eSense earables pairs to the same mobile phone. For all the reasons above, we abandon this idea and move to the next step.
_B. Phase two: Using two phones to record audio files and analyze it offline_
    After phase one, we modified our goal and decide to use two mobile phones to record audio files and analyze the audio file offline. The setup is shown in fig.3. The advantage is that we could avoid the feature that single mobile phone doesn’t have the ability to split input signal. The disadvantage is that we can’t process the signal in real-time right now since for real-time, we need to collect stereo audio signals on the same phone. Another disadvantage would be the synchronization requirement. We need to perform really synchronization while collecting audio samples since the distance between two microphones is about one meter and the delay between signals is only a few milliseconds. The way we perform synchronization is that we use a tone generator to generate a 1 kHz tone while collecting stereo audio signals and we used this tone as a mark in audio samples. When we analyze the audio files, we cut the whole audio sample into a number of time frames and perform FFT to each time frame. We set a threshold at 1 kHz and once we find the frame which has high energy above the threshold at 1 kHz, we mark that frame and see it as the first time frame of whole sample. The detail of synchronization will be explained in implementation section. 

## Algorithm and Implementation ##




__Reference__

[1] K. Shaver. Safety experts to pedestrians: Put the smartphones down and pay attention,          September 2014. [Online]
[2] Lichenstein, Richard, et al. "Headphone use and pedestrian injury and death in the United        States: 2004–2011." Injury prevention 18.5 (2012): 287-290.
[3] Kodera, Kenji, Akitoshi Itai, and Hiroshi Yasukawa. "Sound localization of approaching vehicles using uniform microphone array." 2007 IEEE Intelligent Transportation Systems Conference. IEEE, 2007.
[4] Lee, Chih-Jung, Yu-Hao Tseng, and Pao-Chi Chang. Audio-based early warning system of vehicle approaching event for improving pedestrian's safety. 2018 IEEE 8th International Conference on Consumer Electronics-Berlin (ICCE-Berlin). IEEE, 2018.
[5] Xia, Stephen, et al. A Smartphone-Based System for Improving Pedestrian Safety. 2018 IEEE Vehicular Networking Conference (VNC). IEEE, 2018.
