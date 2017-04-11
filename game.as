import flash.geom.Point;
import gs.*
import trailClass
import trigClass
var _trigClassRef:trigClass = new trigClass()
new soundManager(this)
stop()
setup()

onMouseDown  = mouseDownFunc
onMouseMove  = mouseMoveFunc
function addPoints(_num:Number) {
	score+=_num
	scoreTextBox.text = terrysTextFunctionClass.processNumber(score);

}
// music functions
function toggleMusicState() {
	
musicState = !musicState
storage.data.musicState = musicState
displayMusicState()
}
function displayMusicState() {
	
	trace("displayMusicState")

if (musicState){
	musicMuteBtn.gotoAndStop(1)
	musicSound.setVolume(100);
	}else {
		
			musicSound.setVolume(0);
		musicMuteBtn.gotoAndStop(2)
	}
	}
/**
 * This will make all but the passed movieclip become untouched by the player
 */
function untouchClips(_clip:MovieClip) {
	var n:Number = gridArray.length
	while (n--) {
		var _t:MovieClip = gridArray[n]
		_t.touched = false
	}
}
/**
 * reveal the next time to the player from the sequence
 */
function revealAutoSquare():Void {
	//trace("revealAutoSquare")
	var revealX:Number = 	moveList[currentRevealNum*2]
	var revealY:Number = 	moveList[currentRevealNum * 2 + 1]
	// reveal the movieClip withe cords revealX,revealY
	// target to draw towards
	_drawTargetX= revealX*gridSquareSize+gridXOffset+gridSquareSize/2
	_drawTargetY = revealY * gridSquareSize + gridYOffset+gridSquareSize/2
	
	trailPathTarget = new Point(_drawTargetX, _drawTargetY)
	//trace("trailPathTarget:"+trailPathTarget)
	var _t =  findTileClipFromCords(revealX, revealY)
	_t.swapDepths(100)
	var soundString:String = "tile" + Math.floor(Math.random() * 3 + 1 )+ "Snd"
	
soundManager.playSound(soundString)
	if (level>5){
		_t.tileMovieHolder.play()
	}
	//TweenFilterLite.to(_t, .5, { colorMatrixFilter: { amount:2, hue:105 }} );
	//TweenFilterLite.to(_t, .75, { delay:.51, colorMatrixFilter: { amount:0, hue:0 }, overwrite:false } );
	levelColours = new Array(40,105,180,-103,163)
	var demoColour:Number = levelColours[Math.floor(level/10)]
	//TweenMax.to(_t, .5, { colorMatrixFilter: { colorize:demoColour }} );
//TweenFilterLite.to(_t, .5, { colorMatrixFilter: { amount:2, hue:105 }} );
TweenFilterLite.to(_t, .5, { colorMatrixFilter: { amount:2, hue:demoColour}} );
		TweenFilterLite.to(_t, .75, {delay:.51,colorMatrixFilter:{amount:0, hue:0},overwrite:false});
	//TweenFilterLite.to(_t, 1, { delay:1, colorMatrixFilter:{}, overwrite:false } );
	//trace(revealX)
}
// now make all the clips flip over so that they land on white
function resetAllClips():Void {
	var n:Number = gridArray.length
	while (n--) {
		var _t:MovieClip = gridArray[n]
		var r:Number = Math.floor(Math.random() * 4) * 10 + 1

		_t.tileMovieHolder.gotoAndPlay(r)
	TweenFilterLite.to(_t, 1, {colorMatrixFilter:{amount:0, hue:0}});
	}
}
function findTileClipFromCords(_findX:Number, _findY:Number):MovieClip {
	var n:Number = gridArray.length
	//trace(n)
	while (n--) {
			var _tClip:MovieClip = gridArray[n]
			
			if (_tClip.xNum == _findX && _tClip.yNum == _findY ) {
				return _tClip
			}
		}
}
function squareAction(_clip:MovieClip):Void {
	if (gameState == GAME_PLAYING) {
		
	if (startedTracking){
	
	if (_clip != lastClipTouched) {
		//TweenMax.to(_clip, .5, {  colorMatrixFilter: { amount:1, hue:45 }} );
		var soundString:String = "tile" + Math.floor(Math.random() * 3 + 1 )+ "Snd"
	
soundManager.playSound(soundString)
		var _newX:Number = _clip.xNum
		var _newY:Number = _clip.yNum
		lastClipTouched = _clip
		var displayTileClip:MovieClip = _clip.clip
		//trace(lastClipTouched)
		var showColour:Number = levelColours[Math.floor(level/10)]
		TweenFilterLite.to(displayTileClip, .5, { colorMatrixFilter: { amount:2, hue:showColour }} );
		TweenFilterLite.to(displayTileClip, .75, {delay:.51,colorMatrixFilter:{amount:0, hue:0},overwrite:false});
		if (trackingMouse) {
			displayTileClip.swapDepths(100)
			_clip.touched = true
			if (level>10){
			displayTileClip.tileMovieHolder.play()
			}
			untouchClips(_clip)
			// find which motion the player did
			if (_newX > lastx) {
				playerMove = "right"
			}
			if (_newX < lastx) {
				playerMove = "left"
			}
			if (_newY > lasty) {
				playerMove = "down"
			}
			if (_newY < lasty) {
				playerMove = "up"
			}
			//playerMoveList.push(playerMove)
			playerMoveList.push(_newX,_newY)
			// now make the last x = this clips x
			lastx = _newX
			lasty = _newY
			// examine players move list, if it's different from the predefined one, they fail the level
			// compare how many moves the player has made to the same amount in the solution array
			
			//var _tempSolutionArray:Array = moveList.splice(0, playerMoveList.length)
			var _tempSolutionArray:Array = moveList.slice()
			//trace("playerMoveList = " + playerMoveList)
			//trace("_tempSolutionArray = " + _tempSolutionArray)
			
			//trace("\n")
			var targetNumCorrect:Number = moveList.length
			failedMatch = false
			var n:Number = playerMoveList.length
			for (var i:Number = 0; i < n; i++) {
				if (playerMoveList[i] != _tempSolutionArray[i]) {
					failedMatch = true
				}
			}
			if (failedMatch) {
				
				gameState = GAME_OVER
			}
			if (!faideMatch && targetNumCorrect == playerMoveList.length) {
				endMouseTime = getTimer()
				trace("endMouseTime:"+endMouseTime)
				gameState = GAME_LEVEL_COMPLETE
			}
			}
		}
	}}
}

function tellPlayer(_text:String, _frame:Number) {
	//trace(_text)
	_t = tellPlayerHolder.attachMovie("tellPlayerClip", "tp" + tellPlayerClipNum, tellPlayerClipNum)
	//trace(_t)
	_t._x = 320
	_t._y = -30
	_t.textBox.text = _text
	_t.gotoAndStop(_frame)
	TweenMax.to(_t, .5, { _y:60 } );
	TweenMax.to(_t, .5, {delay:2,_alpha:0,completeFunc:removeClip,onCompleteParams:[this] ,overwrite:false} );
	tellPlayerClipNum++
}
function findOppositeMove(_string:String):String {
	switch(_string) {
		case "left":
		// find the object that is in the position to the left of the jack and swap it
			return "right"
		break
		case "right":
			return "left"
		break
		case "down":
		return "up"
		break
		case "up":
			return "down"
		break
		
	}
}
function findRandomMove(_array:Array):String {
	var moveChoice:Number = Math.floor(Math.random() * _array.length)
	
	return (_array[moveChoice])
}
function manageTrails():Void {
	var n:Number = trailArray.length
	while (n--) {
		_trailClassRef = trailArray[n]
		_trailClassRef.manageTrail()
		if (_trailClassRef.getRemoveState()) {
			removeMovieClip(_trailClassRef.getClip())
			trailArray.splice(n,1)
			
		}
	}
}
function makeArrowTrail(_tx:Number , _ty:Number,angleVal:Number ):Void {
	var _t:MovieClip = trailHolder.attachMovie("arrow", "t" + trailNum, trailNum)
	_t.cacheAsBitmap = true
	_t._alpha =70
	trailNum++
	if (trailNum > 1000) {
		trailNum = 0
	}
	_t._rotation = angleVal
	_trailClassRef = new trailClass(_tx, _ty, _t,angleVal,0)
	trailArray.push(_trailClassRef)
}
function makeTrail(_tx:Number , _ty:Number ):Void {
	if (Math.random() * 10 < 4) {
		var _t:MovieClip = trailHolder.attachMovie("trailClip", "t" + trailNum, trailNum)
		
		var s:Number = (Math.floor(level / 10) )
		if (s < 1) {
			s = 1
		}
		s = 5
		_t.gotoAndStop(s)
		trailNum++
		if (trailNum > 1000) {
			trailNum = 0
		}
		_trailClassRef = new trailClass(_tx, _ty, _t,Math.random()*360,Math.random()*.5+.4)
		trailArray.push(_trailClassRef)
	}
}
function setup() {
	musicMuteBtn.onPress = function () {
		toggleMusicState()
	}
	
	displayMusicState()
	score = 0
	playerHelpClip._y = 514
		
	nowTraceMsgClip._y = -43
	startPathBtn._y = 530
	trailPath = new Point()
	
	trailArray = new Array()
	trailNum=0
	trackingMouse = false
	if (level == undefined) {
		level = 1
		
	}
	
	tellPlayerClipNum = 0
	levelDataArray = new Array()
	var levelNum:Number = 1
	#include "levelData.as"
}

function mouseMoveFunc() {
	//makeTrail(_xmouse, _ymouse)
	if (startedTracking) {
			makeTrail(_xmouse, _ymouse)
			var _tempClip:MovieClip = nothing
	// find which clip the user is over
	var n:Number = hotSpotArray.length
		while (n--) {
			var _t:MovieClip = hotSpotArray[n]
			//trace(_t)
			if (_t.hitTest(_xmouse, _ymouse)) {
				//trace("found the clip")
				_tempClip =  _t
				break
			}
		}
		if (_tempClip!=nothing){
	squareAction(_tempClip)
		}
	}
	
}
function mouseDownFunc() {

	if (gameState == GAME_PLAYING && !startedTracking) {
		startMouseTime = getTimer()
		trace("startMouseTime:"+startMouseTime)
		//soundManager.playSound("new level")
		// find which clip the player is above
		var n:Number = gridArray.length
		//trace(n)
		var _tempClip:MovieClip
		while (n--) {
			var _t:MovieClip = hotSpotArray[n]
			//trace(_t)
			if (_t.hitTest(_xmouse, _ymouse)) {
				//trace("found the clip")
				_tempClip =  _t
				break
			}
		}
		trackingMouse = true
		startedTracking = true
		var _newX:Number = _tempClip.xNum
		var _newY:Number = _tempClip.yNum
		//playerMoveList.push(_newX, _newY)
		//_tempClip.swapDepths(100)
		//_tempClip.touched = true
		//_tempClip.play()
		squareAction(_tempClip)
	}

	// need to detect if the user is over the correct starting position
	
}
function setupLevel() {
	//level = 35
	startedTracking = false
	trackingMouse = false
	playerMoveList = new Array()
	// create a level path for the player to remember
	moveList = new Array()
	moveList = levelDataArray[level][2]
	//moveList = new Array(1,1,1,2,1,1,2,1,2,2,3,2)
	//trace("moveList:" + moveList)
	var revealX:Number = 	moveList[currentRevealNum*2]
	var revealY:Number = 	moveList[currentRevealNum * 2 + 1]
	// reveal the movieClip withe cords revealX,revealY
	// setup the drawing clip
	_currentTargetX =  revealX * gridSquareSize + gridXOffset + gridSquareSize / 2
	_currentTargetY =  revealY * gridSquareSize + gridYOffset + gridSquareSize / 2
	
	revealDelay = 15 - level / 10
	trace("revealDelay = "+revealDelay)
	//revealDelay = 10 - level / 5
	currentRevealNum = 0
	maxRevealNum = moveList.length / 2
	//trace("maxRevealNum:"+maxRevealNum)
	startPathBtn._y = 530
	
	TweenMax.to(startPathBtn, .5, {  _y:416 ,delay:1} );
	startPathBtn.onRelease = function () {
			TweenMax.to(startPathBtn, .25, {  _y:550 } );
		gameState = GAME_SHOW_PLAYER
	}
	
}
// cleanup grid
function removeGridPeices():Void {
	var n:Number = gridArray.length
		while (n--) {
			var _t:MovieClip = gridArray[n]
			var _h:MovieClip = hotSpotArray[n]
			removeMovieClip(_t)
			removeMovieClip(_h)

		}
	
	
}
/**
 * this enables the clips after the demo has run
 */
function enableGridButtonMode():Void {
	var n:Number = hotSpotArray.length
		while (n--) {
			var _h:MovieClip = hotSpotArray[n]
			_h.enabled = true
		}
}
function setupGrid():Void {
	removeGridPeices()
	gridSquareSize = 60
	lastx = 0
	lasty = 0
	//trace("setup grid")
	squareNum = 0
	gridArray= new Array()
	hotSpotArray = new Array()
	gridXSize = levelDataArray[level][0]
	gridYSize = levelDataArray[level][1]
	gridXOffset = (640 - gridXSize * gridSquareSize) / 2
	trace(gridXOffset)
	gridYOffset = (480-gridYSize*gridSquareSize)/2
	//gridSquareSize = 400/gridYSize
	totalSquaresTime=0
	
	for (var i = 0; i < gridYSize; i++) {
		for (var j = 0; j < gridXSize; j++) {
			_t = gridHolder.attachMovie("square", "sq" + squareNum, squareNum)
			_t.gotoAndStop(level)
			_h = hotSpotHolder.attachMovie("hotspot", "sq" + squareNum, squareNum)
			_h.enabled = false
			squareNum++
			_h._x = _t._x = j*gridSquareSize+gridXOffset
			_h._y = _t._y = i * gridSquareSize + gridYOffset
			_t._x = 320
			 _t._y = -60
			 TweenMax.to(_t, .5, { _x:_h._x, _y:_h._y, delay:squareNum / 10*.7 } );
			 totalSquaresTime+=squareNum / 10 +1
			_h.clip = _t
			//_t._width = _t._height = 80
			_h.xNum = _t.xNum = j
			_h.yNum = _t.yNum = i
			_h._alpha = 0
			//_h.onRollOver = function () {
				//squareAction(this)
			//}
			_t.touched = false
			_h.touched = false
			gridArray.push(_t)
			hotSpotArray.push(_h)
		}
	}
	
}
function resetGrid():Void {
	var n:Number = gridArray.length
	while (n--) {
		_t = gridArray[n]
		_t.touched = false
	}
}
function putAwaySquares():Void {
	var n:Number = gridArray.length
	while (n--) {
		_t = gridArray[n]
		var r:Number = Math.floor(Math.random() * 4)
		switch(r) {
			case 0:
			TweenMax.to(_t, .5, { _x:Math.random()*640,_y:560,delay:n/10*.7,overwrite:false} );
			break
			case 1:
			TweenMax.to(_t, .5, { _x:Math.random()*640,_y:-80,delay:n/10*.7,overwrite:false} );
			break
			case 2:
			TweenMax.to(_t, .5, { _x:-80,_y:Math.random()*640,delay:n/10*.7,overwrite:false} );
			break
			case 3:
			TweenMax.to(_t, .5, { _x:720,_y:Math.random()*640,delay:n/10*.7,overwrite:false} );
			break
		}
		
	_t.swapDepths(1000-n)
	}
				
}
loopInterval = setInterval(loop, 30)

function loop():Void {
	 manageTrails()
	switch (gameState) {
		case GAME_PLAYING:
		
		break
		case GAME_SETUP:
			//setupGrid()
			gameState = GAME_SETUP_LEVEL
		break
		case GAME_SETUP_LEVEL:
			setupLevel()
		setupGrid()
		counter = totalSquaresTime+40
		trace("counter:"+counter)
			tellPlayer(""+ level, 1)
			
			
			
			gameState = GAME_SETUP_LEVEL_WAIT
		break
		case GAME_SETUP_LEVEL_WAIT:
			counter--
			if (counter < 1) {
				
				gameState = GAME_WAIT_FOR_PLAYER_START
			}
		break
		case GAME_WAIT_FOR_PLAYER_START:
		
		
		break
		case GAME_SHOW_PLAYER:
		trace("GAME_SHOW_PLAYER")
			counter = revealDelay
			var revealX:Number = 	moveList[0]
	var revealY:Number = 	moveList[1]
	// reveal the movieClip withe cords revealX,revealY
	// target to draw towards
	_drawTargetX= revealX*gridSquareSize+gridXOffset+gridSquareSize/2
	_drawTargetY = revealY * gridSquareSize + gridYOffset+gridSquareSize/2
			trailPath = new Point(_drawTargetX, _drawTargetY)
			trailPathTarget = new Point(trailPath.x, trailPath.y)
		
			dx =  -80
			dy = -80
			dist = Math.floor(Math.sqrt(dx * dx + dy * dy));
	
		_showTrailmoveSpeed = dist / revealDelay * .5
		//_showTrailmoveSpeed =3
		//trace("_showTrailmoveSpeed:"+_showTrailmoveSpeed)
		trailCounter = 28
			gameState = GAME_SHOW_PLAYER_WAIT
		break
		case GAME_SHOW_PLAYER_WAIT:
		// create a particle path showing where the user should draw
		
		// move the trailPath towards the target
	 dx =  trailPathTarget.x-trailPath.x ;
			dy = trailPathTarget.y-trailPath.y ;
			var radians = Math.atan2(dy, dx)
			var _tempAngle:Number = radians * 180 / Math.PI
			
			//lastAngle = _tempAngle
		//trace(trailPathTarget)
		
		//trace("_moveSpeed:"+_moveSpeed)
		var moveX:Number = Math.cos(radians)	* _showTrailmoveSpeed
		//trace(moveX)
		var moveY:Number = Math.sin(radians) * _showTrailmoveSpeed
		trailPath.x +=moveX
		trailPath.y += moveY
		trailCounter --
		if (trailCounter < 1) {
			trailCounter = 2
			//trace(_tempAngle)
			makeArrowTrail(trailPath.x,trailPath.y,_tempAngle)
		}
		
			counter --
			if (counter < 1) {
				// if all moves revealed to player otherwise wait, then reveal next peice
			
			
				if (currentRevealNum < maxRevealNum) {
					revealAutoSquare()
					//trailPath = new Point(_drawTargetX, _drawTargetY)
					currentRevealNum++
					counter = revealDelay
				}else {
				
					
					gameState = GAME_SHOW_PLAYER_FINISHED
				}
			}
		break
		case GAME_SHOW_PLAYER_FINISHED:
		// clean up and start players turn
		enableGridButtonMode()
		nowTraceMsgClip._y = -43
		TweenMax.to(nowTraceMsgClip, .5, {  _y:32 , delay:1 } );
		if (level == 1) {
			
			playerHelpClip.textBox.text= "Click to the first square, then trace the path exactly with the mouse"
		}
		if (level == 2) {
			playerHelpClip.textBox.text= "Your progress will be saved, and you can continue from any level"
		}
		if (level == 3) {
			
			playerHelpClip.textBox.text= "The faster you draw the path, the more points you earn"
		}
		if (level ==4) {
		
			playerHelpClip.textBox.text= "You earn points only when completing a level"
		}
		if (level == 5) {
		
			playerHelpClip.textBox.text= "If you start a new game, your score will reset"
		}
		if (level == 6) {
			
			
			playerHelpClip.textBox.text= "Good luck in beating all 50 levels"
		}
		if (level < 7) {
			playerHelpClip._y = 514
		TweenMax.to(playerHelpClip, .5, {  _y:446 , delay:1 } );
		}
		if (level > 5) {
			
			resetAllClips()
		}
		counter = 30
		gameState = GAME_PLAYING
		break
		case GAME_SHOW_PLAYER_FINISHED_WAIT:
		counter --
		if (counter < 1) {
			gameState = GAME_PLAYING
		}
	
		
		break
		
		case GAME_LEVEL_COMPLETE:
		// calculate the players score
		var timeTaken = endMouseTime - startMouseTime
		trace("timeTaken:" + timeTaken)
		trace(typeof(timeTaken))
		var pointsToAward:Number = 10000 - timeTaken
		trace(pointsToAward)
		if (pointsToAward < 0) {
			pointsToAward = 0
			
		}else {
			addPoints(pointsToAward)
		}
		soundManager.playSound("level complete")
		TweenMax.to(nowTraceMsgClip, .25, {  _y:-43  } );
		TweenMax.to(playerHelpClip, .25, {  _y:514 , delay:1 } );
			putAwaySquares()
			startedTracking = false
			counter = 80
			tellPlayer("CORRECT", 3)
			gameState = GAME_LEVEL_COMPLETE_WAIT
		break
		case GAME_LEVEL_COMPLETE_WAIT:
			counter--
			if (counter < 1) {
				level ++
				userCompletedPuzzles = level
				storage.data.userCompletedPuzzles = userCompletedPuzzles
				storage.flush()
				if (level > 50) {
						gameState = GAME_COMPLETE
				}else {
						gameState = GAME_SETUP_LEVEL
				}
			
			}
		break
		case GAME_OVER:
		TweenMax.to(playerHelpClip, .25, {  _y:514 , delay:1 } );
		soundManager.playSound("game over")
		putAwaySquares()
		
		TweenMax.to(nowTraceMsgClip, .25, {  _y:-32 } );
			counter = 120
			tellPlayer("wrong", 2)
			gameState = GAME_OVER_WAIT
		break
		case GAME_OVER_WAIT:
			counter--
			if (counter < 1) {
				removeGridPeices()
				gameState = GAME_OVER_SCREEN
			}
		break
		case GAME_COMPLETE:
		counter = 120
		gameState = GAME_COMPLETE_WAIT
		break
		case GAME_COMPLETE_WAIT:
		counter--
		if (counter < 1) {
			
			clearInterval(loopInterval)
			gotoAndPlay("GAME COMPLETE",1)
		}
		break
		case GAME_OVER_SCREEN:
		gotoAndPlay("GAME OVER", 1)
		clearInterval(loopInterval)
		gameState = GAME_OVER_SCREEN_WAIT
		
		break
		case GAME_OVER_SCREEN_WAIT:
		level = 1
		gameState = GAME_SETUP
		break
	}
}
function removeClip(_clip:MovieClip):Void {
	removeMovieClip(_clip)
}
var GAME_PLAYING:Number = 1
var GAME_SETUP_LEVEL:Number = 2
var GAME_SETUP_LEVEL_WAIT:Number = 2.1
var GAME_OVER:Number = 3
var GAME_OVER_WAIT:Number = 3.1
var GAME_LEVEL_COMPLETE:Number = 4
var GAME_LEVEL_COMPLETE_WAIT:Number = 4.1
var GAME_OVER_SCREEN:Number = 5
var GAME_OVER_SCREEN_WAIT:Number = 5.1
var GAME_SHOW_PLAYER:Number = 6
var GAME_SHOW_PLAYER_WAIT:Number = 6.1
var GAME_SHOW_PLAYER_FINISHED:Number = 6.2
var GAME_COMPLETE:Number = 7
var GAME_COMPLETE_WAIT:Number = 7.1

var GAME_SETUP:Number = 0
var gameState:Number = 0
var loopInterval:Number
var gridXSize:Number
var gridYSize:Number
var gridSquareSize:Number
var level:Number
var levelDataArray:Array
var gridArray:Array
var moveList:Array
var trailArray:Array
var hotSpotArray:Array
var playerMovieList:Array
var squareNum:Number
var lastx:Number
var lasty:Number
var tellPlayerClipNum:Number
var gridHolder:MovieClip
var _t:MovieClip
var playerMove:String
var lastClipTouched:MovieClip
var trackingMouse:Boolean
var startedTracking:Boolean
var counter:Number
var revealDelay:Number
var gridXOffset:Number
var gridYOffset:Number
var _drawTargetX:Number
var _drawTargetY:Number
var _currentTargetX:Number
var _currentTargetY:Number
var trailNum:Number
var totalSquaresTime:Number
var _trailClassRef:trailClass
var trailPath:Point
var trailPathTarget:Point
var _showTrailmoveSpeed:Number
var startMouseTime:Number
var endMouseTime:Number
var timeTaken:Number

