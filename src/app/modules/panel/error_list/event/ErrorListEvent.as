package app.modules.panel.error_list.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListEvent extends BaseEvent
	{
		public function ErrorListEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 成功获取到列表数据
		 */
		public static const GET_LIST_SUCCESSED:String = "get_list_successed";
		
		/**
		 * 开始发请求数据
		 */
		public static const TO_SEND_REQ:String = "to_send_req";
		
	}
}