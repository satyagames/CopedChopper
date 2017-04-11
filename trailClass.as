import flash.geom.Point;
class trailClass{
		public function trailClass(_newx:Number,_newy:Number, _clip:MovieClip,_newAngle:Number,_newSpeed:Number) {
		//trace("creature exists")
		loc = new Point(_newx,_newy)
		clip = _clip
		angle = _newAngle
		speed = _newSpeed
		life = 40
		remove = false
		clip._x = _newx
		clip._y = _newy
		//clip.gotoAndStop(Math.floor(Math.random()*5)+1)
		clip._yscale = clip._xscale = 100+ Math.random()*50
		alphaFade = 100 / life
		
	}
	public function getClip():MovieClip {
		return clip
	}
	public function getRemoveState():Boolean {
		return remove
	}
	public function manageTrail():Void {
		radians = angle/180*Math.PI
		clip._rotation = radians * 180 / Math.PI;
		xspeed = Math.cos(radians) * speed
		
		yspeed = Math.sin(radians) * speed
		loc.x += xspeed
		loc.y += yspeed
		clip._x = loc.x
		clip._y = loc.y
		clip._alpha -=alphaFade
		life --
		if (life < 1) {
			remove = true
		}
	}

	
	private var clip:MovieClip
	private var loc:Point	
	private var targetNum:Number // the number (a reference to an array) of the current target
	private var angle:Number // the point of the current target
	private var speed:Number // the speed at which the creature moves
	private var xspeed:Number // the amount at which the creature moves along the x
	private var yspeed:Number // the amount at which the creature moves along the y

	private var remove:Boolean 
	private var life:Number 
	private var radians:Number 
	private var alphaFade:Number

}