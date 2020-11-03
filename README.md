# Mechatronische Systeme (Master)

## Skripte zu Vorlesungen Mechatronische Systeme (Master) an der Hochschule Merseburg

**Voraussetzungen**: PC mit

1. MATLAB® und Control Systems Toolbox für M-Skripte bzw. Funktionen
2. MATLAB® und Simulink® für SLX-Blockdiagramme
3. https://www.octave.org und `pkg install -forge control symbolic; pkg load control symbolic` für M-Skripte bzw. Funktionen

**Datei**|**Beschreibung**
---|---
**DC_contr_ZN.m**|MATLAB-Skript zur PID-Parameteroptimierung für einen Maxon-Motor nach Ziegler-Nichols
**DC_mot.zcos**|Scilab/Scicos-Blockdiagramm zur Modellierung einens Maxon-Motors
**DC_mot_TF.m**|MATLAB-Skript zur Modellierung einens Maxon-Motors
**Maxon_Control_BD.m**|MATLAB-Skript zur PID-Parameteroptimierung für einen Maxon-Motor im Zustandsraum mit Polvorgabe
**Maxon_feedback.m**|MATLAB-Skript zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Kaskadenregler
**PID_RE35.slx**|Simulink-Blockdiagramm zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Kaskadenregler
**ifmember.m**|MATLAB-Funktion als Ersatz für die Funktion ismember
**pole-place.m**|MATLAB-Funktion zur Parameterberechnung im Zustandsraum mit Polvorgabe
