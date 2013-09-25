package app
{
	import flash.display.DisplayObjectContainer;
	
	import app.events.GameEvent;
	import app.events.ServiceEvent;
	import app.modules.login.command.FirstLoadCommand;
	import app.modules.login.command.MainLoadCommand;
	import app.startup.EnterGameCommand;
	import app.startup.FlashVarsCommand;
	import app.startup.InitCommand;
	import app.startup.InitDataCommand;
	import app.startup.InitServiceCommand;
	import app.startup.ShowLoginCommand;
	import app.utils.appStage;
	
	import org.robotlegs.base.ContextEvent;
	
	import victor.framework.core.BaseContext;
	import victor.framework.core.ViewStruct;
	import victor.framework.manager.TickManager;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class AppContext extends BaseContext
	{
		public function AppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			initManager();
			addStartupCommand()
			
			super.startup();
		}
		
		private function initManager() : void
		{
			// 初始化视图结构管理器
			ViewStruct.initialize( contextView );
			
			// 计时器管理器
			TickManager.instance.init( appStage.frameRate );
		}
		
		private function addStartupCommand() : void
		{
			// 解析传flash的参数值
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, FlashVarsCommand, ContextEvent, true);
			
			// 初始化网络
			commandMap.mapEvent(GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE, InitServiceCommand, GameEvent, true);
			
			// 初始化command
			commandMap.mapEvent(GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE, InitCommand, GameEvent, true);
			
			// 初始化application资源数据
			commandMap.mapEvent(ServiceEvent.CONNECTED, InitDataCommand, ServiceEvent, true);
			
			// 开始第一阶段资源加载
			commandMap.mapEvent(GameEvent.DATA_INIT_COMPLETE, FirstLoadCommand, GameEvent, true );
			
			// 进入登陆/注册界面
			commandMap.mapEvent(GameEvent.FIRST_LOAD_COMPLETE, ShowLoginCommand, GameEvent, true );
			
			// 登陆成功后加载进入游戏主资源
			commandMap.mapEvent(GameEvent.LOGIN_SUCCESSED, MainLoadCommand, GameEvent, true );
			
			//********** 以下几个条件检查是否进入游戏
			
			// 资源加载完成进入游戏场景检查
			commandMap.mapEvent(GameEvent.MAIN_LOAD_COMPLETE, EnterGameCommand, GameEvent, true);
			
			// 玩家数据获取到进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_PLAYER_DATA, EnterGameCommand, GameEvent, true);
			
			// 地图数据获取到进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_MAP_DATA, EnterGameCommand, GameEvent, true);
			
			// 获取到好友列表数据进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_FRIEND_DATA, EnterGameCommand, GameEvent, true);
			
			// 获取到任务数据进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_TASK_DATA, EnterGameCommand, GameEvent, true);
			
			//*********** 登陆数据拉取及加载进度检查
			
			
		}
		
	}
}