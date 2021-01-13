% Advantech_WISE_4012E_MQTT_sub.m Script for testing MQTT
% Voraussetzungen:
% 1. Paket mosquitto-clients installieren
% 2. GNU Octave oder MATLAB installieren.
% For Octave only:
% >> pkg install https://github.com/apjanke/octave-jsonstuff/releases/download/v0.3.3/jsonstuff-0.3.3.tar.gz
% >> pkg load jsonstuff
% 01.12.2017, Manfred Lohöfener, HoMe
% TCP-Port: 1883

clear
%broker = 'test.mosquitto.org';
broker = 'raspberrypi-loh';
broker = '192.168.1.146';
%broker = 'broker.hivemq.com';
%broker = 'iot.hs-merseburg.de';
topic = 'Advantech/00D0C9FAD5D3/data';

for c = 1:200                                % Counter
%for c = 1:5                                % Counter
    [stat, data] = mqtt_sub (broker, topic);  % Daten empfangen
    sensor = jsondecode (data);
%    sensor = data;
    disp (' ')
    disp (['broker/Topic: ' broker '/' topic])
    disp ('Sensordaten')
    disp (sensor)
end
