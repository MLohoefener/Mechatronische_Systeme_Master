function [stat, message] = mqtt_sub (host, topic)
% Receive an MQTT message
% Breaks after each received message
% Example: [stat, message] = mqtt_sub ('iot.hs-merseburg.de', 'Uhrzeit')
% Example: [stat, message] = mqtt_sub ('test.mosquitto.org', 'HoMe18')
% Prerequisites:
% 1. Install mosquitto from https://mosquitto.org/download/
% 2. Install Octave from https://www.gnu.org/software/octave/ (or use MATLAB)
% 2017-2020, Manfred Lohöfener, HoMe

    if isunix
        cmd = ['mosquitto_sub -h "' host '" -C 1 -q 1 -t "' topic '"'];
    elseif ispc
        cmd=['c:\programme\mosquitto\mosquitto_sub -h ' host ' -C 1 -t ' topic ];
    else 
        disp ('MacOS bisher nicht unterstützt')
    end
  [stat, message] = system (cmd);
end
