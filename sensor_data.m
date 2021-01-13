% Script for demonstration of sensor data via MQTT/JSON: sensor_data.m
% Tested with GNU Octave and MATLAB
% For Octave only:
% >> pkg install https://github.com/apjanke/octave-jsonstuff/releases/download/v0.3.3/jsonstuff-0.3.3.tar.gz
% >> pkg load jsonstuff
% Sometimes of interest for MATLAB and Octave:
% https://github.com/fangq/jsonlab
% 27.02.2020, Manfred Lohöfener, HoMe

%% Example for sensor data model
clear
sensor.addr = 'BUT';
sensor.room = 'A1/114';
sensor.numb = 43;
sensor.time = datestr (now, 'dd.mm.yyyy_HH:MM:SS');
sensor.vari = 'temperature';
sensor.valu = 23;
sensor.unit = '°C';
disp (' ')
disp ('sensor – Example')
disp (sensor)

%% JSON String
sensor_json = jsonencode (sensor);  % Plain MATLAB or Octave with package JSONstuf
disp (' ')
disp ('sensor_json – JSON String')
disp (sensor_json)

%% Publish
%broker = 'test.mosquitto.org';
%broker = 'broker.hivemq.com';
broker = 'iot.hs-merseburg.de';
topic = 'HoMe18';
sensor_json_pub = strrep (sensor_json, '"', '\"');  % escape the quotes
stat = mqtt_pub (broker, topic, sensor_json_pub);
