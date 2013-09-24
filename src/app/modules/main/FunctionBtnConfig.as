package app.modules.main
{
	import app.modules.ViewName;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class FunctionBtnConfig
	{
		public function FunctionBtnConfig()
		{
		}
		
		public static const functionBtnsList:Array = [ FRIEND, TASK, PERSONAL ];
		
		/**
		 * 好友
		 */
		public static const FRIEND:String = ViewName.Friend;
		
		/**
		 * 任务
		 */
		public static const TASK:String = ViewName.Task;
		
		/**
		 * 个人信息
		 */
		public static const PERSONAL:String = ViewName.Personal;
		
	}
}