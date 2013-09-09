package app.modules.chat.view
{
	import app.modules.chat.event.ChatEvent;
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatMediator extends BaseMediator
	{
		[Inject]
		public var view:ChatView;
		[Inject]
		public var chatModel:ChatModel;
		
		public function ChatMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			/////////// 全局
			
			// 显示窗口
			addContextListener( ChatEvent.SHOW_CHAT, showViewHandler, ChatEvent );
			// 隐藏窗口
			addContextListener( ChatEvent.HIDE_CHAT, hideViewHandler, ChatEvent );
			// 显示信息
			addContextListener( ChatEvent.UPDATE_MSG, updateMsgHandler, ChatEvent );
			
			/////////// 本地
			
			// 聊天频道改变
			addViewListener( ChatEvent.CHANGE_CHANNEL, changeChannelHandler, ChatEvent );
			//
			addViewListener( ChatEvent.PUSH_MSG, pushMsgHandler, ChatEvent );
		}
		
		private function pushMsgHandler( event:ChatEvent ):void
		{
			var data:Object = event.data;
			var chatVo:ChatVo = new ChatVo();
			chatVo.channel = chatModel.currentChannel;
			chatVo.emoticons = data.emoticons;
			chatVo.msg = data.msg;
			chatVo.playerName = "PlayerName";
			chatVo.playerUid = "123456";
		}
		
		private function changeChannelHandler( event:ChatEvent ):void
		{
			chatModel.currentChannel = int( event.data );
		}
		
		private function updateMsgHandler( event:ChatEvent ):void
		{
			
		}
		
		private function showViewHandler( event:ChatEvent ):void
		{
			view.visible = true;
		}
		
		private function hideViewHandler( event:ChatEvent ):void
		{
			view.visible = false;
		}
		
	}
}