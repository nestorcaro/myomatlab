%% Simple demo for the Myo MATLAB interface
% #######################################################################
%
% Last modified by  Néstor Caro (18 October 2015)
%
% Authored by Yi Jui Lee - Version 1 (15 August 2015)
% 
% Tested on MATLAB 2013a, Python 2.7
% Filename : myo_workfile.m
% Depends on Myo.m official development version
% 
% ***********************************************************************
% 
% Please refer to Myo's API and SDK Portal to learn more about the device

%% Create Myo Object

close all;clear all; 
% Instantiates Myo object
m = Myo();
m.getAllData();
pause(6)       % BECAUSE PYTHON IS WRITING THE .TXT FILES; OPENING THEM WITHOUT PAUSE WILL CAUSE THE VISUALIZATION OF INCOMPLETE DATA
%% Acceleration
a1 = [0 0 0];
FileID1 = fopen('Acceleration.txt');
Acceleration_t = textscan(FileID1,'%s %s %s');
for i = 1:length(Acceleration_t{1});
	a1(end+1,:) = str2num([Acceleration_t{1,1}{i,1} Acceleration_t{1,2}{i,1} Acceleration_t{1,3}{i,1}]);
end
acceleration = a1(2:end,:);
fclose(FileID1);

%% Gyroscope
a2 = [0 0 0];
FileID2 = fopen('Gyroscope.txt');
Gyroscope_t = textscan(FileID2,'%s %s %s');
for i = 1:length(Gyroscope_t{1});
	a2(end+1,:) = str2num([Gyroscope_t{1,1}{i,1} Gyroscope_t{1,2}{i,1} Gyroscope_t{1,3}{i,1}]);
end
gyroscope = a2(2:end,:);
fclose(FileID2);

%% Orientation
a3 = [0 0 0 0];
a3_e = [0 0 0];
FileID3 = fopen('Orientation.txt');
Orientation_t = textscan(FileID3,'%s %s %s %s');
for i = 1:length(Orientation_t{1});
	a3(end+1,:) = str2num([Orientation_t{1,1}{i,1} Orientation_t{1,2}{i,1} Orientation_t{1,3}{i,1}, Orientation_t{1,4}{i,1}]);
	% % quaternion conversion
	[roll, pitch, yaw] = quat2angle(a3(end,:));
	a3_e(end+1,:) = [roll pitch yaw];
end
orientation = a3_e(2:end,:);
fclose(FileID3);

%% Pose
a4{1,1} = 'rest>';
FileID4 = fopen('Pose.txt');
Pose_t = textscan(FileID4,'%s %s');
for i = 1:length(Pose_t{1,2});
	a4{end+1,1} = [char([Pose_t{1,2}{i,1}])];
end
pose = a4;
fclose(FileID4);

%% EMG
a5 = [0 0 0 0 0 0 0 0];
FileID5 = fopen('Emg.txt');
Emg_t = textscan(FileID5,'%s %s %s %s %s %s %s %s');
for i = 1:length(Emg_t{1});
	a5(end+1,:) = str2num([Emg_t{1,1}{i,1} Emg_t{1,2}{i,1} Emg_t{1,3}{i,1} Emg_t{1,4}{i,1} Emg_t{1,5}{i,1} Emg_t{1,6}{i,1} Emg_t{1,7}{i,1} Emg_t{1,8}{i,1}]);
end
emg = a5(2:end,:);

%% Data can be accessed through the Myo object (post-use)
% acceleration = m.acceleration;  % acceleration is given in 3 axis - units in g
% gyroscope = m.gyroscope;        % gyroscope is given as the rate of rotation in 3 axis - units in deg/s
% orientation = m.orientation;    % Python interface returns quaternions x,y,z,w
%                                 % Myo.m utilizes quat2angle to convert the quaternions to euler angles
%                                 % roll pitch yaw units in radians
% %--------------------------------------------------------------------------------------------------------------------
% pose = m.pose;                  % Gets predefined gestures -  gesture statuses are fist, rest, waveout, wavein, fingerspread, doubletap
% emg = m.emg;                    % Gets raw EMG data from the 8 pods on the Myo armband - unitless value from -127 to 127
% 
