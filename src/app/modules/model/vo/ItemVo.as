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
		public var id:int;
		public var type:int;
		public var num:int;
		
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
			return [ 0, 500, 600, 1000, 500 ][ id ];
		}
		
		/**
		 * 皮肤名称
		 */
		public function get skinId():String
		{
			return "ui_Skin_Round_PropItem_" + id;
		}
		
	}
}