package app.startup
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class EnterGameCommand extends BaseCommand
	{
		public function EnterGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var displayView:Array = [ ViewName.MainUI, ViewName.MapWorld, ViewName.Chat ];
			
			for each (var viewName:String in displayView )
				dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, viewName ));
				
			// 关闭Preloader
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Preloader ));
			
		}
		
	}
}