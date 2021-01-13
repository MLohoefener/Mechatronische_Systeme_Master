% Advantech_WISE_4012E_MQTT_pub.m Script for testing MQTT
% Voraussetzungen:
% 1. Paket mosquitto-clients installieren
% 2. GNU Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe
% http://www.mqtt-dashboard.com/
% TCP-Port: 1883

clear
%broker = 'test.mosquitto.org';
%broker = 'broker.hivemq.com';
%broker = 'iot.hs-merseburg.de';
%broker = '192.168.1.146';
broker = 'raspberrypi-loh';
topic1 = 'Advantech/00D0C9FAD5D3/ctl/do1';
topic2 = 'Advantech/00D0C9FAD5D3/ctl/do2';
t_p = 5;            % Pausenzeit in s
disp ('Zähler')
for c = 1:20        % Counter
  disp (num2str(c))
  sensor.v = true;
  sensor_json = jsonencode (sensor);  % Plain MATLAB or Octave with package JSONstuf
  sensor_json_pub = strrep (sensor_json, '"', '\"');  % escape the quotes
  stat = mqtt_pub (broker, topic1, sensor_json_pub);
  pause (t_p)
  sensor.v = false;
  sensor_json = jsonencode (sensor);  % Plain MATLAB or Octave with package JSONstuf
  sensor_json_pub = strrep (sensor_json, '"', '\"');  % escape the quotes
  stat = mqtt_pub (broker, topic2, sensor_json_pub);
  pause (t_p)
  sensor.v = false;
  sensor_json = jsonencode (sensor);  % Plain MATLAB or Octave with package JSONstuf
  sensor_json_pub = strrep (sensor_json, '"', '\"');  % escape the quotes
  stat = mqtt_pub (broker, topic1, sensor_json_pub);
  pause (t_p)
  sensor.v = true;
  sensor_json = jsonencode (sensor);  % Plain MATLAB or Octave with package JSONstuf
  sensor_json_pub = strrep (sensor_json, '"', '\"');  % escape the quotes
  stat = mqtt_pub (broker, topic2, sensor_json_pub);
  pause (t_p)
end
