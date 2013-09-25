package app.data
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class GameData extends Actor
	{
		////////////////////////////////////////////////////////
		
		private static var _instance:GameData;
		public static function get instance():GameData
		{
			if ( _instance == null )
				new GameData();
			return _instance;
		}

		
		////////////////////////////////////////////////////////
		
		public function GameData()
		{
			if ( _instance )
				throw new Error("GameData重复创建！！！");
			_instance = this;
		}
		
		////////////////////////////////////////////////////////
		
		/**
		 * 玩家自己的数据
		 */
		public var selfVo:PlayerSelfVo;
		
		////////////////////////////////////////////////////////
		
		private var _hasSelfVo:Boolean = true;
		
		///////////////////////////////////////////////////////
		
		/**
		 * 是否获取到玩家自己的数据
		 */
		public function get hasSelfVo():Boolean
		{
			return _hasSelfVo;
		}
		
		/**
		 * @private
		 */
		public function set hasSelfVo(value:Boolean):void
		{
			_hasSelfVo = _hasSelfVo ? true : value;
		}

	}
}