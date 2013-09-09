package app.startup
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class ShowLoginCommand extends BaseCommand
	{
		public function ShowLoginCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Login ));
		}
		
	}
}