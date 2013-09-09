package app.modules.chat.model
{
	import app.modules.chat.event.ChatEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatModel extends Actor
	{
		private var _currentChannel:uint;
		
		private var _historyMsg:Vector.<Vector.<ChatVo>> = new Vector.<Vector.<ChatVo>>();
		
		public function ChatModel()
		{
			super();
		}
		
		public function addMsg(chatVo:ChatVo):void
		{
			var array:Vector.<ChatVo> = _historyMsg[ chatVo.channel ] ||= new Vector.<ChatVo>();
			array.push( chatVo );
			if ( _currentChannel == chatVo.channel )
			{
				dispatch( new ChatEvent( ChatEvent.UPDATE_MSG, chatVo ));
			}
		}
		
		public function getCurrentChannelList():Vector.<ChatVo>
		{
			return _historyMsg[_currentChannel];
		}
		
		/**
		 * 当前聊天频道
		 */
		public function get currentChannel():uint
		{
			return _currentChannel;
		}

		/**
		 * @private
		 */
		public function set currentChannel(value:uint):void
		{
			_currentChannel = value;
		}

	}
}