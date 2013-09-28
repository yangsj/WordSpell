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
		/**
		 * 是否获取地图数据
		 */
		public var hasMapList:Boolean;
		
		private var _currentMapVo:MapVo;
		private var _currentRoundVo:RoundVo;
		private var _currentChapterVo:ChapterVo;
		private var _mapList:Vector.<MapVo>;
		
		public function MapModel()
		{
			super();
		}
		
		public function updateMapVo( mapVo:MapVo ):void
		{
			
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

		public function get mapList():Vector.<MapVo>
		{
			return _mapList;
		}

		public function set mapList(value:Vector.<MapVo>):void
		{
			_mapList = value;
		}

		/**
		 * 选中章节数据
		 */
		public function get currentChapterVo():ChapterVo
		{
			return _currentChapterVo;
		}

		/**
		 * @private
		 */
		public function set currentChapterVo(value:ChapterVo):void
		{
			_currentChapterVo = value;
		}
		

	}
}