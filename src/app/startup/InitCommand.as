package app.startup
{
	import flash.events.Event;
	
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.chat.command.ChatInitCommand;
	import app.modules.fight.command.FightInitCommand;
	import app.modules.friend.command.FriendInitComand;
	import app.modules.friend.view.rightMenu.RightMenu;
	import app.modules.friend.view.rightMenu.RightMenuMediator;
	import app.modules.login.command.LoginInitCommand;
	import app.modules.main.command.MainUIInitCommand;
	import app.modules.main.model.MainModel;
	import app.modules.map.command.MapInitCommand;
	import app.modules.model.CommonModel;
	import app.modules.model.PackModel;
	import app.modules.panel.personal.command.PersonalInitCommand;
	import app.modules.panel.test.TestInitCommand;
	import app.modules.serivce.CommonService;
	import app.modules.serivce.PackService;
	import app.modules.task.command.TaskInitCommand;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.drag.DragManager;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitCommand extends BaseCommand
	{
		// 初始化
		private static const INIT_COMMAND:String = "init_command";
		
		private static var commands:Array = 
			[
				, TestInitCommand
				, MainUIInitCommand		// 主界面UI
				, MapInitCommand		// 世界地圖
				, TaskInitCommand		// 任务系统
				, ChatInitCommand		// 聊天系统
				, FriendInitComand		// 好友系统
				, LoginInitCommand		// 登陆游戏
				, PersonalInitCommand	// 个人信息
				, FightInitCommand		// 对战闯关系统
			];
		
		public function InitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//************  add events ************************************************//
			// 监听打开视图
			commandMap.mapEvent( ViewEvent.SHOW_VIEW, ShowViewCommand, ViewEvent );
			// 监听关闭视图
			commandMap.mapEvent( ViewEvent.HIDE_VIEW, ShowViewCommand, ViewEvent );
			
			//////////////
			
			injector.mapValue( DragManager, DragManager.instance );
			
			injector.mapValue( GameData, GameData.instance );
			
			/////////////
			
			injectActor( MainModel );
			injectActor( CommonModel );
			injectActor( PackModel );
			
			//////////////
			
			injectActor( CommonService );
			injectActor( PackService );
			
			//************  initlialize commands ************************************************//
			// 初始化 command
			var len:int = commands.length;
			var initCommandClass:Class;
			for ( var i:int = 0; i < len; i++ )
			{
				initCommandClass = commands[ i ];
				if ( initCommandClass )
					commandMap.mapEvent( INIT_COMMAND, initCommandClass, Event, true );
			}
			dispatch( new Event( INIT_COMMAND ));
			
			//////////////
			
			addView( "", RightMenu, RightMenuMediator );
		}
		
	}
}