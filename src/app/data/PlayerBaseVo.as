package app.data
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class PlayerBaseVo extends Actor
	{
		public function PlayerBaseVo()
		{
			super();
		}
		
		///////////////////////////////////////////////////////
		
		private var _name:String = "凌云";
		private var _uid:int;
		private var _exp:int;
		private var _level:int;
		
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
		public function get uid():int
		{
			return _uid;
		}
		
		/**
		 * @private
		 */
		public function set uid(value:int):void
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