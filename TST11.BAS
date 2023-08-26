'TELECOM SET TIME v1.1
'by Warren Leadbeatter
'3rd May 1993

DEFINT A-Z
DECLARE SUB Welcom ()
CONST False = 0, True = NOT False
ON ERROR GOTO ERRTRAP
CALL Welcom
CL$ = "T0292674648"
ZZ = 1
Redials = 0

GETNUM:
FLAG = 1
OPEN "TELECOM" FOR INPUT AS #1
INPUT #1, b$
CLOSE #1
C$ = "ATD" + b$

DIAL:
FLAG = 2
OPEN "COM1:2400,E,7,1,OP0,DS0" FOR RANDOM AS #1 LEN = 256
PRINT #1, C$
Dummy$ = INPUT$(LOC(1), #1)  'Clear Modem Buffer
ModemInput$ = ""
COLOR 2
IF Redials = 0 THEN
  LOCATE 11, 27
  PRINT "Dialling, Please Wait..."
ELSE
  LOCATE 11, 20
  PRINT "Redialling, Count = "; Redials; "of 3, Please wait..."
END IF
StopTime& = TIMER + 30 ' Set Timeout to 30 Seconds
DO
        IF INP(&H3FE) >= 128 THEN
                GOTO CONN
        ELSE
                COLOR 22
                LOCATE 15, 30
                PRINT "Press C to Cancel"
                a$ = INKEY$
                IF a$ = "c" OR a$ = "C" THEN
                        GOTO TERM
                END IF
        END IF
LOOP UNTIL (StopTime& - TIMER) MOD 86400 <= 0
Redials = Redials + 1
IF Redials >= 4 GOTO NOCONN
PRINT #1, CHR$(27)
CLOSE #1
CALL Welcom
GOTO DIAL

NOCONN:
PRINT #1, CHR$(27)
CLS
COLOR 12
LOCATE 14, 15: INPUT " Unable to establish connection, Try Again? (y/N) ", W$
IF W$ = "Y" OR W$ = "y" THEN
        FOR i = 1 TO 2000
        NEXT
        CLS
        CLOSE
        Redials = 0
        CALL Welcom
        GOTO DIAL
END IF

TERM:
CLS
COLOR 2
LOCATE 12, 24: PRINT "CALL TERMINATED, Returning to Dos..."
COLOR 7
LOCATE 24, 1
PRINT #1, CHR$(27)
CLOSE
END

CONN:
Dummy$ = INPUT$(LOC(1), #1)     'Clear Modem Buffer
ModemInput$ = ""
ON ERROR GOTO 0                 ' Disable Error Trapping.
COLOR 2, 0                      ' Set screen color.
CLS
QUIT$ = CHR$(0) + CHR$(16)      ' Value returned by INKEY$
                                ' when ALT+Q is pressed.
Temp$ = "0000-00-00 00:00:00#"
PRINT "GETTING DATA..."
PRINT

DO                              ' Main communications loop.
   KeyInput$ = INKEY$           ' Check the keyboard.
   IF KeyInput$ = QUIT$ THEN    ' Exit the loop if the user
      EXIT DO                   ' pressed ALT+q.
   END IF
   IF NOT EOF(1) THEN
      LINE INPUT #1, ModemInput$
      IF LEFT$(ModemInput$, 17) = LEFT$(Temp$, 17) THEN
        yy$ = MID$(ModemInput$, 4, 2)
        mm$ = MID$(ModemInput$, 7, 2)
        dd$ = MID$(ModemInput$, 10, 2)
        tt$ = MID$(ModemInput$, 13, 8)
        dte$ = mm$ + "-" + dd$ + "-" + yy$
        PRINT "The Current Date is: " + DATE$
        PRINT "The Current Time is: " + TIME$
        DATE$ = dte$
        TIME$ = tt$
        PRINT
        PRINT "Setting Date to: " + dd$ + "-" + mm$ + "-" + yy$
        PRINT "Setting Time to: " + tt$
        IF MID$(ModemInput$, 21, 1) = "*" THEN
          PRINT "Australian Eastern Standard Time"
        ELSE
          PRINT "Australian Daylight Savings Time"
        END IF
        PRINT
        PRINT "DONE!"
        END
      ELSE
        Temp$ = ModemInput$
      END IF
   END IF
LOOP

CLOSE                           ' End communications.
CLS
END

ERRTRAP:

SELECT CASE FLAG
    CASE 1
        FLAG = 0
        COLOR 7
        LOCATE 9, 15
        PRINT "  Writing TELECOM with '"; LTRIM$(CL$); "' as the NUMBER"
        OPEN "TELECOM" FOR OUTPUT AS #3
        PRINT #3, CL$
        CLOSE #3
        ZZ = ZZ + 1
        IF ZZ = 3 THEN
                BEEP
                COLOR 7
                LOCATE 11, 25
                PRINT "Could NOT write TELECOM file!"
                LOCATE 13, 16
                PRINT " Check to make sure DISK is NOT WRITE PROTECTED"
                END
        END IF
        RESUME GETNUM
    CASE 2
        FLAG = 0
        BEEP
        COLOR 14
        LOCATE 11, 30: PRINT "MODEM NOT READY!"
        LOCATE 13, 27: PRINT "Please check the MODEM"
        PRINT ERR
        COLOR 2
        LOCATE 15, 14: PRINT "Press Space Bar to try again or C to Cancel call"
        DO
           Z$ = INKEY$
           IF Z$ = "C" OR Z$ = "c" GOTO TERM
           IF Z$ = " " THEN CLOSE #1: CLS : CALL Welcom: RESUME DIAL
        LOOP
        END
    CASE ELSE
        BEEP
        COLOR 7
        LOCATE 7, 1
        PRINT "  AN ERROR HAS OCCURED"
        LOCATE 9, 1
        PRINT "Contact Warren Leadbeatter for further Help, Ph: 02-622-3668"
        PRINT
        PRINT "ERROR CODE: "; ERR
        CLOSE
        END
END SELECT

END

SUB Welcom

CLS
LOCATE 1, 1, 0
COLOR 2
PRINT " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT " ³                                                                            ³"
PRINT " ³                                                                            ³"
PRINT " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 14
LOCATE 2, 22: PRINT "TST - Telecom Set Time Program v1.1"
LOCATE 3, 15: PRINT "by Warren Leadbeatter - Copyright (c) 3rd May, 1993"

END SUB

