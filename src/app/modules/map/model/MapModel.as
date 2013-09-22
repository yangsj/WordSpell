package app.modules.map.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapModel extends Actor
	{
		private var _currentMapVo:MapVo;
		private var _currentRoundVo:RoundVo;
		
		public function MapModel()
		{
			super();
		}

		public function get currentMapVo():MapVo
		{
			return _currentMapVo;
		}

		public function set currentMapVo(value:MapVo):void
		{
			_currentMapVo = value;
		}

		public function get currentRoundVo():RoundVo
		{
			return _currentRoundVo;
		}

		public function set currentRoundVo(value:RoundVo):void
		{
			_currentRoundVo = value;
		}
		

	}
}