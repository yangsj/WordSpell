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
		
		///////////////////////////////////////////////////////
		
		private var _name:String;
		private var _uid:String;
		private var _exp:int;
		private var _level:int;
		
		////////////////////////////////////////////////////////
		
		public function GameData()
		{
			if ( _instance )
				throw new Error("GameData重复创建！！！");
			_instance = this;
		}

		////////////////////////////////////////////////////////
		
		/**
		 * 玩家名称
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			_name = value;
		}

		/**
		 * 玩家uid
		 */
		public function get uid():String
		{
			return _uid;
		}

		/**
		 * @private
		 */
		public function set uid(value:String):void
		{
			_uid = value;
		}

		/**
		 * 玩家当前经验
		 */
		public function get exp():int
		{
			return _exp;
		}

		/**
		 * @private
		 */
		public function set exp(value:int):void
		{
			_exp = value;
		}

		/**
		 * 玩家等级
		 */
		public function get level():int
		{
			return _level;
		}

		/**
		 * @private
		 */
		public function set level(value:int):void
		{
			_level = value;
		}

	}
}