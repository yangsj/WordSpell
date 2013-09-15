package app.modules.chat.model
{
	import flash.utils.Dictionary;

	import app.modules.chat.ChatChannelType;
	import app.modules.chat.event.ChatEvent;

	import org.robotlegs.mvcs.Actor;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-6
	 */
	public class ChatModel extends Actor
	{
		private const MAX_LENGTH:int = 100;

		private var _currentChannel:uint;
		private var _isLocked:Boolean = false;

		private var _historyMsg:Dictionary = new Dictionary();

		public function ChatModel()
		{
			super();
		}

		public function addMsg( chatVo:ChatVo ):void
		{
			if ( isLocked )
				return;

			var isSystem:Boolean = chatVo.channel == ChatChannelType.SYSTEM;

			var array:Vector.<ChatVo> = _historyMsg[ isSystem ? ChatChannelType.WORLD : chatVo.channel ] ||= new Vector.<ChatVo>();
			array.push( chatVo );
			if ( array.length > MAX_LENGTH )
			{
				array.shift();
			}
			if ( _currentChannel == chatVo.channel || ( isSystem && _currentChannel == ChatChannelType.WORLD ))
			{
				dispatch( new ChatEvent( ChatEvent.UPDATE_MSG, chatVo ));
			}
		}

		public function getCurrentChannelList():Vector.<ChatVo>
		{
			return _historyMsg[ _currentChannel ];
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
		public function set currentChannel( value:uint ):void
		{
			_currentChannel = value;
		}

		/**
		 * 聊天窗口是否锁定
		 */
		public function get isLocked():Boolean
		{
			return _isLocked;
		}

		/**
		 * @private
		 */
		public function set isLocked( value:Boolean ):void
		{
			_isLocked = value;
		}


	}
}
