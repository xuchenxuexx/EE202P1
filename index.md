# Repository for EEM202A Fall 2019 UCLA
# Project Topic: A Pedestrian Alert System using “earables”

__Team Member:__ Xuchen Xue

## Abstract ##

With the development of technology and mobile phone functionality, more and more pedestrians and joggers tend to play with their phones or listen to music while they are walking or jogging. On the other hand, if we could make use of sensor and data processing ability of mobile phones, we could also design a system to alert the user for unseen dangers. In this article, we present a pedestrian alert system with eSense earables and wired microphones to detect the direction of an approaching car and warn the user of the danger. Also, we propose some possibilities in this system that could be discovered in the future. 
    
## Content ##

  * eSense IMU app could be found under /eSense_IMU_app/ folder
  * Document could be found under /Docs/ folder

## Introduction ## 

Technology provides us with many conveniences nowadays. Compared with computers and laptops,  smartphones have strong advantages on its portability. You can bring your smartphone anywhere with you and listen to music, browse websites or go on social media. People are playing with their phones all the time and engaged with their phones while walking. This behavior is very dangerous since there could be unseen approaching cars which may hurt pedestrians. From a study by Injury Prevention, it shows that the number of serious injuries and deaths of pedestrians who has headsets on their head while walking has increased by three times in the last few years in the United States. Thus, the safety of the pedestrian becomes a serious problem and it provides us a motivation to solve it. Our goal is to develop an alert system with mobile phone and eSense earables to send pedestrians alert of unseen approaching cars.

In this article, we use two phones with wired microphones to record audio information into two channels and analyze them as a synchronized stereo signal offline. The reason will be explained in the hardware setup section. We used a tone generator to generate a 1kHz tone for synchronization purposes. We choose an Audi A4 as our car model and the test case is in a garage. Then we extract the the feature called NBIP from each audio file in order to train our classification machine learning model. Finally, we do some experiments to evaluate its performance and robustness, which seems to be reasonable.

## Hardware Setup ##

_A. Phase One: Nokia eSense earables/Y cable & wired microphones_

First step of alert system is to create a system which could collect audio information and process it in real-time. It has to split input audio information into two different channels with two microphone so that we could compare the delay between two microphones to determine the direction of the cars. Our original idea is using Nokia eSense earables shown in fig.1 to collect audio information and pass it to an Android phone to process it. We soon realize that Nokia eSense can’t complete this mission because the mechanism eSense earables use to talk with mobile phone. When eSense earables connect to mobile phone, one earable become “main” earable to talk to mobile phone and the other earable talk to the “main” earable to achieve synchronization. During this process, only one microphone will be activated, Thus, we can’t collect stereo audio information with this limitation. Due to bluetooth protocol, we can’t connect two different eSense earables pairs to the same mobile phone. For all the reasons above, we abandon this idea and move to the next step.

![img1](https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/1.png)

Fig.1 Nokia eSense Earables


After the failure of eSense earables, we choose to connect two wired microphones to one Android phone via Hosa YMM-261 3.5 mm TRS to Dual 3.5 mm TSF Stereo Breakout Cable shown in fig.2. We use this combo to collect audio samples in Weyburn Terrace Cypress Court Parking Garage and use a car model of Audi A4. After we collect certain numbers of sample and test these samples on MATLAB, and confirm that this Y cable can record audio input into stereo form. While, after we display the signal of two channels, we found that the waveform of two channels are almost the same. We run a for loop to compare the value of two channels and they are exactly the same. After a few experiments, we conclude a couple of things. One is that a Y cable can split audio output in a perfect way but it can’t split audio input. It will add the signal collected from two microphones together and average it into each channel and that’s why we have the same signal in both channels. Another thing is that a single mobile doesn’t have the ability to split audio input information into two channels and you need a digital recorder which has multiple input port to achieve this. After understanding these properties, we modify our goal and switch to the next phase.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/2.png" width = "500">

Fig.2 Y cable and two wired microphones


_B. Phase two: Using two phones to record audio files and analyze it offline_

After phase one, we modified our goal and decide to use two mobile phones to record audio files and analyze the audio file offline. The setup is shown in fig.3. The advantage is that we could avoid the feature that single mobile phone doesn’t have the ability to split input signal. The disadvantage is that we can’t process the signal in real-time right now since for real-time, we need to collect stereo audio signals on the same phone. Another disadvantage would be the synchronization requirement. We need to perform really synchronization while collecting audio samples since the distance between two microphones is about one meter and the delay between signals is only a few milliseconds. The way we perform synchronization is that we use a tone generator to generate a 1 kHz tone while collecting stereo audio signals and we used this tone as a mark in audio samples. When we analyze the audio files, we cut the whole audio sample into a number of time frames and perform FFT to each time frame. We set a threshold at 1 kHz and once we find the frame which has high energy above the threshold at 1 kHz, we mark that frame and see it as the first time frame of whole sample. The detail of synchronization will be explained in implementation section. 

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/3.png" width = "500">

Fig.3 Phase two setup

## Algorithm and Implementation ##

_Signal Processing and Feature Extraction_

In order to design a machine learning model, we have to first extract distinguishable features from each audio. First, we divide each audio into 100ms frames with a 2ms slide. The reason why we choose such window length and slide is that we want to include more information in one frame while we also want to tell the tiny delay between the left and right channels. Then, according to [1], we also use the audio feature called the Non-Uniform Binned Integral Periodogram (NBIP), that unequally divides the frequency scale in order to capture variation in spectral energy at the lower end of the frequency spectrum which characterizes the car noises. The steps to compute the NBIP features are as follows.
Step 1: The FFT of each audio frame x(t) is computed to obtain the Fourier spectra X(f). Only the left half of this symmetric spectra is retained.
Step 2: The periodogram of x(t) is obtained from X(f) by normalizing its magnitude squared, and then taking its logarithm.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/4.png" width = "250">

Fs and N denote the sampling frequency and the signal length, respectively.

Step 3: The frequency range is divided into a total of B bins, such that the frequencies below a threshold are equally divided into b bins. The binning process is illustrated in Fig.4.  The optimal values of the parameters B, a and b are empirically determined, which we will describe shortly.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/5.png" width = "300">

Fig.4 Illustration of NBIP binning process

Step 4: The spectra are integrated in each bin to obtain a B dimension feature vector v.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/6.png" width = "300">

Here we use B = 20, a = 0.3 and b = 18 which is the same as [1].

_Model Training_

Here we parallelly use two machine learning models to perform the classification and then compare their performance and robustness. Besides, since the audio we record are mostly car noise which serves as the positive samples in the training data, we here use the one-class classification models. The advantage of this approach is that it requires fewer samples and it is more robust since the training data are all positive.
The first model we use is one-class SVM. The main idea of this model is to find a function that is positive for regions with a high density of points, and negative for small densities. The illustration is as Fig.5 

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/7.png" width = "350">

Fig.5 Illustration of one-class SVM

Then we can formulate this model training as an optimization problem as follows.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/8.png" width = "350">

Fig. 6 Formulation of one-class SVM

The second model we use is the Isolation Forest. The main idea of this model is to explicitly identify anomalies instead of profiling normal data points. The Isolation Forest, like any tree ensemble method, is built on the basis of decision trees. In these trees, partitions are created by first randomly selecting a feature and then selecting a random split value between the minimum and maximum value of the selected feature.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/9.png" width = "500">

Fig.7 Illustration of Isolation Forest

For both models, we trained and tested them in python using scikitlearn package which allows us to tune parameters in order to achieve the best performance.

_Noise detection procedure_

Here we only focus on the audio from one channel and conduct the computation off-line. First, partition the audio as is stated before into frames. Take 80% samples with the presence of a car noise as training data after extracting the NBIP from all audios. Train both the one-class SVM and Isolation Forest and then test them with the left 20% samples to see the performance. In addition, during the test, we also use some random noise such as walking, talking to test their robustness. The whole result will be shown in the next section.

_Synchronization_

Here, due to the limitation of two-channel audio collection on Android phones, we decide to use two phones simultaneously to record both the left and right audios from two microphones. The main issue here is the synchronization problem which may cause a large error in the direction detection part. In this project, we propose a common synchronization approach that before the car noise appears, we generate a 1kHz tone by another phone which is placed equally distant to the two recording phones. Then, by checking the 1kHz peak in FFT in each audio frame, we are able to tell the time difference between the two phones. 

_Direction detection_

To determine the detection, we have to compute the time delay of the first presence of car noise between the left and right microphones. First, perform the prediction on each channel through the trained machine learning model and get the time t when the car noise first appears. Then, according to the time delay obtained from the synchronization part, we can compute the real-time difference and then direction.

_eSense earables IMU Android app_

In this project, we use eSense Library in Android Studio to help us determine the position of head. The eSense library provides a set of intuitive APIs to interact with the eSense device. Android phone can access and operate the eSense device via Bluetooth Low Energy (BLE). The minimum SDK version of the library is set to Android 6.0 (API 23) and we run eSense library in Pixel 2 with API level 26. The app we used in this project is a modified version of eSense functions and Brian Wang add the recording of IMU values, displaying them, and logging the values to original function which benefit us. After connect eSense earables to Pixel 2 and run this app, we could get a UI shown in fig.10. ACC value shows the linear acceleration of your head and GYRO show the angular acceleration of your head in three axis.  Only thing we should notice here is that to determine the position of your head, you should have an initial setup point and relative angle movement of your head. This app shows the angular acceleration of your head which is in degree/second. Theoretically, we could do integration of angular acceleration over time to obtain the relative angle movement. While the IMU unit of eSense come with a non-ignorable noise which will greatly influence the accuracy if we simply do integration. A well designed common filter should be used to filter out these noise and we will leave that to teh future work.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/10.png" width = "300">

## Result ##

_Detection_

Several samples tested by either one-class SVM or Isolation Forest are shown in the following figures.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/11.png" width = "400">

Fig.9 One-class SVM performance 

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/12.png" width = "400">

Fig.10 Isolation Forest performance

Fig.9 and Fig.10 show the results from the two models tested with the same sample. Obviously, the performance of isolation forest is much better since it has less oscillation in detection. The reason is that the dimension of the feature we use is too high for SVM to have a good classification. As a result, we will use the Isolation Forest model as the detection model later. Besides, we test the robustness of the Isolation Forest model by applying a random noise The result can be shown as follows.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/13.png" width = "400">

Fig. 11 Test with random noise

Accordingly, the model can clearly tell the non-car noise and the accuracy is good.

_Synchronization_

A sample of synchronization is shown as follows.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/14.png" width = "400">

Fig.12  The appearance of 1kHz peak in the right channel

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/15.png" width = "400">

Fig.13  The appearance of 1kHz peak in the left channel

According to the two figures above, we can compute the time difference between the two phones as 
Dt =  (1073-767)*T_slide = 0.555102s

_Direction Detection_

A sample of an approaching car from the right-hand side is tested through the previous procedure. The result is as follows.

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/16.png" width = "400">

Fig.14 Right channel detection

<img src="https://github.com/xuchenxuexx/EEM202A_Final_Project/blob/master/Docs/17.png" width = "400">

Fig.15 Left channel detection

From the two figures above, we can record the time when the car noise first appears. In this case, the relative delay is 

(3904-3602)*T_slide = 0.5478458s 

Combined with the synchronization time we computed previously, the final result is 

0.555102 - 0.547846 = 0.007526s

Right comes first, which means the car is approaching from the right-hand side, consistent with our sample.


## Future Works ##

There are plenty of future work needed to be done to complete the whole alert system. First, when we collect sample data to extract features and train model, we need to choose different kinds of car models and under different kinds of situation. In this project, we choose car model of Audi A4 under garage environment which limit the scope of application. Second thing is that to achieve analyze the audio data in real time, we need to develop a specific PCB board which can take multiple audio input and send them to mobile phone with good synchronization property and this could be challenging. After completing this, we need to upload all the MATLAB code and Python code to Android Studio and run them under proper packages. Also, the parameter of feature extraction and model training should be optimized to improve the robustness of this system with reducing the amount of computation.  Finally, we need to design a robust common filter to filter out the noise of IMU unit to achieve function of determining user’s head position. 

## Reference ##

[1] de Godoy, D., Islam, B., Xia, S., Islam, M. T., Chandrasekaran, R., Chen, Y. C., ... & Jiang, X. (2018, April). Paws: A wearable acoustic system for pedestrian safety. In 2018 IEEE/ACM Third International Conference on Internet-of-Things Design and Implementation (IoTDI) (pp. 237-248). IEEE.
[2] S. Xia et al., "A Smartphone-Based System for Improving Pedestrian Safety," 2018 IEEE Vehicular Networking Conference (VNC), Taipei, Taiwan, 2018, pp. 1-2.

