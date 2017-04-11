class soundManager {
	public function soundManager(_clip:MovieClip) {
		mysoundobj = new Sound(_clip);
	}
	public static function playSound(_soundLinkageRef:String):Void {
		//trace("PLAY SOUND: "+_soundLinkageRef);
		mysoundobj.attachSound(_soundLinkageRef);
		mysoundobj.start()
	}
	private static var mysoundobj:Sound;
}
