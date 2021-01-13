function stat = mqtt_pub (host, topic, message)
% Send an MQTT message
% Example: mqtt_pub ('iot.hs-merseburg.de', 'Uhrzeit', '03.07.2018 11:15:22')
% Example: mqtt_pub ('test.mosquitto.org', 'HoMe18', 'Heute ist ein heißer Tag')
% Prerequisites:
% 1. Install mosquitto from https://mosquitto.org/download/
% 2. Install Octave from https://www.gnu.org/software/octave/ (or use MATLAB)
% 2017-2020, Manfred Lohöfener, HoMe

    if isunix
        cmd = ['mosquitto_pub -h "' host '" -t "' topic '" -m "' message '"'];
    elseif ispc
        cmd = ['c:\programme\mosquitto\mosquitto_pub -h "' host '" -t "' topic '" -m "' message '"'];
    else 
        disp ('MacOS bisher nicht unterstützt')
    end
    stat = system (cmd); % Execute operating system command and return output
end
