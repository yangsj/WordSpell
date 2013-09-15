package app.modules.chat.model
{
	import app.Language;

	/**
	 * ����
	 * @author 	yangsj
	 * 			2013-9-9
	 */
	public class ChatVo
	{
		public function ChatVo()
		{
		}

		/** 聊天频道名称 */
		private static var _channelName:Array;
		private static function get channelName():Array
		{
			return _channelName ||= Language.lang( Language.ChatVo_0 ).split("|");
		}

		/**
		 * 频道
		 */
		public var channel:uint = 0;

		/**
		 * 玩家名称
		 */
		public var playerName:String = "";

		/**
		 * 玩家id
		 */
		public var playerUid:String = "";

		/**
		 * 发送的信息
		 */
		public var msg:String = "";

		/**
		 * 发送的表情
		 */
		public var emoticons:Array = [];

		/**
		 * 获取文字部分内容
		 */
		public function get htmlText():String
		{
			return addHeadMsg + msg;
		}
		
		/**
		 * 额外增加的表情插入位
		 */
		public function get addIndex():int
		{
			return addHeadMsg.length + 1;
		}
		
		private function get addHeadMsg():String
		{
			return channelName[ channel ] + playerName + ":";
		}

	}
}