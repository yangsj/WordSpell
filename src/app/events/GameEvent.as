package app.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class GameEvent extends BaseEvent
	{
		public function GameEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 参数解析完成
		 */
		public static const ANALYTIC_WEB_PARAMS_COMMPLETE:String = "analytic_web_params_commplete";
		
		/**
		 * 资源application管理数据初始化完成
		 */
		public static const DATA_INIT_COMPLETE:String = "data_init_complete";
		
		/**
		 * 第一阶段资源加载完成
		 */
		public static const FIRST_LOAD_COMPLETE:String = "first_load_complete";
		
		/**
		 * 主资源加载完成
		 */
		public static const MAIN_LOAD_COMPLETE:String = "main_load_complete";
		
		/**
		 * 登陆成功的
		 */
		public static const LOGIN_SUCCESSED:String = "login_successed";
		
	}
}