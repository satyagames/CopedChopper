class terrysTextFunctionClass {
	
	public function terrysTextFunctionClass() {
		trace("terrysTextFunctionClass inited")
	}
	public static function processNumber(_num:Number):String{
		if (_num<100) {
			var outputString = _num.toString();

		} else {

			var outputString = "";
			var sourceString:String = _num.toString();
			var tn:Number = sourceString.length;
			var split = (tn/3);
			var flatSplit = Math.floor(tn/3);
			var diff = tn-(flatSplit*3);
			var currentNum = 0;
			if (diff>0) {
				outputString += sourceString.slice(currentNum, diff)+",";
				sourceString = sourceString.slice(diff, tn);
			}
			for (var i=0; i<flatSplit; i++) {
				var p1:Number = i*3;
				var p2:Number = p1+3;

				if (i>0) {
					outputString += ",";
				}
				outputString += sourceString.slice(p1, p2);
			}
		}
		return outputString;
	}
}