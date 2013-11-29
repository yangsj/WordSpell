package app.modules.panel.error_list.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListModel extends Actor
	{
		private var _list:Vector.<ErrorListVo>;
		
		public function ErrorListModel()
		{
			super();
			clearList();
		}
		
		public function clearList():void
		{
			_list ||= new Vector.<ErrorListVo>();
			_list.length = 0;
		}
		
		public function addVo( value:ErrorListVo ):void
		{
			_list.push( value );
		}

		public function get list():Vector.<ErrorListVo>
		{
			return _list;
		}

	}
}