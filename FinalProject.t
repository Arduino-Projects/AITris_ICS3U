%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Programmer(s):  Araad Shams
% Program Name :  Tetris
% Description  :  Fill rows to clear lines!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% GLOBAL VARIABLES %%%%%

% 1 O
% 2 I
% 3 Z
% 4 S
% 5 T
% 6 L
% 7 J

var holding : boolean := false
var curRotation : int := 1
var lastMoveTimeL : int := 0
var lastMoveTimeR : int := 0
var off : int := 0
var timer : int := 0
var collisionCounter := 0
var level : int := 1
var paused : boolean := true
var prevLevel : int := 1
var speed : int := 450
var usrInput : array char of boolean
var curPiece : int
var over : boolean := false
var curColor : int
var nextPiece : int := Rand.Int (1, 7)
var pointsArrayX : array 1 .. 10 of int := init (60, 90, 120, 150, 180, 210, 240, 270, 300, 330)
var pointsArrayY : array 1 .. 20 of int := init (60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600, 630)
var curPieceX : array 1 .. 4 of int
var curPieceY : array 1 .. 4 of int
var curVirPieceX : array 1 .. 4 of int
var curVirPieceY : array 1 .. 4 of int
var curVirRotation : int := 1
var pieceMade : array 1 .. 7 of boolean := init (false, false, false, false, false, false, false)
var linesCleared : int := 0
var nextPointsArrayX : array 1 .. 4 of int := init (430, 460, 490, 520)
var nextPointsArrayY : array 1 .. 4 of int := init (310, 340, 370, 400)
var holdPointsArrayX : array 1 .. 4 of int := init (430, 460, 490, 520)
var holdPointsArrayY : array 1 .. 4 of int := init (120, 150, 180, 210)
var holdPiece : int := 0
var comPlaying : boolean := false
var started : boolean := false
var heights : array 1 .. 10 of int := init (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var endless : boolean := false
var score : int := 0
var prevScore : int := 0
var soundOn : boolean := true
var stream : boolean := false

var bestPossibleMoveX : int := 0
var bestPossibleMoveR : int := 0
var virHold : boolean := false
var virPrevHold : boolean := false

var holeCount : array - 5 .. 5 of array 0 .. 3 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )

var linesClearedCount : array - 5 .. 5 of array 0 .. 3 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )

var bumpiness : array - 5 .. 5 of array 0 .. 3 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )

var totalHeight : array - 5 .. 5 of array 0 .. 3 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )



var piecesFilled : array 1 .. 10 of array 1 .. 20 of int := init (
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8)
    )
var virPiecesFilled : array 1 .. 10 of array 1 .. 20 of int := init (
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
    init (8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8)
    )

var nextPiecesFilled : array 1 .. 4 of array 1 .. 4 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )

var holdPiecesFilled : array 1 .. 4 of array 1 .. 4 of int := init (
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0),
    init (0, 0, 0, 0)
    )


var fontTitle : int
var fontFeatures : int
var fontMain : int
var streamWrite : int
var highScoreFileRead : int
var highScoreFileWrite : int




fontTitle := Font.New ("mono:25:Bold")
fontFeatures := Font.New ("mono:18:Bold")
fontMain := Font.New ("mono:40:Bold")
open : streamWrite, "Text Files/TetrisGameLogFile.txt", put

open : highScoreFileRead, "Text Files/TetrisHighScores.txt", get
var j : string := "0"
if not eof (highScoreFileRead) then
    get : highScoreFileRead, j
end if
var highScoresPlayerScore : int := strint (j)
j := "1"
if not eof (highScoreFileRead) then
    get : highScoreFileRead, j
end if
var highScoresPlayerLevel : int := strint (j)
j := "0"
if not eof (highScoreFileRead) then
    get : highScoreFileRead, j
end if
var highScoresAIScore : int := strint (j)
j := "1"
if not eof (highScoreFileRead) then
    get : highScoreFileRead, j
end if
var highScoresAILevel : int := strint (j)
close : highScoreFileRead

%open : highScoreFileWrite, "Text Files/TetrisHighScores.txt", put

%%%%% SUBPROGRAMS %%%%%

proc fillBlock (x : int, y : int)

    Draw.FillBox (pointsArrayX (x) - 14, pointsArrayY (y) - 14, pointsArrayX (x) + 14, pointsArrayY (y) + 14, piecesFilled (x) (y))

end fillBlock

proc fillNextBlock (x : int, y : int)

    Draw.FillBox (nextPointsArrayX (x) - 14, nextPointsArrayY (y) - 14, nextPointsArrayX (x) + 14, nextPointsArrayY (y) + 14, nextPiecesFilled (x) (y))

end fillNextBlock



proc fillHoldBlock (x : int, y : int)

    Draw.FillBox (holdPointsArrayX (x) - 14, holdPointsArrayY (y) - 14, holdPointsArrayX (x) + 14, holdPointsArrayY (y) + 14, holdPiecesFilled (x) (y))

end fillHoldBlock


proc eraseNextPiece ()
    for x : 1 .. 4
	for y : 1 .. 4
	    nextPiecesFilled (x) (y) := white
	end for
    end for
end eraseNextPiece



proc eraseHoldPiece ()
    for x : 1 .. 4
	for y : 1 .. 4
	    holdPiecesFilled (x) (y) := white
	end for
    end for
end eraseHoldPiece



proc updateNextPiece ()
    eraseNextPiece ()
    if nextPiece = 1 then
	nextPiecesFilled (2) (2) := yellow
	nextPiecesFilled (2) (3) := yellow
	nextPiecesFilled (3) (2) := yellow
	nextPiecesFilled (3) (3) := yellow

    elsif nextPiece = 2 then
	nextPiecesFilled (1) (3) := brightblue
	nextPiecesFilled (2) (3) := brightblue
	nextPiecesFilled (3) (3) := brightblue
	nextPiecesFilled (4) (3) := brightblue

    elsif nextPiece = 3 then
	nextPiecesFilled (1) (3) := red
	nextPiecesFilled (2) (3) := red
	nextPiecesFilled (2) (2) := red
	nextPiecesFilled (3) (2) := red

    elsif nextPiece = 4 then
	nextPiecesFilled (1) (2) := green
	nextPiecesFilled (2) (2) := green
	nextPiecesFilled (2) (3) := green
	nextPiecesFilled (3) (3) := green

    elsif nextPiece = 5 then
	nextPiecesFilled (1) (2) := purple
	nextPiecesFilled (2) (2) := purple
	nextPiecesFilled (3) (2) := purple
	nextPiecesFilled (2) (3) := purple

    elsif nextPiece = 6 then
	nextPiecesFilled (1) (2) := brightred
	nextPiecesFilled (2) (2) := brightred
	nextPiecesFilled (3) (2) := brightred
	nextPiecesFilled (3) (3) := brightred

    elsif nextPiece = 7 then
	nextPiecesFilled (1) (3) := blue
	nextPiecesFilled (1) (2) := blue
	nextPiecesFilled (2) (2) := blue
	nextPiecesFilled (3) (2) := blue

    end if

    for x : 1 .. 4
	for y : 1 .. 4
	    fillNextBlock (x, y)
	end for
    end for

end updateNextPiece


proc updateHoldPiece ()
    eraseHoldPiece ()
    if holdPiece = 1 then
	holdPiecesFilled (2) (2) := yellow
	holdPiecesFilled (2) (3) := yellow
	holdPiecesFilled (3) (2) := yellow
	holdPiecesFilled (3) (3) := yellow

    elsif holdPiece = 2 then
	holdPiecesFilled (1) (3) := brightblue
	holdPiecesFilled (2) (3) := brightblue
	holdPiecesFilled (3) (3) := brightblue
	holdPiecesFilled (4) (3) := brightblue

    elsif holdPiece = 3 then
	holdPiecesFilled (1) (3) := red
	holdPiecesFilled (2) (3) := red
	holdPiecesFilled (2) (2) := red
	holdPiecesFilled (3) (2) := red

    elsif holdPiece = 4 then
	holdPiecesFilled (1) (2) := green
	holdPiecesFilled (2) (2) := green
	holdPiecesFilled (2) (3) := green
	holdPiecesFilled (3) (3) := green

    elsif holdPiece = 5 then
	holdPiecesFilled (1) (2) := purple
	holdPiecesFilled (2) (2) := purple
	holdPiecesFilled (3) (2) := purple
	holdPiecesFilled (2) (3) := purple

    elsif holdPiece = 6 then
	holdPiecesFilled (1) (2) := brightred
	holdPiecesFilled (2) (2) := brightred
	holdPiecesFilled (3) (2) := brightred
	holdPiecesFilled (3) (3) := brightred

    elsif holdPiece = 7 then
	holdPiecesFilled (1) (3) := blue
	holdPiecesFilled (1) (2) := blue
	holdPiecesFilled (2) (2) := blue
	holdPiecesFilled (3) (2) := blue

    end if

    for x : 1 .. 4
	for y : 1 .. 4
	    fillHoldBlock (x, y)
	end for
    end for

end updateHoldPiece



proc updateBoard ()

    for x : 1 .. 10
	for y : 1 .. 20
	    fillBlock (x, y)
	end for
    end for

end updateBoard


proc showLevel ()
    if not endless then
	Draw.Text ("Score", 428, 615, fontTitle, white)
	Draw.Text ("Level", 428, 615, fontTitle, brightblue)
	Draw.Text (intstr (prevLevel), 465, 535, fontTitle, 0)
	Draw.Text (intstr (level), 465, 535, fontTitle, 1)
	prevLevel := level
    else
	Draw.Text ("Level", 428, 615, fontTitle, white)
	Draw.Text ("Score", 428, 615, fontTitle, brightblue)
	Draw.Text (intstr (prevScore), 465, 535, fontTitle, 0)
	Draw.Text (intstr (score), 465, 535, fontTitle, 1)
	prevScore := score
    end if
end showLevel


proc updateIndicators ()

    if comPlaying then
	Draw.FillOval (605, 456, 5, 5, green)
    else
	Draw.FillOval (605, 456, 5, 5, red)
    end if

    if endless then
	Draw.FillOval (605, 426, 5, 5, green)
	Draw.FillOval (605, 396, 5, 5, red)
    else
	Draw.FillOval (605, 426, 5, 5, red)
	Draw.FillOval (605, 396, 5, 5, green)
    end if

    if soundOn then
	Draw.FillOval (605, 366, 5, 5, green)
    else
	Draw.FillOval (605, 366, 5, 5, red)
    end if


    if stream then
	Draw.FillOval (605, 336, 5, 5, green)
    else
	Draw.FillOval (605, 336, 5, 5, red)
    end if

end updateIndicators


proc drawBoard ()

    updateBoard ()
    for x : 1 .. 4
	for y : 1 .. 4
	    fillNextBlock (x, y)
	end for
    end for

    for x : 1 .. 4
	for y : 1 .. 4
	    fillHoldBlock (x, y)
	end for
    end for


    for i : 1 .. 10
	Draw.Box (45 - i, 45 - i, 345 + i, 645 + i, black)
	if i < 5 then
	    Draw.Box (400 - i, 470 - i, 550 + i, 620 + i, green)
	    Draw.Box (400 - i, 280 - i, 550 + i, 430 + i, blue)
	    Draw.Box (400 - i, 90 - i, 550 + i, 240 + i, grey)
	end if
    end for
    Draw.Text ("TETRIS!", 127, 659, fontTitle, brightblue)
    Draw.FillBox (428, 620, 525, 625, 0)
    Draw.Text ("Level", 428, 615, fontTitle, brightblue)
    Draw.FillBox (432, 430, 522, 435, 0)
    Draw.Text ("Next", 437, 425, fontTitle, brightblue)
    Draw.FillBox (432, 240, 522, 245, 0)
    Draw.Text ("Hold", 437, 235, fontTitle, brightblue)
    showLevel ()


    Draw.Text ("High Scores", 640, 650, fontTitle, black)
    Draw.Text ("Player Endless  -  " + intstr (highScoresPlayerScore), 610, 600, fontFeatures, black)
    Draw.Text ("Player Survival -  " + intstr (highScoresPlayerLevel), 610, 570, fontFeatures, black)
    Draw.Text ("AI Endless      -  " + intstr (highScoresAIScore), 610, 540, fontFeatures, black)
    Draw.Text ("AI Survival     -  " + intstr (highScoresAILevel), 610, 510, fontFeatures, black)
    Draw.Text ("Araad Shams", 690,267,fontTitle, red)

    Draw.Line (600, 485, 980, 485, black)
    Draw.Text ("AI", 620, 450, fontFeatures, black)
    Draw.Text ("Endless", 620, 420, fontFeatures, black)
    Draw.Text ("Survival", 620, 390, fontFeatures, black)
    Draw.Text ("Sound", 620, 360, fontFeatures, black)
    Draw.Text ("Logging", 620, 330, fontFeatures, black)
    updateIndicators ()
end drawBoard








proc drawCurPiece ()

    for i : 1 .. 4
	piecesFilled (curPieceX (i)) (curPieceY (i)) := curColor
    end for
    updateBoard ()
end drawCurPiece

proc drawCurVirPiece ()

    for i : 1 .. 4
	virPiecesFilled (curVirPieceX (i)) (curVirPieceY (i)) := curColor
    end for

end drawCurVirPiece


proc eraseCurPiece ()

    for i : 1 .. 4
	piecesFilled (curPieceX (i)) (curPieceY (i)) := grey
    end for
    updateBoard ()

end eraseCurPiece


proc eraseCurVirPiece ()

    for i : 1 .. 4
	virPiecesFilled (curVirPieceX (i)) (curVirPieceY (i)) := grey
    end for

end eraseCurVirPiece


proc gameOver ()
    Draw.Text ("Game Over!", 620, 150, fontMain, black)
    if soundOn then
	Music.PlayFileStop ()

	Music.PlayFileReturn ("Audio/GameOver.mp3")

    end if
    for decreasing y : 20 .. 1
	for x : 1 .. 10
	    piecesFilled (x) (y) := black
	    fillBlock (x, y)
	end for
	delay (100)
	if y = 15 then
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	end if
	if y = 10 then
	    Draw.Text ("Game Over!", 620, 150, fontMain, black)
	end if
	if y = 5 then
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	end if
	if y = 1 then
	    Draw.Text ("Game Over!", 620, 150, fontMain, black)
	end if
    end for
    if soundOn then
	Music.SoundOff ()
    end if
    if endless and not comPlaying then
	if highScoresPlayerScore < score then
	    Draw.Text ("Player Endless  -  " + intstr (highScoresPlayerScore), 610, 600, fontFeatures, white)
	    highScoresPlayerScore := score
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif endless and comPlaying then
	if highScoresAIScore < score then
	    Draw.Text ("AI Endless      -  " + intstr (highScoresAIScore), 610, 540, fontFeatures, white)
	    highScoresAIScore := score
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif not endless and not comPlaying then
	if highScoresPlayerLevel < level then
	    Draw.Text ("Player Survival -  " + intstr (highScoresPlayerLevel), 610, 570, fontFeatures, white)
	    highScoresPlayerLevel := level
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif not endless and comPlaying then
	if highScoresAILevel < level then
	    Draw.Text ("AI Survival     -  " + intstr (highScoresAILevel), 610, 510, fontFeatures, white)
	    highScoresAILevel := level
	    Draw.Text ("Game Over!", 620, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    end if
    open : highScoreFileWrite, "Text Files/TetrisHighScores.txt", put
    put : highScoreFileWrite, intstr (highScoresPlayerScore)
    put : highScoreFileWrite, intstr (highScoresPlayerLevel)
    put : highScoreFileWrite, intstr (highScoresAIScore)
    put : highScoreFileWrite, intstr (highScoresAILevel)
    close : highScoreFileWrite
    Draw.Text ("Player Endless  -  " + intstr (highScoresPlayerScore), 610, 600, fontFeatures, black)
    Draw.Text ("Player Survival -  " + intstr (highScoresPlayerLevel), 610, 570, fontFeatures, black)
    Draw.Text ("AI Endless      -  " + intstr (highScoresAIScore), 610, 540, fontFeatures, black)
    Draw.Text ("AI Survival     -  " + intstr (highScoresAILevel), 610, 510, fontFeatures, black)

    over := true
    loop
	Input.KeyDown (usrInput)

	if usrInput ('q') then
	    exit
	end if


    end loop
end gameOver




function piecesCollide () : boolean
    if curPieceY (1) > 20 or curPieceY (2) > 20 or curPieceY (3) > 20 or curPieceY (4) > 20 then
	curPieceY (1) -= 1
	curPieceY (2) -= 1
	curPieceY (3) -= 1
	curPieceY (4) -= 1
    end if

    if curPieceY (1) > 20 or curPieceY (2) > 20 or curPieceY (3) > 20 or curPieceY (4) > 20 then
	curPieceY (1) -= 1
	curPieceY (2) -= 1
	curPieceY (3) -= 1
	curPieceY (4) -= 1
    end if

    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if



    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if


    if curPieceY (1) < 1 or curPieceY (2) < 1 or curPieceY (3) < 1 or curPieceY (4) < 1 then
	result true
    else
	if piecesFilled (curPieceX (1)) (curPieceY (1)) = gray and piecesFilled (curPieceX (2)) (curPieceY (2)) = gray and piecesFilled (curPieceX (3)) (curPieceY (3)) = gray and
		piecesFilled (curPieceX (4)) (curPieceY (4)) = gray then
	    result false
	else
	    result true
	end if
    end if
end piecesCollide



function virPiecesCollide () : boolean
    if curVirPieceY (1) > 20 or curVirPieceY (2) > 20 or curVirPieceY (3) > 20 or curVirPieceY (4) > 20 then
	curVirPieceY (1) -= 1
	curVirPieceY (2) -= 1
	curVirPieceY (3) -= 1
	curVirPieceY (4) -= 1
    end if

    if curVirPieceY (1) > 20 or curVirPieceY (2) > 20 or curVirPieceY (3) > 20 or curVirPieceY (4) > 20 then
	curVirPieceY (1) -= 1
	curVirPieceY (2) -= 1
	curVirPieceY (3) -= 1
	curVirPieceY (4) -= 1
    end if

    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if



    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if


    if curVirPieceY (1) < 1 or curVirPieceY (2) < 1 or curVirPieceY (3) < 1 or curVirPieceY (4) < 1 then
	result true
    else
	if virPiecesFilled (curVirPieceX (1)) (curVirPieceY (1)) = gray and virPiecesFilled (curVirPieceX (2)) (curVirPieceY (2)) = gray and virPiecesFilled (curVirPieceX (3)) (curVirPieceY (3)) =
		gray
		and
		virPiecesFilled (curVirPieceX (4)) (curVirPieceY (4)) = gray then
	    result false
	else
	    result true
	end if
    end if
end virPiecesCollide





proc spawnPiece ()

    holding := false
    curRotation := 1

    var check : boolean := true
    curPiece := nextPiece
    for i : 1 .. 7
	if pieceMade (i) = false then
	    check := false
	end if
    end for

    if check then
	for i : 1 .. 7
	    pieceMade (i) := false
	end for
    end if

    loop
	nextPiece := Rand.Int (1, 7)
	exit when not pieceMade (nextPiece)
    end loop
    updateNextPiece ()
    pieceMade (nextPiece) := true



    if curPiece = 1 then
	curPieceX (1) := 5
	curPieceY (1) := 20
	curPieceX (2) := 6
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := yellow

    elsif curPiece = 2 then
	curPieceX (1) := 4
	curPieceY (1) := 19
	curPieceX (2) := 5
	curPieceY (2) := 19
	curPieceX (3) := 6
	curPieceY (3) := 19
	curPieceX (4) := 7
	curPieceY (4) := 19
	curColor := brightblue

    elsif curPiece = 3 then
	curPieceX (1) := 4
	curPieceY (1) := 20
	curPieceX (2) := 5
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := red

    elsif curPiece = 4 then
	curPieceX (1) := 6
	curPieceY (1) := 20
	curPieceX (2) := 5
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 4
	curPieceY (4) := 19
	curColor := green

    elsif curPiece = 5 then
	curPieceX (1) := 4
	curPieceY (1) := 19
	curPieceX (2) := 5
	curPieceY (2) := 19
	curPieceX (3) := 6
	curPieceY (3) := 19
	curPieceX (4) := 5
	curPieceY (4) := 20
	curColor := purple

    elsif curPiece = 6 then
	curPieceX (1) := 6
	curPieceY (1) := 20
	curPieceX (2) := 6
	curPieceY (2) := 19
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 4
	curPieceY (4) := 19
	curColor := brightred

    elsif curPiece = 7 then
	curPieceX (1) := 4
	curPieceY (1) := 20
	curPieceX (2) := 4
	curPieceY (2) := 19
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := blue

    end if

    if piecesCollide () then
	paused := true
	drawCurPiece ()
	delay (500)
	gameOver ()
    else
	drawCurPiece ()
    end if


end spawnPiece





proc movePieceLeft ()




    if curPieceX (1) = 1 or curPieceX (2) = 1 or curPieceX (3) = 1 or curPieceX (4) = 1 then

    else
	eraseCurPiece ()
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1

	if piecesCollide () then
	    curPieceX (1) += 1
	    curPieceX (2) += 1
	    curPieceX (3) += 1
	    curPieceX (4) += 1
	end if
	drawCurPiece ()
    end if



end movePieceLeft


proc moveVirPieceLeft ()




    if curVirPieceX (1) = 1 or curVirPieceX (2) = 1 or curVirPieceX (3) = 1 or curVirPieceX (4) = 1 then

    else
	eraseCurVirPiece ()
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1

	if virPiecesCollide () then
	    curVirPieceX (1) += 1
	    curVirPieceX (2) += 1
	    curVirPieceX (3) += 1
	    curVirPieceX (4) += 1
	end if
	drawCurVirPiece ()
    end if



end moveVirPieceLeft



proc movePieceRight ()




    if curPieceX (1) = 10 or curPieceX (2) >= 10 or curPieceX (3) = 10 or curPieceX (4) = 10 then

    else
	eraseCurPiece ()
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
	if piecesCollide () then
	    curPieceX (1) -= 1
	    curPieceX (2) -= 1
	    curPieceX (3) -= 1
	    curPieceX (4) -= 1
	end if
	drawCurPiece ()
    end if


end movePieceRight


proc moveVirPieceRight ()



    if curVirPieceX (1) = 10 or curVirPieceX (2) >= 10 or curVirPieceX (3) = 10 or curVirPieceX (4) = 10 then

    else
	eraseCurVirPiece ()
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
	if virPiecesCollide () then
	    curVirPieceX (1) -= 1
	    curVirPieceX (2) -= 1
	    curVirPieceX (3) -= 1
	    curVirPieceX (4) -= 1
	end if
	drawCurVirPiece ()
    end if


end moveVirPieceRight


proc rotatePiece ()
    eraseCurPiece ()

    if curPiece = 1 then

    elsif curPiece = 2 then

	if curRotation = 1 then
	    curPieceX (1) += 2
	    curPieceY (1) += 1
	    curPieceX (2) += 1
	    curPieceY (2) += 0
	    curPieceX (3) += 0
	    curPieceY (3) += -1
	    curPieceX (4) += -1
	    curPieceY (4) += -2
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 2
		curPieceY (1) -= 1
		curPieceX (2) -= 1
		curPieceY (2) -= 0
		curPieceX (3) -= 0
		curPieceY (3) -= -1
		curPieceX (4) -= -1
		curPieceY (4) -= -2
	    end if
	elsif curRotation = 2 then
	    curPieceX (1) += 1
	    curPieceY (1) += -2
	    curPieceX (2) += 0
	    curPieceY (2) += -1
	    curPieceX (3) += -1
	    curPieceY (3) += 0
	    curPieceX (4) += -2
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 1
		curPieceY (1) -= -2
		curPieceX (2) -= 0
		curPieceY (2) -= -1
		curPieceX (3) -= -1
		curPieceY (3) -= 0
		curPieceX (4) -= -2
		curPieceY (4) -= 1
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += -2
	    curPieceY (1) += -1
	    curPieceX (2) += -1
	    curPieceY (2) += 0
	    curPieceX (3) += 0
	    curPieceY (3) += 1
	    curPieceX (4) += 1
	    curPieceY (4) += 2
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -2
		curPieceY (1) -= -1
		curPieceX (2) -= -1
		curPieceY (2) -= 0
		curPieceX (3) -= 0
		curPieceY (3) -= 1
		curPieceX (4) -= 1
		curPieceY (4) -= 2
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += -1
	    curPieceY (1) += 2
	    curPieceX (2) += 0
	    curPieceY (2) += 1
	    curPieceX (3) += 1
	    curPieceY (3) += 0
	    curPieceX (4) += 2
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -1
		curPieceY (1) -= 2
		curPieceX (2) -= 0
		curPieceY (2) -= 1
		curPieceX (3) -= 1
		curPieceY (3) -= 0
		curPieceX (4) -= 2
		curPieceY (4) -= -1
	    end if
	end if

    elsif curPiece = 3 then

	if curRotation = 1 then
	    curPieceX (1) += 2
	    curPieceY (1) += 0
	    curPieceX (2) += 1
	    curPieceY (2) += -1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 2
		curPieceY (1) -= 0
		curPieceX (2) -= 1
		curPieceY (2) -= -1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 2 then
	    curPieceX (1) += -2
	    curPieceY (1) += -1
	    curPieceX (2) += -1
	    curPieceY (2) += 0
	    curPieceX (3) += 0
	    curPieceY (3) += -1
	    curPieceX (4) += 1
	    curPieceY (4) += 0
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -2
		curPieceY (1) -= -1
		curPieceX (2) -= -1
		curPieceY (2) -= 0
		curPieceX (3) -= 0
		curPieceY (3) -= -1
		curPieceX (4) -= 1
		curPieceY (4) -= 0
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += 1
	    curPieceY (1) += 1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += -1
	    curPieceY (3) += 1
	    curPieceX (4) += -2
	    curPieceY (4) += 0
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 1
		curPieceY (1) -= 1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= -1
		curPieceY (3) -= 1
		curPieceX (4) -= -2
		curPieceY (4) -= 0
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += -1
	    curPieceY (1) += 0
	    curPieceX (2) += 0
	    curPieceY (2) += 1
	    curPieceX (3) += 1
	    curPieceY (3) += 0
	    curPieceX (4) += 2
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -1
		curPieceY (1) -= 0
		curPieceX (2) -= 0
		curPieceY (2) -= 1
		curPieceX (3) -= 1
		curPieceY (3) -= 0
		curPieceX (4) -= 2
		curPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 4 then

	if curRotation = 1 then
	    curPieceX (1) += -1
	    curPieceY (1) += 0
	    curPieceX (2) += 0
	    curPieceY (2) += -1
	    curPieceX (3) += 1
	    curPieceY (3) += 0
	    curPieceX (4) += 2
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -1
		curPieceY (1) -= 0
		curPieceX (2) -= 0
		curPieceY (2) -= -1
		curPieceX (3) -= 1
		curPieceY (3) -= 0
		curPieceX (4) -= 2
		curPieceY (4) -= -1
	    end if

	elsif curRotation = 2 then
	    curPieceX (1) += 1
	    curPieceY (1) += -1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += -1
	    curPieceY (3) += -1
	    curPieceX (4) += -2
	    curPieceY (4) += 0
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 1
		curPieceY (1) -= -1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= -1
		curPieceY (3) -= -1
		curPieceX (4) -= -2
		curPieceY (4) -= 0
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += -2
	    curPieceY (1) += 1
	    curPieceX (2) += -1
	    curPieceY (2) += 0
	    curPieceX (3) += 0
	    curPieceY (3) += 1
	    curPieceX (4) += 1
	    curPieceY (4) += 0
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -2
		curPieceY (1) -= 1
		curPieceX (2) -= -1
		curPieceY (2) -= 0
		curPieceX (3) -= 0
		curPieceY (3) -= 1
		curPieceX (4) -= 1
		curPieceY (4) -= 0
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += 2
	    curPieceY (1) += 0
	    curPieceX (2) += 1
	    curPieceY (2) += 1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 2
		curPieceY (1) -= 0
		curPieceX (2) -= 1
		curPieceY (2) -= 1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 5 then

	if curRotation = 1 then
	    curPieceX (1) += 1
	    curPieceY (1) += 1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += -1
	    curPieceY (3) += -1
	    curPieceX (4) += 1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 1
		curPieceY (1) -= 1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= -1
		curPieceY (3) -= -1
		curPieceX (4) -= 1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 2 then
	    curPieceX (1) += 1
	    curPieceY (1) += -1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += -1
	    curPieceY (3) += 1
	    curPieceX (4) += -1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 1
		curPieceY (1) -= -1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= -1
		curPieceY (3) -= 1
		curPieceX (4) -= -1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += -1
	    curPieceY (1) += -1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += 1
	    curPieceY (3) += 1
	    curPieceX (4) += -1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -1
		curPieceY (1) -= -1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= 1
		curPieceY (3) -= 1
		curPieceX (4) -= -1
		curPieceY (4) -= 1
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += -1
	    curPieceY (1) += 1
	    curPieceX (2) += 0
	    curPieceY (2) += 0
	    curPieceX (3) += 1
	    curPieceY (3) += -1
	    curPieceX (4) += 1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -1
		curPieceY (1) -= 1
		curPieceX (2) -= 0
		curPieceY (2) -= 0
		curPieceX (3) -= 1
		curPieceY (3) -= -1
		curPieceX (4) -= 1
		curPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 6 then

	if curRotation = 1 then
	    curPieceX (1) += 0
	    curPieceY (1) += -2
	    curPieceX (2) += -1
	    curPieceY (2) += -1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += 1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 0
		curPieceY (1) -= -2
		curPieceX (2) -= -1
		curPieceY (2) -= -1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= 1
		curPieceY (4) -= 1
	    end if
	elsif curRotation = 2 then
	    curPieceX (1) += -2
	    curPieceY (1) += 0
	    curPieceX (2) += -1
	    curPieceY (2) += 1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += 1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -2
		curPieceY (1) -= 0
		curPieceX (2) -= -1
		curPieceY (2) -= 1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= 1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += 0
	    curPieceY (1) += 2
	    curPieceX (2) += 1
	    curPieceY (2) += 1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 0
		curPieceY (1) -= 2
		curPieceX (2) -= 1
		curPieceY (2) -= 1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += 2
	    curPieceY (1) += 0
	    curPieceX (2) += 1
	    curPieceY (2) += -1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 2
		curPieceY (1) -= 0
		curPieceX (2) -= 1
		curPieceY (2) -= -1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 7 then

	if curRotation = 1 then
	    curPieceX (1) += 2
	    curPieceY (1) += 0
	    curPieceX (2) += 1
	    curPieceY (2) += 1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 2
		curPieceY (1) -= 0
		curPieceX (2) -= 1
		curPieceY (2) -= 1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= -1
	    end if
	elsif curRotation = 2 then
	    curPieceX (1) += 0
	    curPieceY (1) += -2
	    curPieceX (2) += 1
	    curPieceY (2) += -1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += -1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 0
		curPieceY (1) -= -2
		curPieceX (2) -= 1
		curPieceY (2) -= -1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= -1
		curPieceY (4) -= 1
	    end if
	elsif curRotation = 3 then
	    curPieceX (1) += -2
	    curPieceY (1) += 0
	    curPieceX (2) += -1
	    curPieceY (2) += -1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += 1
	    curPieceY (4) += 1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= -2
		curPieceY (1) -= 0
		curPieceX (2) -= -1
		curPieceY (2) -= -1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= 1
		curPieceY (4) -= 1
	    end if
	elsif curRotation = 4 then
	    curPieceX (1) += 0
	    curPieceY (1) += 2
	    curPieceX (2) += -1
	    curPieceY (2) += 1
	    curPieceX (3) += 0
	    curPieceY (3) += 0
	    curPieceX (4) += 1
	    curPieceY (4) += -1
	    if piecesCollide () then
		curRotation -= 1
		curPieceX (1) -= 0
		curPieceY (1) -= 2
		curPieceX (2) -= -1
		curPieceY (2) -= 1
		curPieceX (3) -= 0
		curPieceY (3) -= 0
		curPieceX (4) -= 1
		curPieceY (4) -= -1
	    end if
	end if

    end if

    curRotation += 1
    if curRotation = 5 then
	curRotation := 1
    end if
    if curPieceY (1) > 20 or curPieceY (2) > 20 or curPieceY (3) > 20 or curPieceY (4) > 20 then
	curPieceY (1) -= 1
	curPieceY (2) -= 1
	curPieceY (3) -= 1
	curPieceY (4) -= 1
    end if

    if curPieceY (1) > 20 or curPieceY (2) > 20 or curPieceY (3) > 20 or curPieceY (4) > 20 then
	curPieceY (1) -= 1
	curPieceY (2) -= 1
	curPieceY (3) -= 1
	curPieceY (4) -= 1
    end if

    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if
    if curPieceX (1) < 1 or curPieceX (2) < 1 or curPieceX (3) < 1 or curPieceX (4) < 1 then
	curPieceX (1) += 1
	curPieceX (2) += 1
	curPieceX (3) += 1
	curPieceX (4) += 1
    end if



    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if
    if curPieceX (1) > 10 or curPieceX (2) > 10 or curPieceX (3) > 10 or curPieceX (4) > 10 then
	curPieceX (1) -= 1
	curPieceX (2) -= 1
	curPieceX (3) -= 1
	curPieceX (4) -= 1
    end if




    drawCurPiece ()
end rotatePiece


proc rotateVirPiece ()
    eraseCurVirPiece ()

    if curPiece = 1 then

    elsif curPiece = 2 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += 2
	    curVirPieceY (1) += 1
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += -1
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += -2
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 2
		curVirPieceY (1) -= 1
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= -1
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= -2
	    end if
	elsif curVirRotation = 2 then
	    curVirPieceX (1) += 1
	    curVirPieceY (1) += -2
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += -1
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -2
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 1
		curVirPieceY (1) -= -2
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= -1
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -2
		curVirPieceY (4) -= 1
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += -2
	    curVirPieceY (1) += -1
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 1
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 2
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -2
		curVirPieceY (1) -= -1
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 1
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 2
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += -1
	    curVirPieceY (1) += 2
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 1
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 2
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -1
		curVirPieceY (1) -= 2
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 1
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 2
		curVirPieceY (4) -= -1
	    end if
	end if

    elsif curPiece = 3 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += 2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 2 then
	    curVirPieceX (1) += -2
	    curVirPieceY (1) += -1
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += -1
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 0
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -2
		curVirPieceY (1) -= -1
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= -1
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 0
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += 1
	    curVirPieceY (1) += 1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += -1
	    curVirPieceY (3) += 1
	    curVirPieceX (4) += -2
	    curVirPieceY (4) += 0
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 1
		curVirPieceY (1) -= 1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= -1
		curVirPieceY (3) -= 1
		curVirPieceX (4) -= -2
		curVirPieceY (4) -= 0
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += -1
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 1
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 2
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -1
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 1
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 2
		curVirPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 4 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += -1
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 1
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 2
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -1
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 1
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 2
		curVirPieceY (4) -= -1
	    end if

	elsif curVirRotation = 2 then
	    curVirPieceX (1) += 1
	    curVirPieceY (1) += -1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += -1
	    curVirPieceY (3) += -1
	    curVirPieceX (4) += -2
	    curVirPieceY (4) += 0
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 1
		curVirPieceY (1) -= -1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= -1
		curVirPieceY (3) -= -1
		curVirPieceX (4) -= -2
		curVirPieceY (4) -= 0
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += -2
	    curVirPieceY (1) += 1
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 1
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 0
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -2
		curVirPieceY (1) -= 1
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 1
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 0
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += 2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 5 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += 1
	    curVirPieceY (1) += 1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += -1
	    curVirPieceY (3) += -1
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 1
		curVirPieceY (1) -= 1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= -1
		curVirPieceY (3) -= -1
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 2 then
	    curVirPieceX (1) += 1
	    curVirPieceY (1) += -1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += -1
	    curVirPieceY (3) += 1
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 1
		curVirPieceY (1) -= -1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= -1
		curVirPieceY (3) -= 1
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += -1
	    curVirPieceY (1) += -1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 1
	    curVirPieceY (3) += 1
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -1
		curVirPieceY (1) -= -1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 1
		curVirPieceY (3) -= 1
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= 1
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += -1
	    curVirPieceY (1) += 1
	    curVirPieceX (2) += 0
	    curVirPieceY (2) += 0
	    curVirPieceX (3) += 1
	    curVirPieceY (3) += -1
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -1
		curVirPieceY (1) -= 1
		curVirPieceX (2) -= 0
		curVirPieceY (2) -= 0
		curVirPieceX (3) -= 1
		curVirPieceY (3) -= -1
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 6 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += 0
	    curVirPieceY (1) += -2
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 0
		curVirPieceY (1) -= -2
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 1
	    end if
	elsif curVirRotation = 2 then
	    curVirPieceX (1) += -2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += 0
	    curVirPieceY (1) += 2
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 0
		curVirPieceY (1) -= 2
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += 2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= 1
	    end if
	end if

    elsif curPiece = 7 then

	if curVirRotation = 1 then
	    curVirPieceX (1) += 2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= -1
	    end if
	elsif curVirRotation = 2 then
	    curVirPieceX (1) += 0
	    curVirPieceY (1) += -2
	    curVirPieceX (2) += 1
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += -1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 0
		curVirPieceY (1) -= -2
		curVirPieceX (2) -= 1
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= -1
		curVirPieceY (4) -= 1
	    end if
	elsif curVirRotation = 3 then
	    curVirPieceX (1) += -2
	    curVirPieceY (1) += 0
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += -1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += 1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= -2
		curVirPieceY (1) -= 0
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= -1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= 1
	    end if
	elsif curVirRotation = 4 then
	    curVirPieceX (1) += 0
	    curVirPieceY (1) += 2
	    curVirPieceX (2) += -1
	    curVirPieceY (2) += 1
	    curVirPieceX (3) += 0
	    curVirPieceY (3) += 0
	    curVirPieceX (4) += 1
	    curVirPieceY (4) += -1
	    if virPiecesCollide () then
		curVirRotation -= 1
		curVirPieceX (1) -= 0
		curVirPieceY (1) -= 2
		curVirPieceX (2) -= -1
		curVirPieceY (2) -= 1
		curVirPieceX (3) -= 0
		curVirPieceY (3) -= 0
		curVirPieceX (4) -= 1
		curVirPieceY (4) -= -1
	    end if
	end if

    end if

    curVirRotation += 1
    if curVirRotation = 5 then
	curVirRotation := 1
    end if
    if curVirPieceY (1) > 20 or curVirPieceY (2) > 20 or curVirPieceY (3) > 20 or curVirPieceY (4) > 20 then
	curVirPieceY (1) -= 1
	curVirPieceY (2) -= 1
	curVirPieceY (3) -= 1
	curVirPieceY (4) -= 1
    end if

    if curVirPieceY (1) > 20 or curVirPieceY (2) > 20 or curVirPieceY (3) > 20 or curVirPieceY (4) > 20 then
	curVirPieceY (1) -= 1
	curVirPieceY (2) -= 1
	curVirPieceY (3) -= 1
	curVirPieceY (4) -= 1
    end if

    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if
    if curVirPieceX (1) < 1 or curVirPieceX (2) < 1 or curVirPieceX (3) < 1 or curVirPieceX (4) < 1 then
	curVirPieceX (1) += 1
	curVirPieceX (2) += 1
	curVirPieceX (3) += 1
	curVirPieceX (4) += 1
    end if



    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if
    if curVirPieceX (1) > 10 or curVirPieceX (2) > 10 or curVirPieceX (3) > 10 or curVirPieceX (4) > 10 then
	curVirPieceX (1) -= 1
	curVirPieceX (2) -= 1
	curVirPieceX (3) -= 1
	curVirPieceX (4) -= 1
    end if




    drawCurVirPiece ()
end rotateVirPiece

proc streamPlays ()
    for decreasing e : 20 .. 1
	put : streamWrite, piecesFilled (1) (e), piecesFilled (2) (e), piecesFilled (3) (e), piecesFilled (4) (e), piecesFilled (5) (e), piecesFilled (6) (e), piecesFilled (7) (e),
	    piecesFilled (8) (e), piecesFilled (9) (e), piecesFilled (10) (e)
    end for
    put : streamWrite, "..............."
    put : streamWrite, "HOLES: ", intstr (holeCount (bestPossibleMoveX) (bestPossibleMoveR))
    put : streamWrite, "LINES CLEARED: ", intstr (linesClearedCount (bestPossibleMoveX) (bestPossibleMoveR))
    put : streamWrite, "HEIGHT: ", realstr (totalHeight (bestPossibleMoveX) (bestPossibleMoveR) / 4, 2)
    put : streamWrite, "BUMPINESS: ", intstr (bumpiness (bestPossibleMoveX) (bestPossibleMoveR))
    put : streamWrite, " "
    put : streamWrite, " "
    put : streamWrite, "..........................................................."
end streamPlays

proc lockPiece ()
    var prevLinesCleared : int := linesCleared
    var clearRows : array 1 .. 20 of boolean := init (true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true)
    for y : 1 .. 20
	for x : 1 .. 10
	    if piecesFilled (x) (y) = gray then
		clearRows (y) := false
	    end if
	end for
    end for

    var clearAny : boolean := false
    var lineCounter : int := 0
    for i : 1 .. 20
	if clearRows (i) then
	    clearAny := true
	    lineCounter += 1
	end if
    end for

    if lineCounter = 1 then
	off := 2
	Draw.Text ("Single!", 700, 150, fontMain, black)

    elsif lineCounter = 2 then
	off := 2
	Draw.Text ("Double!", 700, 150, fontMain, black)

    elsif lineCounter = 3 then
	off := 2
	Draw.Text ("Triple!", 700, 150, fontMain, black)

    elsif lineCounter = 4 then
	off := 2
	Draw.Text ("TETRIS!", 700, 150, fontMain, black)
    end if

    if clearAny then
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 25
		end for
	    end if
	end for
	updateBoard ()
	delay (150)
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 26
		end for
	    end if
	end for
	updateBoard ()


	delay (150)
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 27
		end for
	    end if
	end for
	updateBoard ()
	delay (150)
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 28
		end for
	    end if
	end for
	updateBoard ()
	delay (150)
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 29
		end for
	    end if
	end for
	updateBoard ()
	delay (150)
	for i : 1 .. 20
	    if clearRows (i) then
		for x : 1 .. 10
		    piecesFilled (x) (i) := 30
		end for
	    end if
	end for
	updateBoard ()
	delay (150)
    end if

    for decreasing i : 20 .. 1
	if clearRows (i) then
	    linesCleared += 1
	    for l : i + 1 .. 20
		for x : 1 .. 10
		    piecesFilled (x) (l - 1) := piecesFilled (x) (l)
		end for
	    end for

	end if
    end for
    if comPlaying then
	if stream then
	    streamPlays ()
	end if
    end if
    if endless then
	score := linesCleared * 27
	showLevel ()
    end if
    updateBoard ()
    spawnPiece ()

end lockPiece





proc movePieceDown ()
    eraseCurPiece ()
    curPieceY (1) -= 1
    curPieceY (2) -= 1
    curPieceY (3) -= 1
    curPieceY (4) -= 1

    if piecesCollide () then
	curPieceY (1) += 1
	curPieceY (2) += 1
	curPieceY (3) += 1
	curPieceY (4) += 1
	if collisionCounter >= 4 then
	    drawCurPiece ()
	    lockPiece ()
	    collisionCounter := 0
	else
	    drawCurPiece ()
	    collisionCounter += 1
	end if
    else
	drawCurPiece ()
    end if

end movePieceDown

function movePieceDownS () : boolean

    curPieceY (1) -= 1
    curPieceY (2) -= 1
    curPieceY (3) -= 1
    curPieceY (4) -= 1

    if piecesCollide () then
	curPieceY (1) += 1
	curPieceY (2) += 1
	curPieceY (3) += 1
	curPieceY (4) += 1
	drawCurPiece ()
	lockPiece ()
	result true
    else
	result false
    end if

end movePieceDownS



function moveVirPieceDownS () : boolean

    curVirPieceY (1) -= 1
    curVirPieceY (2) -= 1
    curVirPieceY (3) -= 1
    curVirPieceY (4) -= 1

    if virPiecesCollide () then
	curVirPieceY (1) += 1
	curVirPieceY (2) += 1
	curVirPieceY (3) += 1
	curVirPieceY (4) += 1
	drawCurVirPiece ()
	result true
    else
	result false
    end if

end moveVirPieceDownS




proc spawnHoldPiece ()

    curRotation := 1
    if curPiece = 1 then
	curPieceX (1) := 5
	curPieceY (1) := 20
	curPieceX (2) := 6
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := yellow

    elsif curPiece = 2 then
	curPieceX (1) := 4
	curPieceY (1) := 19
	curPieceX (2) := 5
	curPieceY (2) := 19
	curPieceX (3) := 6
	curPieceY (3) := 19
	curPieceX (4) := 7
	curPieceY (4) := 19
	curColor := brightblue

    elsif curPiece = 3 then
	curPieceX (1) := 4
	curPieceY (1) := 20
	curPieceX (2) := 5
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := red

    elsif curPiece = 4 then
	curPieceX (1) := 6
	curPieceY (1) := 20
	curPieceX (2) := 5
	curPieceY (2) := 20
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 4
	curPieceY (4) := 19
	curColor := green

    elsif curPiece = 5 then
	curPieceX (1) := 4
	curPieceY (1) := 19
	curPieceX (2) := 5
	curPieceY (2) := 19
	curPieceX (3) := 6
	curPieceY (3) := 19
	curPieceX (4) := 5
	curPieceY (4) := 20
	curColor := purple

    elsif curPiece = 6 then
	curPieceX (1) := 6
	curPieceY (1) := 20
	curPieceX (2) := 6
	curPieceY (2) := 19
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 4
	curPieceY (4) := 19
	curColor := brightred

    elsif curPiece = 7 then
	curPieceX (1) := 4
	curPieceY (1) := 20
	curPieceX (2) := 4
	curPieceY (2) := 19
	curPieceX (3) := 5
	curPieceY (3) := 19
	curPieceX (4) := 6
	curPieceY (4) := 19
	curColor := blue

    end if

    if piecesCollide () then
	paused := true
	drawCurPiece ()
	delay (500)
	gameOver ()
    else
	drawCurPiece ()
    end if



end spawnHoldPiece


proc moveVirPieceBottom ()

    eraseCurVirPiece ()
    loop
	exit when moveVirPieceDownS ()
    end loop

end moveVirPieceBottom



proc checkHoles (a : int, b : int)

    holeCount (a) (b) := 0
    var add : boolean := false
    for y : 1 .. 20
	for x : 1 .. 10


	    if virPiecesFilled (x) (y) = gray then
		for k : y .. 20
		    if not virPiecesFilled (x) (k) = gray then
			add := true
		    end if
		end for
		if add then
		    holeCount (a) (b) += 1
		    add := false
		end if
	    end if


	end for
    end for


end checkHoles


proc checkTotalHeight (a : int, b : int)

    totalHeight (a) (b) := 0
    for x : 1 .. 10
	heights (x) := 0
	for y : 1 .. 20
	    if not virPiecesFilled (x) (y) = gray then
		heights (x) := y
	    end if
	end for

	totalHeight (a) (b) += heights (x) * 4
    end for

end checkTotalHeight


proc checkNumCleared (a : int, b : int)
    linesClearedCount (a) (b) := 0
    for y : 1 .. 20
	var check : boolean := true
	for x : 1 .. 10
	    if virPiecesFilled (x) (y) = gray then
		check := false
	    end if
	end for
	if check then
	    linesClearedCount (a) (b) += 1
	end if
    end for
end checkNumCleared


proc checkBumpiness (a : int, b : int)
    bumpiness (a) (b) := 0

    for x : 1 .. 9
	bumpiness (a) (b) += abs (heights (x) - heights (x + 1))
    end for





end checkBumpiness


proc testAllPossibleMoves ()

    % moveVirPieceLeft()
    % moveVirPieceLeft()
    % moveVirPieceLeft()
    % moveVirPieceLeft()
    % moveVirPieceLeft()
    %
    % for a : 1 .. 10
    % for b : 1 .. 4

    % moveVirPieceBottom()
    % checkHoles(a,b)
    % checkTotalHeight(a,b)
    % checkNumCleared(a,b)
    % checkBumpiness(a,b)
    % virPiecesFilled := holder
    % curVirPieceX := holderX
    % curVirPieceY := holderY
    % rotateVirPiece()
    % end for
    % moveVirPieceRight()
    % end for

    var holder : array 1 .. 10 of array 1 .. 20 of int := virPiecesFilled
    var holderX : array 1 .. 4 of int := curVirPieceX
    var holderY : array 1 .. 4 of int := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 0)
    checkTotalHeight (0, 0)
    checkNumCleared (0, 0)
    checkBumpiness (0, 0)

    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-1, 0)
    checkTotalHeight (-1, 0)
    checkNumCleared (-1, 0)
    checkBumpiness (-1, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-2, 0)
    checkTotalHeight (-2, 0)
    checkNumCleared (-2, 0)
    checkBumpiness (-2, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-3, 0)
    checkTotalHeight (-3, 0)
    checkNumCleared (-3, 0)
    checkBumpiness (-3, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-4, 0)
    checkTotalHeight (-4, 0)
    checkNumCleared (-4, 0)
    checkBumpiness (-4, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-5, 0)
    checkTotalHeight (-5, 0)
    checkNumCleared (-5, 0)
    checkBumpiness (-5, 0)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 1)
    checkTotalHeight (0, 1)
    checkNumCleared (0, 1)
    checkBumpiness (0, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-1, 1)
    checkTotalHeight (-1, 1)
    checkNumCleared (-1, 1)
    checkBumpiness (-1, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-2, 1)
    checkTotalHeight (-2, 1)
    checkNumCleared (-2, 1)
    checkBumpiness (-2, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-3, 1)
    checkTotalHeight (-3, 1)
    checkNumCleared (-3, 1)
    checkBumpiness (-3, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-4, 1)
    checkTotalHeight (-4, 1)
    checkNumCleared (-4, 1)
    checkBumpiness (-4, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-5, 1)
    checkTotalHeight (-5, 1)
    checkNumCleared (-5, 1)
    checkBumpiness (-5, 1)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 2)
    checkTotalHeight (0, 2)
    checkNumCleared (0, 2)
    checkBumpiness (0, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-1, 2)
    checkTotalHeight (-1, 2)
    checkNumCleared (-1, 2)
    checkBumpiness (-1, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-2, 2)
    checkTotalHeight (-2, 2)
    checkNumCleared (-2, 2)
    checkBumpiness (-2, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-3, 2)
    checkTotalHeight (-3, 2)
    checkNumCleared (-3, 2)
    checkBumpiness (-3, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-4, 2)
    checkTotalHeight (-4, 2)
    checkNumCleared (-4, 2)
    checkBumpiness (-4, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-5, 2)
    checkTotalHeight (-5, 2)
    checkNumCleared (-5, 2)
    checkBumpiness (-5, 2)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()
    rotateVirPiece ()
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 3)
    checkTotalHeight (0, 3)
    checkNumCleared (0, 3)
    checkBumpiness (0, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-1, 3)
    checkTotalHeight (-1, 3)
    checkNumCleared (-1, 3)
    checkBumpiness (-1, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-2, 3)
    checkTotalHeight (-2, 3)
    checkNumCleared (-2, 3)
    checkBumpiness (-2, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-3, 3)
    checkTotalHeight (-3, 3)
    checkNumCleared (-3, 3)
    checkBumpiness (-3, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-4, 3)
    checkTotalHeight (-4, 3)
    checkNumCleared (-4, 3)
    checkBumpiness (-4, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceLeft ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (-5, 3)
    checkTotalHeight (-5, 3)
    checkNumCleared (-5, 3)
    checkBumpiness (-5, 3)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1



    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 0)
    checkTotalHeight (0, 0)
    checkNumCleared (0, 0)
    checkBumpiness (0, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (1, 0)
    checkTotalHeight (1, 0)
    checkNumCleared (1, 0)
    checkBumpiness (1, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (2, 0)
    checkTotalHeight (2, 0)
    checkNumCleared (2, 0)
    checkBumpiness (2, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (3, 0)
    checkTotalHeight (3, 0)
    checkNumCleared (3, 0)
    checkBumpiness (3, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (4, 0)
    checkTotalHeight (4, 0)
    checkNumCleared (4, 0)
    checkBumpiness (4, 0)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (5, 0)
    checkTotalHeight (5, 0)
    checkNumCleared (5, 0)
    checkBumpiness (5, 0)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 1)
    checkTotalHeight (0, 1)
    checkNumCleared (0, 1)
    checkBumpiness (0, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (1, 1)
    checkTotalHeight (1, 1)
    checkNumCleared (1, 1)
    checkBumpiness (1, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (2, 1)
    checkTotalHeight (2, 1)
    checkNumCleared (2, 1)
    checkBumpiness (2, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (3, 1)
    checkTotalHeight (3, 1)
    checkNumCleared (3, 1)
    checkBumpiness (3, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (4, 1)
    checkTotalHeight (4, 1)
    checkNumCleared (4, 1)
    checkBumpiness (4, 1)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (5, 1)
    checkTotalHeight (5, 1)
    checkNumCleared (5, 1)
    checkBumpiness (5, 1)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 2)
    checkTotalHeight (0, 2)
    checkNumCleared (0, 2)
    checkBumpiness (0, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (1, 2)
    checkTotalHeight (1, 2)
    checkNumCleared (1, 2)
    checkBumpiness (1, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (2, 2)
    checkTotalHeight (2, 2)
    checkNumCleared (2, 2)
    checkBumpiness (2, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (3, 2)
    checkTotalHeight (3, 2)
    checkNumCleared (3, 2)
    checkBumpiness (3, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (4, 2)
    checkTotalHeight (4, 2)
    checkNumCleared (4, 2)
    checkBumpiness (4, 2)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (5, 2)
    checkTotalHeight (5, 2)
    checkNumCleared (5, 2)
    checkBumpiness (5, 2)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1
    rotateVirPiece ()
    rotateVirPiece ()
    rotateVirPiece ()

    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (0, 3)
    checkTotalHeight (0, 3)
    checkNumCleared (0, 3)
    checkBumpiness (0, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (1, 3)
    checkTotalHeight (1, 3)
    checkNumCleared (1, 3)
    checkBumpiness (1, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (2, 3)
    checkTotalHeight (2, 3)
    checkNumCleared (2, 3)
    checkBumpiness (2, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (3, 3)
    checkTotalHeight (3, 3)
    checkNumCleared (3, 3)
    checkBumpiness (3, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (4, 3)
    checkTotalHeight (4, 3)
    checkNumCleared (4, 3)
    checkBumpiness (4, 3)
    virPiecesFilled := holder
    curVirPieceX := holderX
    curVirPieceY := holderY
    moveVirPieceRight ()
    holder := virPiecesFilled
    holderX := curVirPieceX
    holderY := curVirPieceY
    moveVirPieceBottom ()
    checkHoles (5, 3)
    checkTotalHeight (5, 3)
    checkNumCleared (5, 3)
    checkBumpiness (5, 3)
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    curVirRotation := 1

end testAllPossibleMoves



proc chooseBestMove ()
    var bestScore : real := -100000000
    for a : -5 .. 5
	for b : 0 .. 3
	    var score : real := ((totalHeight (a) (b) * (-.510066)) / 4) + (linesClearedCount (a) (b) * (.760666)) + (holeCount (a) (b) * (-.35663)) + (bumpiness (a) (b) * (-.184483))
	    if score > bestScore then
		bestPossibleMoveX := a
		bestPossibleMoveR := b
		bestScore := score
	    end if
	end for
    end for

end chooseBestMove

proc movePieceBottom ()
    eraseCurPiece ()
    loop
	exit when movePieceDownS ()
    end loop
end movePieceBottom

proc playMove ()
    if bestPossibleMoveR = 1 then
	rotatePiece ()
	%delay(100)
    elsif bestPossibleMoveR = 2 then
	rotatePiece ()
	%delay(100)
	rotatePiece ()
	%delay(100)
    elsif bestPossibleMoveR = 3 then
	rotatePiece ()
	%delay(100)
	rotatePiece ()
	%delay(100)
	rotatePiece ()
	%delay(100)
    end if


    if bestPossibleMoveX > 0 then
	loop
	    movePieceRight ()
	    %delay(100)
	    bestPossibleMoveX -= 1
	    exit when bestPossibleMoveX = 0
	end loop
    elsif bestPossibleMoveX < 0 then
	loop
	    movePieceLeft ()
	    %delay(100)
	    bestPossibleMoveX += 1
	    exit when bestPossibleMoveX = 0
	end loop
    end if



    movePieceBottom ()

end playMove



proc AIPlay ()

    if not over then
    curVirRotation := 1
    virPiecesFilled := piecesFilled
    curVirPieceX := curPieceX
    curVirPieceY := curPieceY
    testAllPossibleMoves ()
    chooseBestMove ()
    playMove ()
    end if

end AIPlay







proc getUserInput ()
    Input.KeyDown (usrInput)

    if usrInput (KEY_LEFT_ARROW) then
	if not comPlaying then
	    if not paused then
		movePieceLeft ()

		if Time.Elapsed () - lastMoveTimeL < 50 then
		    delay (10)
		else
		    delay (160)
		end if
		lastMoveTimeL := Time.Elapsed ()
	    end if
	end if
    end if
    if usrInput (KEY_RIGHT_ARROW) then
	if not comPlaying then
	    if not paused then
		movePieceRight ()
		if Time.Elapsed () - lastMoveTimeR < 50 then
		    delay (10)
		else
		    delay (160)
		end if
		lastMoveTimeR := Time.Elapsed ()
	    end if
	end if
    end if
    if usrInput (KEY_UP_ARROW) then
	if not comPlaying then
	    if not paused then
		rotatePiece ()
		delay (200)
	    end if
	end if
    end if
    if usrInput (KEY_DOWN_ARROW) then
	if not comPlaying then
	    if not paused then
		movePieceDown ()
		delay (70)
	    end if
	end if
    end if
    if usrInput (' ') then
	if not comPlaying then
	    if not paused then
		movePieceBottom ()
		delay (200)
	    end if
	end if
    end if
    if usrInput ('h') then
	if not started then
	    if Window.GetActive () = -1 then
		var winHelp : int := Window.Open ("graphics:700;700;nobuttonbar;position:top;left")
		var key : array char of boolean
		put "Tetris Help"
		put "***************************************************************************************"
		put "***************************************************************************************"
		put "How To Play"
		put "Tetris is a thrilling block game, where the player stacks blocks that are randomly generated. The objective of the game is to complete a row with blocks. When this is done, the row will disappear."
		put "The game is over when the user tops out, or when the user's stack reaches too high. Once the new block generated overlaps with the user's stack, the game ends."
		put "***************************************************************************************"
		put "The Modes"
		put "There are two modes: Endless and Survival."
		put "Endless - The user scores points by clearing lines. The game does not speed up, and the only way to end the game is to top out and get a game over"
		put "Survival - There are 20 levels. The player advances in levels by clearing lines. As the level increases, the pieces drop faster and faster. Once the player gets to level 20, they win. If they top out, they lose."
		
		put "***************************************************************************************"
		put "Keys"
		put "ESC - Pause      M - Mute/Unmute      S - Start      A - Start AI     UP - Rotate Piece"
		put "LEFT/RIGHT - Move Left/Right    Space - Hard Drop    DOWN - Light Drop   C/SHIFT - Hold"
		put "E - Switch Modes        T - File Streaming ON/OFF        Q - Quit Game         H - HELP"
		put "***************************************************************************************"
		put "AI - This game also has an option for the computer to play. What this does is the computer first determines all possible moves that can be made with the current piece."
		put "Then, through the 4 features, Hole Count, Bumpiness, Lines Cleared, and Total Height, the Computer uses weights which have been optimized with a genetic algorithm, and determines the best possible move."
		put "This can be useful in helping the user in learning how to play the game. When the AI plays survival mode, it does not end at level 20 as that is relatively easy for the AI."
		put "***************************************************************************************"
		put "Text File Streaming - When in AI Mode, the player also has an option of turning text file streaming on, which streams all of the computers decisions and plays into a text file, called 'TetrisGameLogFile.txt'."
		put "***************************************************************************************"
		put "PRESS 'H' TO GO BACK TO THE GAME"
		put ""
		put "                               /------------------------\\"
		put "                               |                        |"
		put "                               |         TETRIS         |"
		put "                               \\--------\\      /--------/"
		put "                                        |      |         "
		put "                                        |      |         "
		put "                                        |      |         "
		put "                                        \\------/        "
		
		loop

		    Input.KeyDown (key)

		    exit when key ('h')

		end loop

	    else
		Window.Close (Window.GetActive ())
	    end if
	end if
    end if
    if usrInput (KEY_ESC) then
	if started then
	    paused := not paused
	    if paused then
		if soundOn then
		    Music.PlayFileStop ()
		end if
		Draw.Text ("Paused", 700, 150, fontMain, black)
	    else
		if soundOn then
		    Music.PlayFileLoop ("Audio/TetrisBgMusic.mp3")
		end if
		Draw.Text ("Paused", 700, 150, fontMain, white)
	    end if
	    delay (400)
	end if
    end if
    if usrInput ('s') then
	if not started then
	    Draw.Text ("Press S To Start", 600, 200, fontTitle, white)
	    Draw.Text ("Press A For AI Start", 600, 150, fontTitle, white)
	    Draw.Text ("Press H For Help", 600, 100, fontTitle, white)
	    Draw.FillBox (600, 100, 1000, 300, white)
	    Draw.Text ("3", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("3", 730, 150, fontMain, white)
	    Draw.Text ("2", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("2", 730, 150, fontMain, white)
	    Draw.Text ("1", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("1", 730, 150, fontMain, white)
	    Draw.Text ("GO!", 730, 150, fontMain, black)

	    if soundOn then
		Music.PlayFileLoop ("Audio/TetrisBgMusic.mp3")
	    end if
	    paused := false
	    started := true
	    stream := false
	    comPlaying := false
	    updateIndicators ()
	end if
    end if
    if usrInput ('q') then
	if paused and started then
	    quit
	end if
    end if

    if usrInput ('a') then
	if not started then
	    Draw.Text ("Press S To Start", 600, 200, fontTitle, white)
	    Draw.Text ("Press A For AI Start", 600, 150, fontTitle, white)
	    Draw.Text ("Press H For Help", 600, 100, fontTitle, white)
	    Draw.FillBox (600, 100, 1000, 300, white)
	    Draw.Text ("3", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("3", 730, 150, fontMain, white)
	    Draw.Text ("2", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("2", 730, 150, fontMain, white)
	    Draw.Text ("1", 730, 150, fontMain, black)
	    delay (800)
	    Draw.Text ("1", 730, 150, fontMain, white)
	    Draw.Text ("GO!", 730, 150, fontMain, black)

	    if soundOn then
		Music.PlayFileLoop ("Audio/TetrisBgMusic.mp3")
	    end if
	    paused := false
	    comPlaying := true
	    started := true
	    updateIndicators ()

	end if
    end if

    if usrInput ('t') then
	if not started then
	    stream := not stream
	    updateIndicators ()
	    delay (400)
	end if
    end if

    if usrInput ('m') then
	if not started then
	    soundOn := not soundOn
	    updateIndicators ()
	    delay (400)
	end if
    end if

    if usrInput ('e') then
	if not started then
	    Draw.Text ("0", 465, 535, fontTitle, white)
	    Draw.Text ("1", 465, 535, fontTitle, white)
	    endless := not endless
	    showLevel ()
	    updateIndicators ()
	    delay (400)
	end if
    end if
    if usrInput ('c') or usrInput (KEY_SHIFT) then
	if not comPlaying then
	    if not paused then
		if holdPiece = 0 then
		    eraseCurPiece ()
		    holdPiece := curPiece
		    updateHoldPiece ()
		    spawnPiece ()
		    holding := true
		else
		    if not holdPiece = 0 then
			if not holding then
			    eraseCurPiece ()
			    var switch : int := curPiece
			    curPiece := holdPiece
			    holdPiece := switch
			    updateHoldPiece ()
			    spawnHoldPiece ()
			    holding := true
			end if
		    end if
		end if
	    end if
	end if
    end if



end getUserInput

proc winGame ()
    Draw.Text ("You Win!", 650, 150, fontMain, black)
    if soundOn then
	Music.PlayFileStop ()
	delay (100)
	Music.PlayFileReturn ("Audio/GameWin.mp3")
    end if
    for decreasing y : 20 .. 1
	for x : 1 .. 10
	    piecesFilled (x) (y) := white
	    fillBlock (x, y)
	end for
	delay (100)
	if y = 15 then
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	end if
	if y = 10 then
	    Draw.Text ("You Win!", 650, 150, fontMain, black)
	end if
	if y = 5 then
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	end if
	if y = 1 then
	    Draw.Text ("You Win!", 650, 150, fontMain, black)
	end if
    end for

    if soundOn then
	Music.SoundOff ()
    end if

    if endless and not comPlaying then
	if highScoresPlayerScore < score then
	    Draw.Text ("Player Endless  -  " + intstr (highScoresPlayerScore), 610, 600, fontFeatures, white)
	    highScoresPlayerScore := score
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif endless and comPlaying then
	if highScoresAIScore < score then
	    Draw.Text ("AI Endless      -  " + intstr (highScoresAIScore), 610, 540, fontFeatures, white)
	    highScoresAIScore := score
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif not endless and not comPlaying then
	if highScoresPlayerLevel < level then
	    Draw.Text ("Player Survival -  " + intstr (highScoresPlayerLevel), 610, 570, fontFeatures, white)
	    highScoresPlayerLevel := level
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    elsif not endless and comPlaying then
	if highScoresAILevel < level then
	    Draw.Text ("AI Survival     -  " + intstr (highScoresAILevel), 610, 510, fontFeatures, white)
	    highScoresAILevel := level
	    Draw.Text ("You Win!", 650, 150, fontMain, white)
	    Draw.Text ("NEW HIGHSCORE", 620, 150, fontTitle, black)
	end if
    end if
    open : highScoreFileWrite, "Text Files/TetrisHighScores.txt", put
    put : highScoreFileWrite, intstr (highScoresPlayerScore)
    put : highScoreFileWrite, intstr (highScoresPlayerLevel)
    put : highScoreFileWrite, intstr (highScoresAIScore)
    put : highScoreFileWrite, intstr (highScoresAILevel)
    close : highScoreFileWrite
    Draw.Text ("Player Endless  -  " + intstr (highScoresPlayerScore), 610, 600, fontFeatures, black)
    Draw.Text ("Player Survival -  " + intstr (highScoresPlayerLevel), 610, 570, fontFeatures, black)
    Draw.Text ("AI Endless      -  " + intstr (highScoresAIScore), 610, 540, fontFeatures, black)
    Draw.Text ("AI Survival     -  " + intstr (highScoresAILevel), 610, 510, fontFeatures, black)
    loop
	Input.KeyDown (usrInput)

	if usrInput ('q') then
	    exit
	end if


    end loop
end winGame


%%%%% MAIN CODE %%%%%%
setscreen ("graphics:1000;680,nobuttonbar") %Feel free to change screen dimension!
drawBoard ()


spawnPiece ()


loop
    getUserInput ()

    if not paused then
	if comPlaying then
	    AIPlay ()
	end if

	if Time.Elapsed () - timer >= speed then
	    off += 1
	    if off >= 2 then
		Draw.FillBox (600, 0, 1000, 300, white)
	    end if
	    movePieceDown ()
	    timer := Time.Elapsed ()
	end if

	if not endless and linesCleared > (level * 3) then
	    level += 1
	    showLevel ()
	    speed := 400 - (level * 20)
	end if



    end if
    if not endless then
	if not comPlaying and level >= 20 then
	    winGame ()
	    exit
	end if
    else
    end if
    if not started then
	Draw.Text ("Press S To Start", 600, 200, fontTitle, black)
	Draw.Text ("Press A For AI Start", 600, 150, fontTitle, black)
	Draw.Text ("Press H For Help", 600, 100, fontTitle, black)
    end if

end loop
