% Test_MQTT_sub.m Script for testing MQTT
% Voraussetzungen:
% 1. Paket mosquitto-clients installieren
% 2. GNU Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe
% TCP-Port: 1883

clear
%host = 'test.mosquitto.org';
host = 'raspberrypi-loh';
%host = 'broker.hivemq.com';
%host = 'iot.hs-merseburg.de';
%topic = 'Uhrzeit';
topic = 'Advantech/00D0C9FAD5D3/data';
%topic = 'HoMe18';
puf = {0};                                  % Message-Puffer

%for c = 1:20                                % Counter
for c = 1:5                                 % Counter
    [stat, txt] = mqtt_sub (host, topic);   % Uhrzeit empfangen
    testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');
    puf (c) = {[testMessage ' : ' txt]};    % Empfangs- und Sendezeit
end

disp (puf');                                % auf Konsole
fid = fopen ('puf.txt', 'w');
fprintf (fid, '%s\n', '    Empfangszeit    :     Sendezeit');
fprintf (fid, '%s', puf{:});                % und in Datei
fclose (fid);
