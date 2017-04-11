
	import flash.geom.Point;
	
	 class trigClass {
		
		private var dx:Number
		private var dy:Number
		private var dist:Number
		private var radians:Number
		private var angle:Number
		private var tempPoint:Point
		
		public function trigClass() {
			trace("trigClass init")
		}
		
		public function findDistance(_point1:Point, _point2:Point):Number {
			// returns the distance from _point1 to _point2
			dx = _point1.x - _point2.x;
			dy = _point1.y - _point2.y;
			dist = Math.floor(Math.sqrt(dx * dx + dy * dy)); 
			return dist
		}
		public function findAngle(_point1:Point, _point2:Point):Number {
			// returns the angle from _point1 to _point2
			dx = _point1.x - _point2.x;
			dy = _point1.y - _point2.y;
			radians = Math.atan2(dy, dx)
			angle = radians * 180 / Math.PI
			return angle
		}
		public function findRadians(_point1:Point, _point2:Point):Number {
			// returns the radians from _point1 to _point2
			dx = _point1.x - _point2.x;
			dy = _point1.y - _point2.y;
			radians = Math.atan2(dy, dx)
			return radians
		}
		public function findXYSpeed(_rot:Number,_speed:Number):Point {
			radians = _rot/180*Math.PI
			tempPoint = new Point()
			tempPoint.x = Math.cos(radians)* _speed
			tempPoint.y = Math.sin(radians) * _speed
			return tempPoint
		}
	}
