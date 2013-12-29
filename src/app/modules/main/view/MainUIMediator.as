package app.modules.main.view
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.friend.event.FriendEvent;
	import app.modules.main.FunctionBtnConfig;
	import app.modules.main.event.MainUIEvent;
	import app.modules.task.event.TaskEvent;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.debug.Debug;
	import victor.framework.events.PanelEvent;
	import victor.framework.manager.TickManager;
	
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

			// 检查是否有完成的任务
			TickManager.doTimeout( function abc():void
			{
				// 检查登陆是否有完成任务消息
				dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
				// 检查登陆是否有加好友消息
				dispatch( new FriendEvent( FriendEvent.CHECK_ADD ));
				// 检查好友邀请对战
				dispatch( new PanelEvent( PanelEvent.LOAD_END ));
			}, 1000 );
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
					if ( GameData.instance.selfVo.level < 10 ){
						Tips.showMouse( "等级达到10级开启在线对战功能！！！" );
						return ;
					}
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