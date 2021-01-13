% Script for analysing of sensor data via MQTT/JSON: sensor_analyse.m
% Tested with GNU Octave and MATLAB
% For Octave only:
% >> pkg install https://github.com/apjanke/octave-jsonstuff/releases/download/v0.3.3/jsonstuff-0.3.3.tar.gz
% >> pkg load jsonstuff
% Sometimes of interest: https://github.com/fangq/jsonlab
% 27.02.2020, Manfred Lohöfener, HoMe

%% Subscribe
clear
%broker = 'test.mosquitto.org';
%broker = 'broker.hivemq.com';
broker = 'iot.hs-merseburg.de';
topic = 'HoMe18';
% [stat, sensor_json] = mqtt_sub_JSON (broker, topic)
[stat, sensor_json] = mqtt_sub (broker, topic);
disp (' ')
disp ('sensor_json – JSON String')
disp (sensor_json)

%% Test 
sensor_json_sensor = jsondecode (sensor_json);  % Plain MATLAB or Octave with package JSONstuf
disp (' ')
disp ('sensor_json_sensor – Test')
disp (sensor_json_sensor)
