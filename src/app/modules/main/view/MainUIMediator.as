package app.modules.main.view
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.main.FunctionBtnConfig;
	import app.modules.main.event.MainUIEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIMediator extends BaseMediator
	{
		[Inject]
		public var view:MainUIView;
		
		public function MainUIMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 打开功能面板
			addViewListener( ViewEvent.SHOW_VIEW, showViewHandler, ViewEvent );
			
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_EXP, updateExpHandler, MainUIEvent );
			
			initData();
		}
		
		private function initData():void
		{
			updateExpHandler();
		}
		
		private function showViewHandler( event:ViewEvent ):void
		{
			var viewName:String = event.viewName;
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, viewName ) );
			if ( viewName == FunctionBtnConfig.FIGHT )
			{
				Tips.showMouse( "功能开发中敬请期待！" );
			}
			else if ( viewName == FunctionBtnConfig.PRACTICE )
			{
				Tips.showMouse( "功能开发中敬请期待！" );
			}
			else if ( viewName == FunctionBtnConfig.EXIT )
			{
				Tips.showMouse( "功能开发中敬请期待！" );
			}
		}
		
		private function updateExpHandler( event:MainUIEvent = null ):void
		{
			view.updateLevelExp( GameData.instance.selfVo.level, GameData.instance.selfVo.exp );
		}
		
	}
}