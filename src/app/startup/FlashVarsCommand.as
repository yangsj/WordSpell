package app.startup
{
	import app.GameConfig;
	import app.events.GameEvent;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class FlashVarsCommand extends BaseCommand
	{
		public function FlashVarsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var parameters:Object = contextView.stage.loaderInfo.parameters;
			
			// 环境部署地址
			if ( parameters.hasOwnProperty( "deployPath" ))
				GameConfig.deployPath = parameters.deployPath;
			
			// debug
			if ( parameters.hasOwnProperty( "debug" ))
				Debug.isDebug = parameters.debug;
			
			// 主机地址
			if ( parameters.hasOwnProperty( "ip" ))
				GameConfig.serverHost = parameters["ip"];
			else GameConfig.serverHost = "112.124.57.159";
			
			// 主机端口号
			if ( parameters.hasOwnProperty( "port" ))
				GameConfig.serverPort = parameters["port"];
			else GameConfig.serverPort = 10242;
			
			dispatch( new GameEvent( GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE ));
			
			setDebug();
		}
		
		private function setDebug():void
		{
			if ( Debug.isDebug )
			{
				// 初始化调试工具
				Debug.initStage( contextView.stage );
			}
		}
		
	}
}