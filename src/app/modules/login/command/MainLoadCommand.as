package app.modules.login.command
{
	import app.modules.ViewName;
	import app.modules.main.model.MainModel;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	import victor.framework.events.LoadEvent;
	import victor.framework.events.PanelEvent;
	import victor.framework.manager.LoaderManager;
	
	
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
			closeView( ViewName.Register );
			closeView( ViewName.Login );
			openView( ViewName.Preloader, 2 );
			LoaderManager.instance.startMainLoad( loaderCompleteCallBack, loaderProgressCallBack );
			
			dispatch( new PanelEvent( PanelEvent.LOAD_START ));
		}
		
		private function loaderCompleteCallBack():void
		{
			Debug.debug( "登陆资源加载完毕！！！" );
			mainModel.hasLoadCompleted = true;
		}
		
		private function loaderProgressCallBack( perent:Number ):void
		{
			dispatch( new LoadEvent( LoadEvent.LOAD_PROGRESS, perent ));
		}
	}
}