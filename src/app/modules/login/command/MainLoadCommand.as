package app.modules.login.command
{
	import flash.utils.getTimer;
	
	import app.events.GameEvent;
	import app.events.LoadEvent;
	import app.events.ViewEvent;
	import app.managers.LoaderManager;
	import app.modules.ViewName;
	import app.modules.main.model.MainModel;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	import victor.framework.manager.TickManager;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class MainLoadCommand extends BaseCommand
	{
		[Inject]
		public var mainModel:MainModel;
		
		public function MainLoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			mainModel.startLoadTime = getTimer();
			
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Register ));
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Login ));
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Preloader ));
			LoaderManager.instance.startMainLoad( loaderCompleteCallBack, loaderProgressCallBack );
		}
		
		private function loaderCompleteCallBack():void
		{
			var time:int = 1600 - ( getTimer() - mainModel.startLoadTime );
			if (  time > 0 ) {
				TickManager.doTimeout( tweenCall, time );
			} else {
				tweenCall();
			}
		}
		
		private function tweenCall():void
		{
			Debug.debug( "登陆资源加载完毕！！！" );
			mainModel.hasLoadCompleted = true;
			dispatch( new GameEvent( GameEvent.MAIN_LOAD_COMPLETE ));
		}
		
		private function loaderProgressCallBack( perent:Number ):void
		{
			dispatch( new LoadEvent( LoadEvent.LOAD_PROGRESS, perent ));
		}
	}
}