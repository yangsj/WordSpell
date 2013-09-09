package app.modules.login.command
{
	import app.events.GameEvent;
	import app.events.LoadEvent;
	import app.events.ViewEvent;
	import app.managers.LoaderManager;
	import app.modules.ViewName;
	import app.utils.log;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class MainLoadCommand extends BaseCommand
	{
		public function MainLoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Preloader ));
			LoaderManager.instance.startMainLoad( loaderCompleteCallBack, loaderProgressCallBack );
		}
		
		private function loaderCompleteCallBack():void
		{
			log( "登陆资源加载完毕！！！" );
			dispatch( new GameEvent( GameEvent.MAIN_LOAD_COMPLETE ));
		}
		
		private function loaderProgressCallBack( perent:Number ):void
		{
			log ( "loaderProgressCallBack: " + perent );
			dispatch( new LoadEvent( LoadEvent.LOAD_PROGRESS, perent ));
		}
	}
}