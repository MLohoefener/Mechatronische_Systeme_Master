% Test_MQTT_pub.m Script for testing MQTT
% Voraussetzungen:
% 1. Paket mosquitto-clients installieren
% 2. GNU Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe
% http://www.mqtt-dashboard.com/
% TCP-Port: 1883

clear
host = 'test.mosquitto.org';
host = 'raspberrypi-loh';
%host = 'broker.hivemq.com';
%host = 'iot.hs-merseburg.de';
topic = 'Uhrzeit';
%topic = 'Advantech/00D0C9FAD5D3/data';
%topic = 'HoMe18';

for c = 1:21                                  % Counter
  testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');
  mqtt_pub (host, topic, [testMessage]);
  pause (2)                                   % 2 s Pause
end
