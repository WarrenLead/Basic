' MENU program for ResMon & Mark 7 Dialup
' Version 2.1 - 22nd October 1991
' by Warren Leadbeatter

START:

COLOR 7, 0
CLS
COLOR 7, 1
LOCATE 2, 2, 0
PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"

ROW = 3

WHILE ROW < 6
  LOCATE ROW, 2
  PRINT "บ                                                                            บ"
  ROW = ROW + 1
WEND

LOCATE ROW, 2

PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
ROW = ROW + 1

WHILE ROW < 23
  LOCATE ROW, 2
  PRINT "บ                                                                            บ"
  ROW = ROW + 1
WEND

LOCATE ROW, 2
PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"

COLOR 15
LOCATE 3, 23
PRINT "Water Board Dial-up Telemtry Systems"
COLOR 15
LOCATE 4, 31
PRINT "Menu Selection System"
COLOR 7
LOCATE 5, 16
PRINT "Version 2.10 - Warren Leadbeatter - 28th June 1992"

COLOR 15, 4
LOCATE 10, 10
PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"

ROW = 11

WHILE ROW < 16
  LOCATE ROW, 10
  PRINT "บ                                                            บ"
  ROW = ROW + 1
WEND

LOCATE 16, 10
PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
COLOR 1, 0

ROW = 11

WHILE ROW < 17
  LOCATE ROW, 72
  PRINT "ฐฐ"
  ROW = ROW + 1
WEND

LOCATE 17, 12
PRINT STRING$(62, "ฐ")

COLOR 10
I = 1
RESTORE
READ P$

WHILE P$ <> "END"
  READ c$(I), H$(I)
  LOCATE 11 + I, 24
  COLOR 15, 4
  PRINT I; "  -  "
  LOCATE 11 + I, 33
  COLOR 14
  PRINT P$
  I = I + 1
  READ P$
WEND

'Define Alt-E for Edit
Edit$ = CHR$(0) + CHR$(18)
'Define Alt-D for Dos Shell
DOS$ = CHR$(0) + CHR$(32)

LOCATE 3, 4
DateMM$ = LEFT$(DATE$, 2)
IF LEFT$(DateMM$, 1) = "0" THEN DateMM$ = MID$(DateMM$, 2, 1)
DateDD$ = MID$(DATE$, 4, 2)
IF LEFT$(DateDD$, 1) = "0" THEN DateDD$ = MID$(DateDD$, 2, 1)
DateYY$ = RIGHT$(DATE$, 2)
DateDDMMYY$ = " " + DateDD$ + "/" + DateMM$ + "/" + DateYY$ + " "

COLOR 14, 0

PRINT DateDDMMYY$

LOCATE 21, 16
PRINT "  Enter the"; : COLOR 15: PRINT " number"; : COLOR 14: PRINT " for your choice, or"; : COLOR 15: PRINT " Q"; : COLOR 14: PRINT " to Quit  "
c = 0

Stoptime& = TIMER + 10   'Set Screen Saver TIME

WHILE c < 1 OR c >= I
  POKE 106, 0
  CMD$ = INKEY$
  WHILE CMD$ = ""
    T$ = TIME$
    Hr = VAL(T$)
    IF Hr < 12 THEN Ampm$ = " am" ELSE Ampm$ = " pm"
    IF Hr > 12 THEN Hr = Hr - 12
    IF Hr < 10 THEN POSI = 1 ELSE POSI = 0
    LOCATE 3, 65 + POSI: PRINT " " + LTRIM$(STR$(Hr)); RIGHT$(T$, 6); Ampm$ + " "
    IF ((Stoptime& - TIMER) MOD 86400) <= 0 THEN
      GOSUB SCREENSAVE
      GOTO START
    END IF
    CMD$ = INKEY$
  WEND
  IF CMD$ = "Q" OR CMD$ = "q" THEN
        COLOR 2, 0
        CLS
        SYSTEM
  ELSEIF CMD$ = Edit$ THEN
        SHELL "Q"
        GOTO START
  ELSEIF CMD$ = DOS$ THEN
        CLS
        PRINT "Type EXIT to return to MENU";
        SHELL
        GOTO START
  ELSE
        c = VAL(CMD$): IF c < 1 OR c >= I THEN BEEP
  END IF
WEND

IF H$(c) <> "" THEN LOCATE 22, 20: PRINT H$(c); : INPUT "", D$

COLOR 2, 0
CLS

SHELL c$(c)

LOCATE 23, 1
COLOR 14, 0
PRINT
INPUT "Press ENTER to continue", D$
GOTO START

DATA "Reservoir Monitoring System","RMS","","Mark 7 Telemetry System","MK7",""
DATA "Operations Room LAN System","OPSROOM","","END"


SCREENSAVE:
CLS
Steptime& = TIMER + 45
AA = INT(RND * 24) + 1
IF AA < 5 THEN AA = 5
IF AA > 20 THEN AA = 20
COLOR 4
WHILE CMD$ = ""
LOCATE AA, 4, 0
T$ = TIME$
Hr = VAL(T$)
IF Hr < 12 THEN Ampm$ = " am" ELSE Ampm$ = " pm"
IF Hr > 12 THEN Hr = Hr - 12
PRINT " " + LTRIM$(STR$(Hr)); RIGHT$(T$, 6); Ampm$ + " - Menu has shut off the screen,  Hit the space bar return...";
IF ((Steptime& - TIMER) MOD 86400) <= 0 THEN
      CLS
      AA = AA + 1
      IF AA > 20 THEN AA = 5
      Steptime& = TIMER + 45
END IF
REM WHILE CMD$ = ""
CMD$ = INKEY$
WEND
RETURN

