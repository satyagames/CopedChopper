/*
VERSION: 1.16
DATE: 5/29/2008
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com 
DESCRIPTION:
	TweenMax builds on top of the TweenLite core class and its big brother, TweenFilterLite, to round out the tweening family with popular 
	(though not essential) features like bezier tweening, pause/resume capabilities, easier sequencing, hex color tweening, and more. 
	TweenMax uses the same easy-to-learn syntax as its siblings. In fact, since it extends them, TweenMax can do anything TweenLite 
	and/or TweenFilterLite can do, plus more. So why build 3 classes instead of one? Good question. The goal was to maximize efficiency 
	and minimize file size. Frankly, TweenLite is probably all most developers will need for 90% of their projects, and it only takes 
	up 3k. It's extremely efficient and compact considering its features. But if you need to tween filters or rich imaging effects 
	like saturation, contrast, hue, colorization, etc., step up to TweenFilterLite at 6k (total). Still need more? No problem - use 
	TweenMax to add extra features jam-packed into 8k (total). See the feature comparison chart at www.TweenMax.com for more info. 
	TweenMax introduces an innovative feature called "bezierThrough" that allows you to define points through which you want the 
	bezier curve to travel (instead of normal control points that simply attract the curve). Or use regular bezier curves - whichever 
	you prefer. Currently, TweenMax adds the following features (compared to TweenFilterLite):
		- Perform Bezier tweens (including THROUGH points and automatic orientation of Objects to Beziers)
		- Sequence tweens
		- Tween arrays of objects with allTo() and allFrom()
		- Pause/Resume tweens using either the pause() and resume() methods or the "paused" property (like myTween.paused = true)
		- isTweening static method for finding out if any object is currently being tweened (like TweenMax.isTweening(my_mc))
		- Jump to any point in the tween using the "progress" property. Feed it a value between 0 and 1. Setting progress to 
		  0 will force the tween to be zero percent complete, and 1 would be 100% complete, 0.5 would be half-way through.
		  Example: myTween.progress = 0.5;
		- Tween hex colors easily with the hexColors property.
		- Get an array of all TweenMax (and TweenLite and TweenFilterLite) instances that are currently affecting a particular target object.
		  Example: TweenMax.getTweensOf(my_mc);
		- Get an array of all TweenMax (and TweenLite and TweenFilterLite) instances with the static getAllTweens() function.
		- Kill all tweens (and optionally complete them)
		- Pause/Resume all tweens

PARAMETERS:
	1) $target : Object - Target MovieClip (or other object) whose properties we're tweening
	2) $duration : Number - Duration (in seconds) of the tween
	3) $vars : Object - An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
	          		    TweenMax.from() method, these variables would define the BEGINNING values). For example:
						  _alpha: The alpha (opacity level) that the target object should finish at (or begin at if you're 
								  using TweenMax.from()). For example, if the target_obj._alpha is 100 when this script is 
								  called, and you specify this argument to be 50, it'll transition from 100 to 50.
						  _x: To change a MovieClip's x position, just set this to the value you'd like the MovieClip to 
							  end up at (or begin at if you're using TweenMax.from()). 
		  SPECIAL PROPERTIES:
			  delay : Number - Amount of delay before the tween should begin (in seconds).
			  ease : Function - You can specify a function to use for the easing with this variable. For example, 
								mx.transitions.easing.Elastic.easeOut. The Default is Regular.easeOut.
			  easeParams : Array - An array of extra parameters to feed the easing equation. This can be useful when you 
								   use an equation like Elastic and want to control extra parameters like the amplitude and period.
								   Most easing equations, however, don't require extra parameters so you won't need to pass in any easeParams.
			  autoAlpha : Number - Use it instead of the alpha property to gain the additional feature of toggling 
								   the visible property to false when alpha reaches 0. It will also toggle visible 
								   to true before the tween starts if the value of autoAlpha is greater than zero.
			  volume : Number - To change a MovieClip's volume, just set this to the value you'd like the 
								MovieClip to end up at (or begin at if you're using TweenMax.from()).
			  tint : Number - To change a MovieClip's tint/color, set this to the hex value of the tint you'd like
							  to end up at(or begin at if you're using TweenMax.from()). An example hex value would be 0xFF0000. 
							  If you'd like to remove the tint, just pass null as the value of tint.
			  frame : Number - Use this to tween a MovieClip to a particular frame.
			  bezier : Array - Bezier tweening allows you to tween in a non-linear way. For example, you may want to tween
							   a MovieClip's position from the origin (0,0) 500 pixels to the right (500,0) but curve downwards
							   through the middle of the tween. Simply pass as many objects in the bezier array as you'd like, 
							   one for each "control point" (see documentation on Flash's curveTo() drawing method for more
							   about how control points work). In this example, let's say the control point would be at x/y coordinates
							   250,50. Just make sure your my_mc is at coordinates 0,0 and then do: 
							   TweenMax.to(my_mc, 3, {_x:500, _y:0, bezier:[{_x:250, _y:50}]});
			  bezierThrough : Array - Identical to bezier except that instead of passing bezier control point values, you
									  pass points through which the bezier values should move. This can be more intuitive
									  than using control points.
			  orientToBezier : Array (or Boolean) - A common effect that designers/developers want is for a MovieClip to 
			  						orient itself in the direction of a Bezier path (alter its _rotation). orientToBezier
									makes it easy. In order to alter a rotation property accurately, TweenMax needs 4 pieces
									of information: 
										1) Position property 1 (typically "_x")
										2) Position property 2 (typically "_y")
										3) Rotational property (typically "_rotation")
										4) Number of degrees to add (optional - makes it easy to orient your MovieClip properly)
									The orientToBezier property should be an Array containing one Array for each set of these values. 
									For maximum flexibility, you can pass in any number of arrays inside the container array, one 
									for each rotational property. This can be convenient when working in 3D because you can rotate
									on multiple axis. If you're doing a standard 2D x/y tween on a bezier, you can simply pass 
									in a boolean value of true and TweenMax will use a typical setup, [["_x", "_y", "_rotation", 0]]. 
									Hint: Don't forget the container Array (notice the double outer brackets)
			  hexColors : Object - Although hex colors are technically numbers, if you try to tween them conventionally,
						 you'll notice that they don't tween smoothly. To tween them properly, the red, green, and 
						 blue components must be extracted and tweened independently. TweenMax makes it easy. To tween
						 a property of your object that's a hex color to another hex color, use this special hexColors 
						 property of TweenMax. It must be an OBJECT with properties named the same as your object's 
						 hex color properties. For example, if your my_obj object has a "myHexColor" property that you'd like
						 to tween to red (0xFF0000) over the course of 2 seconds, do: 
						 TweenMax.to(my_obj, 2, {hexColors:{myHexColor:0xFF0000}});
						 You can pass in any number of hexColor properties.
			  onStart : Function - If you'd like to call a function as soon as the tween begins, pass in a reference to it here.
								   This is useful for when there's a delay. 
			  onStartParams : Array - An array of parameters to pass the onStart function. (this is optional)
			  onStartScope : Object - Use this to define the scope of the onStart function.
			  onUpdate : Function - If you'd like to call a function every time the property values are updated (on every frame during
									the time the tween is active), pass a reference to it here.
			  onUpdateParams : Array - An array of parameters to pass the onUpdate function (this is optional)
			  onUpdateScope : Object - Use this to define the scope of the onUpdate function.
			  onComplete : Function - If you'd like to call a function when the tween has finished, use this. 
			  onCompleteParams : Array - An array of parameters to pass the onComplete function (this is optional)
			  onCompleteScope : Object - Use this to define the scope of the onComplete function.
			  renderOnStart : Boolean - If you're using TweenFilterLite.from() with a delay and want to prevent the tween from rendering until it
										actually begins, set this to true. By default, it's false which causes TweenMax.from() to render
										its values immediately, even before the delay has expired.
			  overwrite : Boolean - If you do NOT want the tween to automatically overwrite all other tweens that are 
									affecting the same target, make sure this value is false.
			  blurFilter : Object - To apply a BlurFilter, pass an object with one or more of the following properties:
			  						blurX, blurY, quality
			  glowFilter : Object - To apply a GlowFilter, pass an object with one or more of the following properties:
			  						alpha, blurX, blurY, color, strength, quality, inner, knockout
			  colorMatrixFilter : Object - To apply a ColorMatrixFilter, pass an object with one or more of the following properties:
										   colorize, amount, contrast, brightness, saturation, hue, threshold, relative, matrix
			  dropShadowFilter : Object - To apply a ColorMatrixFilter, pass an object with one or more of the following properties:
										  alpha, angle, blurX, blurY, color, distance, strength, quality
			  bevelFilter : Object - To apply a BevelFilter, pass an object with one or more of the following properties:
									 angle, blurX, blurY, distance, highlightAlpha, highlightColor, shadowAlpha, shadowColor, strength, quality
									 
									 
KEY PROPERTIES:
	- progress : Number (0 - 1 where 0 = tween hasn't progressed, 0.5 = tween is halfway done, and 1 = tween is finished)
	- paused : Boolean
	
KEY METHODS:
	- TweenMax.to(target:Object, duration:Number, vars:Object):TweenMax
	- TweenMax.from(target:Object, duration:Number, vars:Object):TweenMax
	- TweenMax.allTo(targets:Array, duration:Number, vars:Object):Array
	- TweenMax.allFrom(targets:Array, duration:Number, vars:Object):Array
	- TweenMax.sequence(target:Object, tweens:Array):Array
	- TweenMax.getTweensOf(target:Object):Array
	- TweenMax.isTweening(target:Object):Boolean
	- TweenMax.getAllTweens():Array
	- TweenMax.killAllTweens(complete:Boolean):void
	- TweenMax.killAllDelayedCalls(complete:Boolean):Void
	- TweenMax.pauseAll(tweens:Boolean, delayedCalls:Boolean):Void
	- TweenMax.resumeAll(tweens:Boolean, delayedCalls:Boolean):Void
	- pause():Void
	- resume():Void

EXAMPLES: 
	
	To set up a sequence where we fade a MovieClip to 50% opacity over the course of 2 seconds, and then slide it down
	to _y coordinate 300 over the course of 1 second:
	
		import gs.TweenMax;
		TweenMax.sequence(clip_mc, [{time:2, _alpha:50}, {time:1, _y:300}]);
	
	To tween the clip_mc MovieClip over 5 seconds, changing the _alpha to 50%, the _x to 120 using the Back.easeOut
	easing function, delay starting the whole tween by 2 seconds, and then call	a function named "onFinishTween" when 
	it has completed and pass in a few parameters to that function (a value of 5 and a reference to the clip_mc), 
	you'd do so like:
		
		import gs.TweenMax;
		import mx.transitions.easing.Back;
		TweenMax.to(clip_mc, 5, {_alpha:50, _x:120, ease:Back.easeOut, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1:Number, argument2:MovieClip):Void {
			trace("The tween has finished! argument1 = " + argument1 + ", and argument2 = " + argument2);
		}
	
	If you have a MovieClip on the stage that is already in it's end position and you just want to animate it into 
	place over 5 seconds (drop it into place by changing its _y property to 100 pixels higher on the screen and 
	dropping it from there), you could:
		
		import gs.TweenMax;
		import mx.transitions.easing.Elastic;
		TweenMax.from(clip_mc, 5, {_y:"-100", ease:Elastic.easeOut});		
	

NOTES:
	- Putting quotes around values will make the tween relative to the current value. For example, if you do
	  TweenMax.to(mc, 2, {_x:"-20"}); it'll move the mc.x to the left 20 pixels which is the same as doing
	  TweenMax.to(mc, 2, {_x:mc._x - 20});
	- You can tween the volume of any MovieClip using the tween property "volume", like:
	  TweenMax.to(myClip_mc, 1.5, {volume:0});
	- You can tween the tint/color of a MovieClip using the tween property "tint", like:
	  TweenMax.to(myClip_mc, 1.5, {tint:0xFF0000});
	- To tween an array, just pass in an array as a property (it doesn't matter what you name it) like:
	  var myArray:Array = [1,2,3,4];
	  TweenMax.to(myArray, 1.5, {endArray:[10,20,30,40]});
	- You can kill all tweens for a particular object (usually a MovieClip) anytime with the 
	  TweenMax.killTweensOf(myClip_mc); function. If you want to have the tweens forced to completion, 
	  pass true as the second parameter, like TweenMax.killTweensOf(myClip_mc, true);
	- You can kill all delayedCalls to a particular function using TweenMax.killDelayedCallsTo(myFunction);
	  This can be helpful if you want to preempt a call.
	- Use the TweenMax.from() method to animate things into place. For example, if you have things set up on 
	  the stage in the spot where they should end up, and you just want to animate them into place, you can 
	  pass in the beginning _x and/or _y and/or _alpha (or whatever properties you want).
	  
CHANGE LOG:
	
	1.14:
		- Fixed issue with sequences that are run more than once.
	1.1:
		- Added the capability to pause/resume delayedCalls()
	1.0:
		- Added killAllTweens()
		- Added pauseAllTweens()
		- Added resumeAllTweens()
	0.98:
		- Added orientToBezier functionality
	0.96:
		- Fixed potential problem with allTo() and allFrom() that could prevent easeParams from working properly.
	0.95:
		- Changed multiTo() and multiFrom() to allTo() and allFrom() and added onCompleteAll, onCompleteAllParams, and onCompleteAllScope special properties for those methods.
	0.94:
		- Added multiTo() and multiFrom() support (later changed to allTo() and allFrom())
	0.93:
		- Prevented "progress" property from extending beyond 1 after the tween had finished.
	0.92:
		- Fixed missing import statement that prevented killTweensOf() from working properly and a few other static functions.
		- Fixed bug where renderOnStart wasn't functioning properly on from() calls.
	0.9:
		- Added bezier support
		- Added sequencing support
		- Ensured that all tweens are syncronized (use an internal timing mechanism now)
	0.14:
		- Extended TweenFilterLite instead of TweenLite so that now TweenMax inherets all of TweenFilterLite's goodness
		  (basically meaning you can tween filters too)
	0.13:
		- Added getAllTweens() static function
	0.12:
		- Added ability to tween hexColors
		- Made compatible with TweenLite 6.0

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

import gs.TweenFilterLite;
import gs.TweenLite;

class gs.TweenMax extends TweenFilterLite {
	public static var version:Number = 1.16;
	private static var RAD2DEG:Number = 180 / Math.PI; //precalculate for speed
	public static var killTweensOf:Function = TweenLite.killTweensOf;
	public static var killDelayedCallsTo:Function = TweenLite.killDelayedCallsTo;
	public static var removeTween:Function = TweenLite.removeTween;
	public static var defaultEase:Function = TweenLite.defaultEase;
	private var _pauseTime:Number;
	
	public function TweenMax($target:Object, $duration:Number, $vars:Object) {
		super($target, $duration, $vars);
		_pauseTime = null;
		if (TweenFilterLite.version < 7.13 || isNaN(TweenFilterLite.version)) {
			trace("TweenMax error! Please update your TweenFilterLite class. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
		}
	}
	
	public static function to($target:Object, $duration:Number, $vars:Object):TweenMax {
		return new TweenMax($target, $duration, $vars);
	}
	
	public static function from($target:Object, $duration:Number, $vars:Object):TweenMax {
		$vars.runBackwards = true;
		return new TweenMax($target, $duration, $vars);
	}
	
	public static function allTo($targets:Array, $duration:Number, $vars:Object):Array { //vars takes the same special parameters as to() and from() calls, and ALSO "delayIncrement", "onCompleteAll", "onCompleteAllParams", and "onCompleteAllScope"
		if ($targets.length == 0) {
			return [];
		}
		var i:Number, v:Object, p:String, dl:Number, lastVars:Object;
		var a:Array = [];
		var dli:Number = $vars.delayIncrement || 0;
		delete $vars.delayIncrement;
		if ($vars.onCompleteAll == undefined) {
			lastVars = $vars;
		} else {
			lastVars = {}; //Need to create a new object so that we can have a different onComplete and onCompleteParams properties!
			for (p in $vars) {
				lastVars[p] = $vars[p]; //copy each property
			}
			lastVars.onCompleteParams = [[$vars.onComplete, $vars.onCompleteAll], [$vars.onCompleteParams, $vars.onCompleteAllParams], [$vars.onCompleteScope, $vars.onCompleteAllScope]];
			lastVars.onComplete = TweenMax.callbackProxy;
			delete $vars.onCompleteAll;
		}
		delete $vars.onCompleteAllParams;
		delete $vars.onCompleteAllScope;
		if (dli == 0) {
			a.push(new TweenMax($targets[0], $duration, lastVars)); //we have to add it to the beginning since all the tweens will be timed identically, and the executeAll() function loops through those in opposite order. We need it to actually fire last.
			for (i = 1; i < $targets.length; i++) {
				v = {};
				for (p in $vars) {
					v[p] = $vars[p]; //Create a new object and copy the properties, otherwise easeParams will throw errors.
				}
				a.push(new TweenMax($targets[i], $duration, v));
			}
		} else {
			dl = $vars.delay || 0;
			for (i = 0; i < $targets.length - 1; i++) {
				v = {};
				for (p in $vars) {
					v[p] = $vars[p]; //Create a new object and copy the properties so that we can have a different delay value.
				}
				v.delay = dl + (i * dli);
				a.push(new TweenMax($targets[i], $duration, v));
			}
			lastVars.delay = dl + (($targets.length - 1) * dli);
			a.push(new TweenMax($targets[$targets.length - 1], $duration, lastVars)); //add this to the end so the onCompleteAll fires last.
		}		
		return a;
	}
	
	public static function allFrom($targets:Array, $duration:Number, $vars:Object):Array {
		$vars.runBackwards = true;
		return allTo($targets, $duration, $vars);
	}
	
	public static function callbackProxy($functions:Array, $params:Array, $scopes:Array):Void {
		for (var i:Number = 0; i < $functions.length; i++) {
			if ($functions[i] != undefined) {
				$functions[i].apply($scopes[i], $params[i]);
			}
		}
	}
	
	public static function sequence($target:Object, $tweens:Array):Array { //Note: make sure each tween object has a "time" parameter (duration in seconds).
		var overwrite:Boolean = true;
		if ($tweens[0].overwrite == false) {
			overwrite = false;
		}
		var a:Array = [];
		var totalDelay:Number = 0;
		var dl:Number, t:Number, i:Number, o:Object, p:String, tw:Object;
		for (i = 0; i < $tweens.length; i++) {
			tw = $tweens[i];
			t = tw.time || 0;
			o = {};
			for (p in tw) {
				o[p] = tw[p]; //copy the object so that we can edit it without interfering with the original object which may be used again if the developer runs the same sequence multiple times.
			}
			delete o.time;
			dl = o.delay || 0;
			o.delay = totalDelay + dl;
			o.overwrite = overwrite;
			a.push(new TweenMax($target, t, o));
			totalDelay += t + dl;
			overwrite = false;
		}
		return a;
	}
	
	public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array, $onCompleteScope:Object):TweenMax {
		return new TweenMax($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:false});
	}
	
	public function initTweenVals($hrp:Boolean, $reservedProps:String):Void {
		$reservedProps = $reservedProps || "";
		$reservedProps += " hexColors bezier bezierThrough orientToBezier onCompleteAll onCompleteAllParams ";
		var p:String, i:Number, curProp:Object, props:Object, b:Array;
		var bProxy:Function = bezierProxy; 
		if (this.vars.orientToBezier == true) {
			this.vars.orientToBezier = [["_x", "_y", "_rotation", 0]];
			bProxy = bezierProxy2;
		} else if (this.vars.orientToBezier instanceof Array) {
			bProxy = bezierProxy2;
		}
		if (this.vars.bezier != undefined) {
			props = {};
			b = this.vars.bezier;
			for (i = 0; i < b.length; i++) {
				for (p in b[i]) {
					if (props[p] == undefined) {
						props[p] = [this.target[p]];
					}
					if (typeof(b[i][p]) == "number") {
						props[p].push(b[i][p]);
					} else {
						props[p].push(this.target[p] + Number(b[i][p])); //relative value
					}
				}
			}
			for (p in props) {
				if (typeof(this.vars[p]) == "number") {
					props[p].push(this.vars[p]);
				} else {
					props[p].push(this.target[p] + Number(this.vars[p])); //relative value
				}
				delete this.vars[p]; //to prevent TweenLite from doing normal tweens on these Bezier values.
			}
			addSubTween(bProxy, {t:0}, {t:1}, {props:parseBeziers(props, false), target:this.target, orientToBezier:this.vars.orientToBezier});
		}
		if (this.vars.bezierThrough != undefined) {
			props = {};
			b = this.vars.bezierThrough;
			for (i = 0; i < b.length; i++) {
				for (p in b[i]) {
					if (props[p] == undefined) {
						props[p] = [this.target[p]]; //starting point
					}
					if (typeof(b[i][p]) == "number") {
						props[p].push(b[i][p]);
					} else {
						props[p].push(this.target[p] + Number(b[i][p])); //relative value
					}
				}
			}
			for (p in props) {
				if (typeof(this.vars[p]) == "number") {
					props[p].push(this.vars[p]);
				} else {
					props[p].push(this.target[p] + Number(this.vars[p])); //relative value
				}
				delete this.vars[p]; //to prevent TweenLite from doing normal tweens on these Bezier values.
			}
			addSubTween(bProxy, {t:0}, {t:1}, {props:parseBeziers(props, true), target:this.target, orientToBezier:this.vars.orientToBezier});
			
		}
		if (this.vars.hexColors != undefined && typeof(this.vars.hexColors) == "object") {
			for (p in this.vars.hexColors) {
				addSubTween(hexColorsProxy, {r:this.target[p] >> 16, g:(this.target[p] >> 8) & 0xff, b:this.target[p] & 0xff}, {r:(this.vars.hexColors[p] >> 16), g:(this.vars.hexColors[p] >> 8) & 0xff, b:(this.vars.hexColors[p] & 0xff)}, {prop:p, target:this.target});
			}
		}
		super.initTweenVals(true, $reservedProps);
	}
	
	public static function parseBeziers($props:Object, $through:Boolean):Object { //$props object should contain a property for each one you'd like bezier paths for. Each property should contain a single array with the numeric point values (i.e. props._x = [12,50,80] and props._y = [50,97,158]). It'll return a new object with an array of values for each property, containing a "s" (start), "cp" (control point), and "e" (end) property. (i.e. returnObject._x = [{s:12, cp:32, e:50}, {s:50, cp:65, e:80}])
		var i:Number, a:Array, b:Object, p:String;
		var all:Object = {};
		if ($through) {
			for (p in $props) {
				a = $props[p];
				all[p] = b = [];
				if (a.length > 2) {
					b.push({s:a[0], cp:a[1] - ((a[2] - a[0]) / 4), e:a[1]});
					for (i = 1; i < a.length - 1; i++) {
						b.push({s:a[i], cp:a[i] + (a[i] - b[i - 1].cp), e:a[i + 1]});
					}
				} else {
					b.push({s:a[0], cp:(a[0] + a[1]) / 2, e:a[1]});
				}
			}
		} else {
			for (p in $props) {
				a = $props[p];
				all[p] = b = [];
				if (a.length > 3) {
					b.push({s:a[0], cp:a[1], e:(a[1] + a[2]) / 2});
					for (i = 2; i < a.length - 2; i++) {
						b.push({s:b[i - 2].e, cp:a[i], e:(a[i] + a[i + 1]) / 2});
					}
					b.push({s:b[b.length - 1].e, cp:a[a.length - 2], e:a[a.length - 1]});
				} else if (a.length == 3) {
					b.push({s:a[0], cp:a[1], e:a[2]});
				} else if (a.length == 2) {
					b.push({s:a[0], cp:(a[0] + a[1]) / 2, e:a[1]});
				}
			}
		}
		return all;
	}
	
	public static function getTweensOf($target:Object):Array {
		var t:Object = _all[getID($target, true)];
		var a:Array = [];
		if(t != null) {
			for (var p:String in t) {
				if (t[p].tweens != undefined) {
					a.push(t[p]);
				}
			}
		}
		return a;
	}
	
	public static function isTweening($target:Object):Boolean {
		var a:Array = getTweensOf($target);
		for (var i:Number = 0; i < a.length; i++) {
			if (a[i].active) {
				return true;
			}
		}
		return false;
	}
	
	public function pause():Void {
		if (_pauseTime == null) {
			_pauseTime = _curTime;
			_active = false;
		}
	}
	
	public function resume():Void {
		if (_pauseTime != null) {
			var gap:Number = _curTime - _pauseTime;
			this.initTime += gap;
			if (this.startTime != undefined) {
				this.startTime += gap;
			}
			_pauseTime = null;
			if ((_curTime - this.initTime) / 1000 > this.delay) {
				_active = true;
			}
		}
	}
		
	public static function getAllTweens():Array {
		var a:Object = _all; //speeds things up slightly
		var all:Array = [];
		var tw, twp, p;
		for (p in a) {
			for (twp in a[p]) {
				tw = a[p][twp];
				if (tw.tweens != undefined) {
					all.push(a[p][twp]);
				}
			}
		}
		return all;
	}
	
	public static function killAllTweens($complete:Boolean):Void {
		killAll($complete, true, false);
	}
	
	public static function killAllDelayedCalls($complete:Boolean):Void {
		killAll($complete, false, true);
	}
	
	public static function killAll($complete:Boolean, $tweens:Boolean, $delayedCalls:Boolean):Void {
		if ($tweens == undefined) {
			$tweens = true;
		}
		if ($delayedCalls == undefined) {
			$delayedCalls = false;
		}
		var a:Array = getAllTweens();
		for (var i:Number = a.length - 1; i > -1; i--) {
			if ((typeof(a[i].target) == "function") == $delayedCalls || (typeof(a[i].target) == "function") != $tweens) {
				if ($complete) {
					a[i].complete();
				} else {
					TweenLite.removeTween(a[i]);
				}
			}
		}
	}
	
	public static function pauseAll($tweens:Boolean, $delayedCalls:Boolean):Void {
		changePause(true, $tweens, $delayedCalls);
	}
	
	public static function resumeAll($tweens:Boolean, $delayedCalls:Boolean):Void {
		changePause(false, $tweens, $delayedCalls);
	}
	
	public static function changePause($pause:Boolean, $tweens:Boolean, $delayedCalls:Boolean):Void {
		if ($pause == undefined) {
			$pause = true;
		}
		if ($tweens == undefined) {
			$tweens = true;
		}
		if ($delayedCalls == undefined) {
			$delayedCalls = false;
		}
		var a:Array = getAllTweens();
		for (var i:Number = a.length - 1; i > -1; i--) {
			if ((typeof(a[i].target) == "function") == $delayedCalls || (typeof(a[i].target) == "function") != $tweens) {
				a[i].paused = $pause;
			}
		}
	}
	
	

//---- PROXY FUNCTIONS ------------------------------------------------------------------------------------------------------------
	
	public static function hexColorsProxy($o:Object):Void {
		$o.info.target[$o.info.prop] = ($o.target.r << 16 | $o.target.g << 8 | $o.target.b);
	}
	public static function bezierProxy($o:Object):Void {
		var factor:Number = $o.target.t;
		var props:Object = $o.info.props;
		var tg:Object = $o.info.target;
		var i:Number, p:String, b:Object, t:Number, segments:Number;
		for (p in props) {
			segments = props[p].length;
			if (factor < 0) {
				i = 0;
			} else if (factor >= 1) {
				i = segments - 1;
			} else {
				i = (segments * factor) >> 0;
			}
			t = (factor - (i * (1 / segments))) * segments;
			b = props[p][i];
			tg[p] = b.s + t * (2 * (1 - t) * (b.cp - b.s) + t * (b.e - b.s));
		}
	}
	
	public static function bezierProxy2($o:Object):Void { //Only for orientToBezier tweens. Separated it for speed.
		bezierProxy($o);
		var future:Object = {};
		var tg:Object = $o.info.target;
		$o.info.target = future;
		$o.target.t += 0.01;
		bezierProxy($o);
		var otb:Array = $o.info.orientToBezier;
		var a:Number, dx:Number, dy:Number, cotb:Array, toAdd:Number;
		for (var i:Number = 0; i < otb.length; i++) {
			cotb = otb[i]; //current orientToBezier array
			toAdd = cotb[3] || 0;
			dx = future[cotb[0]] - tg[cotb[0]];
			dy = future[cotb[1]] - tg[cotb[1]];
			tg[cotb[2]] = Math.atan2(dy, dx) * RAD2DEG + toAdd;
		}
		$o.info.target = tg;
		$o.target.t -= 0.01;
	}
	
	
//---- GETTERS / SETTERS ----------------------------------------------------------------------------------------------------------
	
	public function get active():Boolean {
		if (_active) {
			return true;
		} else if (_pauseTime != null) {
			return false;
		} else if ((_curTime - this.initTime) / 1000 > this.delay) {
			_active = true;
			this.startTime = this.initTime + (this.delay * 1000);
			if (!_initted) {
				initTweenVals();
			} else if (typeof(this.vars.autoAlpha) == "number") {
				this.target._visible = true;
			}
			if (this.duration == 0.001) { //In the constructor, if the duration is zero, we shift it to 0.001 because the easing functions won't work otherwise. We need to offset the startTime to compensate too.
				this.startTime -= 1;
			}
			if (this.vars.onStart != undefined) {
				this.vars.onStart.apply(null, this.vars.onStartParams);
			}
			return true;
		} else {
			return false;
		}
	}
	public function get paused():Boolean {
		if (_pauseTime != null) {
			return true;
		}
		return false;
	}
	public function set paused($b:Boolean):Void {
		if ($b) {
			this.pause();
		} else {
			this.resume();
		}
	}
	public function get progress():Number {
		var n:Number = ((_curTime - this.startTime) / 1000) / this.duration || 0;
		if (n > 1) {
			return 1;
		} else {
			return n;
		}
	}
	public function set progress($n:Number):Void {
		var t:Number = _curTime - ((this.duration * $n) * 1000);
		this.initTime = t - (this.delay * 1000);
		var s:Boolean = this.active; //Just to trigger all the onStart stuff.
		this.startTime = t;
		render(_curTime);
	}
	
}