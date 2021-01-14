# Mechatronische Systeme (Master)

## Skripte zu Vorlesungen Mechatronische Systeme (Master) an der Hochschule Merseburg

**Voraussetzungen**: PC mit

1. MATLAB® und Control Systems Toolbox für M-Skripte bzw. Funktionen
2. MATLAB® und Simulink® für SLX-Blockdiagramme
3. https://www.scilab.org/ für Scilab-Skripte SCE oder Scilab-Funktionen SCI bzw. XCOS- oder ZCOS-Blockdiagramme
4. https://www.octave.org und `pkg install -forge control symbolic; pkg load control symbolic` für M-Skripte bzw. Funktionen

**Datei**|**Beschreibung**
---|---
**Advantech_WISE_4012E_MQTT_pub.m**|MATLAB-Skript zur Steuerung eines WISE-4012
**Advantech_WISE_4012E_MQTT_sub.m**|MATLAB-Skript zur Datenauswertung eines WISE-4012
**DC_contr_ZN.m**|MATLAB-Skript zur PID-Parameteroptimierung für einen Maxon-Motor nach Ziegler-Nichols
**DC_mot.zcos**|Scilab/Scicos-Blockdiagramm zur Modellierung einens Maxon-Motors
**DC_mot_TF.m**|MATLAB-Skript zur Modellierung einens Maxon-Motors
**Kf.m**|MATLAB-Skript zur Berechnung des Coulombschen Reibbeiwertes einens Maxon-Motors
**MQTT_Test.m**|MATLAB-Skript zum Veröffentlichen von MQTT-Nachrichten mit MATLAB
**Maxon_Control_BD.m**|MATLAB-Skript zur PID-Parameteroptimierung für einen Maxon-Motor im Zustandsraum mit Polvorgabe
**Maxon_feedback.m**|MATLAB-Skript zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Kaskadenregler
**PID_RE35.slx**|Simulink-Blockdiagramm zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Kaskadenregler
**RE35.slx**|Simulink-Blockdiagramm zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Regler
**RE35_2019a.slx**|Simulink-Blockdiagramm zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Regler in ML/SL-2019a
**RE_35.m**|MATLAB-Skript zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Regler
**Test_MQTT_pub.m**|MATLAB-Skript zum Veröffentlichen von MQTT-Nachrichten
**Test_MQTT_sub.m**|MATLAB-Skript zum Abbonieren von MQTT-Nachrichten
**ifmember.m**|MATLAB-Funktion als Ersatz für die Funktion ismember
**mqtt_pub.m**|MATLAB-Funktion zum Veröffentlichen von MQTT-Nachrichten mit mosquitto_pub
**mqtt_sub.m**|MATLAB-Funktion zum Abbonieren von MQTT-Nachrichten mit mosquitto_sub
**pole-place.m**|MATLAB-Funktion zur Parameterberechnung im Zustandsraum mit Polvorgabe
**sensor_analyse.m**|MATLAB script for analysing sensor data via MQTT/JSON
**sensor_data.m**|MATLAB script for demonstration of sensor data via MQTT/JSON
