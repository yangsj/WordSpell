package app.modules.chat.model
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-9
	 */
	public class ChatVo
	{
		public function ChatVo()
		{
		}

		private static const channelName:Array = [ "[系统]", "[世界]", "" ];

		/**
		 * 聊天频道
		 */
		public var channel:uint = 0;

		/**
		 * 私聊好友呢称
		 */
		public var playerName:String = "";

		/**
		 * 私聊好友uid
		 */
		public var playerUid:String = "";

		/**
		 * 聊天文字
		 */
		public var msg:String = "";

		/**
		 * 聊天表情
		 */
		public var emoticons:Array = [];

		public function get htmlText():String
		{
			return addHeadMsg + msg;
		}
		
		private function get addHeadMsg():String
		{
			return channelName[ channel ] + playerName + ":";
		}
		
		public function get msgIndex():int
		{
			return addHeadMsg.length + 1;
		}

	}
}
