package app.modules.main.view
{
	import app.data.GameData;
	import app.events.ViewEvent;
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
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, event.viewName ) );
		}
		
		private function updateExpHandler( event:MainUIEvent = null ):void
		{
			view.updateLevelExp( GameData.instance.selfVo.level, GameData.instance.selfVo.exp );
		}
		
	}
}