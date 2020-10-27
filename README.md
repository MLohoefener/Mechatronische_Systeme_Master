# Mechatronische Systeme (Master)

## Skripte zu Vorlesungen Mechatronische Systeme (Master) an der Hochschule Merseburg

**Voraussetzungen**: PC mit

1. MATLAB® und Control Systems Toolbox für M-Skripte bzw. Funktionen
2. MATLAB® und Simulink® für SLX-Blockdiagramme
3. https://www.octave.org und `pkg install -forge control symbolic; pkg load control symbolic` für M-Skripte bzw. Funktionen

**Datei**|**Beschreibung**
---|---
**Maxon_Control_BD.m**|MATLAB-Skript zur PID-Parameteroptimierung für einen Maxon-Motor im Zustandsraum mit Polvorgabe
**Maxon_feedback.m**|MATLAB-Skript zur Regelkreis-Simulation mit einem Maxon-Motor und PID-Kaskadenregler
**pole-place.m**|MATLAB-Funktion zur Parameterberechnung im Zustandsraum mit Polvorgabe
**ifmember.m**|MATLAB-Funktion als Ersatz für die Funktion ismember
