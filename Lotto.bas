10 REM ******************************
20 REM 3 DOGS LOTTO SYNDICATE CHECKER
30 REM ******************************
40 REM FOR IBM BASICA CIRCA 1987
50 REM BY WARREN LEADBEATTER 
60 REM ******************************
100 SCREEN 0, 0, 0: COLOR 0, 3, 1
110 CLS : LOCATE 2, 26: PRINT "3-DOGS LOTTO RESULTS CHECKER"
120 LOCATE 3, 25: PRINT "*****************************"
130 LOCATE 5, 3: INPUT "ENTER 1ST NUMBER"; A
140 IF A = 0 OR A > 40 THEN 130
150 LOCATE 7, 4: INPUT "ENTER 2ND NUMBER"; B
160 IF B = 0 OR B > 40 THEN 150
170 IF B = A THEN GOSUB 675: GOTO 150
180 PRINT "                                                   "
190 LOCATE 9, 5: INPUT "ENTER 3RD NUMBER"; C
200 IF C = 0 OR C > 40 THEN 190
210 IF C = A OR C = B THEN GOSUB 675: GOTO 190
220 PRINT "                                                   "
230 LOCATE 11, 6: INPUT "ENTER 4TH NUMBER"; D
240 IF D = 0 OR D > 40 THEN 230
250 IF D = A OR D = B OR D = C THEN GOSUB 675: GOTO 230
260 PRINT "                                                   "
270 LOCATE 13, 7: INPUT "ENTER 5TH NUMBER"; E
280 IF E = 0 OR E > 40 THEN 270
290 IF E = A OR E = B OR E = C OR E = D THEN GOSUB 675: GOTO 270
300 PRINT "                                                   "
310 LOCATE 15, 8: INPUT "ENTER 6TH NUMBER"; F
320 IF F = 0 OR F > 40 THEN 310
330 IF F = A OR F = B OR F = C OR F = D OR F = E THEN GOSUB 675: GOTO 310
340 PRINT "                                                   "
350 LOCATE 17, 9: INPUT "ENTER SUPLEMENTARY NUMBER"; G
360 IF G = 0 OR G > 40 THEN 350
370 IF G = A OR G = B OR G = C OR G = D OR G = E OR G = F THEN GOSUB 675: GOTO 350
380 CLS
390 FOR I = 1 TO 12
400 READ J, K, L, M, N, O
410 X = 0: Y = 0
420 IF A = J OR A = K OR A = L OR A = M OR A = N OR A = O THEN X = X + 1
430 IF B = J OR B = K OR B = L OR B = M OR B = N OR B = O THEN X = X + 1
440 IF C = J OR C = K OR C = L OR C = M OR C = N OR C = O THEN X = X + 1
450 IF D = J OR D = K OR D = L OR D = M OR D = N OR D = O THEN X = X + 1
460 IF E = J OR E = K OR E = L OR E = M OR E = N OR E = O THEN X = X + 1
470 IF F = J OR F = K OR F = L OR F = M OR F = N OR F = O THEN X = X + 1
480 IF G = J OR G = K OR G = L OR G = M OR G = N OR G = O THEN Y = 1
490 PRINT : PRINT : PRINT "GAME NUMBER "; I,
500 PRINT J; K; L; M; N; O
505 PRINT
510 IF X = 3 AND Y = 0 THEN PRINT "CLOSE BUT SUCK EGGS YOU LOSE (3 NUMBERS)"
520 IF X = 2 AND Y = 1 THEN PRINT "CLOSE BUT SUCK EGGS YOU LOSE (2 AND A SUP)"
530 IF X = 0 AND Y = 1 THEN PRINT "SUCK EGGS YOU LOSE (NOTHING AND A SUP)"
540 IF X = 0 AND Y = 0 THEN PRINT "ABSOLUTELY STUFFED, NOTHING AT ALL"
540 IF X = 0 AND Y = 0 THEN PRINT "ABSOLUTELY STUFFED, NOTHING AT ALL"
550 IF X = 1 AND Y = 0 THEN PRINT "SUCK EGGS YOU LOSE (1 NUMBER)"
560 IF X = 1 AND Y = 1 THEN PRINT "SUCK EGGS YOU LOSE (1 AND A SUP)"
570 IF X = 2 AND Y = 0 THEN PRINT "SUCK EGGS YOU LOSE (2 NUMBERS)"
580 IF X = 3 AND Y = 1 THEN PRINT "**********WINNER********** (3 AND A SUP)"
590 IF X = 4 THEN PRINT "****************WINNER**************** (4 NUMBERS)"
600 IF X = 5 THEN PRINT "*************** WINNER *************** (5 NUMBERS)"
610 IF X = 6 THEN PRINT "##6##6##6##6## YOUR RICH YOU LUCKY BOYS! ##6##6##6##6##"
620 IF I = 4 OR I = 8 THEN PRINT : PRINT : PRINT : INPUT "PRESS ENTER TO CONTINUE"; Q: CLS
630 IF I = 12 THEN PRINT : PRINT : PRINT "PRESS ENTER TO CHECK ANOTHER SET OF RESULTS": PRINT "PRESS R TO RETURN TO BASIC": PRINT "OR PRESS X TO EXIT TO DOS"; R$: GOTO 635
631 GOTO 660
635 R$ = INKEY$
636 IF R$ = "R" THEN STOP
637 IF R$ = "r" THEN STOP
638 IF R$ = CHR$(13) THEN 670
640 IF R$ = "X" THEN SYSTEM
650 IF R$ = "x" THEN SYSTEM
655 GOTO 635
660 NEXT I
670 RESTORE: GOTO 100
675 PRINT "YOU'VE ALREADY ENTERED THET NUMBER STUPID !!!": RETURN
680 DATA 17,21,23,35,36,38,8,9,22,23,26,34,2,4,11,20,29,39,3,5,14,16,24,28
690 DATA 18,27,31,34,36,38,15,17,20,22,24,40,2,15,18,24,33,38,4,17,20,28,32,39
700 DATA 2,12,16,25,34,39,11,16,27,28,35,39,1,15,19,24,25,31,10,14,18,23,28,40
