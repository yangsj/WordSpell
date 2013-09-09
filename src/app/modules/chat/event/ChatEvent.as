package app.modules.chat.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatEvent extends BaseEvent
	{
		public function ChatEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 显示聊天窗口
		 */
		public static const SHOW_CHAT:String = "show_chat";
		/**
		 * 隐藏聊天窗口
		 */
		public static const HIDE_CHAT:String = "hide_chat";
		/**
		 * 发送消息到聊天窗口
		 */
		public static const SEND_MSG:String = "send_msg";
		/**
		 * 将消息发到服务器
		 */
		public static const PUSH_MSG:String = "push_msg";
		/**
		 * 聊天窗口更新
		 */
		public static const UPDATE_MSG:String = "update_msg";
		/**
		 * 更改频道
		 */
		public static const CHANGE_CHANNEL:String = "change_channel";
		/**
		 * 输入表情
		 */
		public static const INPUT_EMOTION:String = "input_emotion";
		
	}
}