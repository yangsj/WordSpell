package app.modules.map.command
{
	import app.modules.ViewName;
	import app.modules.map.main.MapWorldMediator;
	import app.modules.map.main.MapWorldView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapInitCommand extends BaseCommand
	{
		public function MapInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			addView( ViewName.MapWorld, MapWorldView, MapWorldMediator );
			
		}
		
	}
}