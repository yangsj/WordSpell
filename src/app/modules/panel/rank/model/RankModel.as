package app.modules.panel.rank.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankModel extends Actor
	{
		private var _list:Vector.<RankVo> = new Vector.<RankVo>();
		
		public function RankModel()
		{
			super();
		}
		
		
		/**
		 * 列表
		 */
		public function get list():Vector.<RankVo>
		{
			return _list;
		}

		/**
		 * @private
		 */
		public function set list(value:Vector.<RankVo>):void
		{
			_list = value;
		}

	}
}