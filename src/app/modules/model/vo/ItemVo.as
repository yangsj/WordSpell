package app.modules.model.vo
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class ItemVo
	{
		public function ItemVo()
		{
		}
		
		/**
		 * 
		 */
		public var type:int;
		
		private var _num:int;
		
		/**
		 * 使用间隔时间( 秒 )
		 */
		public function get intervalTime():int
		{
			return 10;
		}
		/**
		 * 需要消耗的金币值（无可用道具时使用）
		 */
		public function get contMoney():int
		{
			return [ 0, 500, 600, 1000, 500 ][ type ];
		}
		
		/**
		 * 皮肤名称
		 */
		public function get skinId():String
		{
			return "ui_Skin_Round_PropItem_" + type;
		}

		/**
		 * 数量
		 */
		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = Math.max( 0, value );
		}
		
		/**
		 * 道具名称
		 */
		public function get name():String
		{
			return ["提示", "扫帚", "跳过", "加时", "炸弹"][type];
		}

		
	}
}