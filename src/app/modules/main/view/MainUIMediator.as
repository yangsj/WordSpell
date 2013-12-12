package app.modules.main.view
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.main.FunctionBtnConfig;
	import app.modules.main.event.MainUIEvent;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.debug.Debug;
	
	
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
			
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_EXP, updateExpHandler, MainUIEvent );
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyHandler, MainUIEvent );
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_PROPERTY, updatePropertyHandler, MainUIEvent );
			
			initData();
		}
		
		private function initData():void
		{
			updateExpHandler();
		}
		
		private function updateExpHandler( event:MainUIEvent = null ):void
		{
			view.updateLevelExp( GameData.instance.selfVo.level, GameData.instance.selfVo.exp );
		}
		
		private function updatePropertyHandler( event:MainUIEvent = null ):void
		{
			updateExpHandler( null );
		}
		
		private function updateMoneyHandler( event:MainUIEvent = null ):void
		{
			updateExpHandler( null );
		}
		
		override protected function showViewHandler( event:ViewEvent ):void
		{
			var viewName:String = event.viewName;
			Debug.debug( "open Function name:" + viewName );
			switch ( viewName )
			{
				case FunctionBtnConfig.FIGHT:
					view.displayFightMenu();
					break;
				case FunctionBtnConfig.EXIT:
					Tips.showMouse( "功能开发中敬请期待！" );
					break;
				default :
					openView( viewName );
			}
		}
		
	}
}