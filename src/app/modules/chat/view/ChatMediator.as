package app.modules.chat.view
{
	import app.modules.chat.ChatChannelType;
	import app.modules.chat.event.ChatEvent;
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	import app.modules.chat.service.ChatService;
	
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
		[Inject]
		public var chatService:ChatService;
		
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
			// 与好友私聊
			addContextListener( ChatEvent.CHAT_TO_FRIEND, chatToFriendHandler, ChatEvent );
			
			/////////// 本地
			
			// 聊天频道改变
			addViewListener( ChatEvent.CHANGE_CHANNEL, changeChannelHandler, ChatEvent );
			//
			addViewListener( ChatEvent.PUSH_MSG, pushMsgHandler, ChatEvent );
			//
			addViewListener( ChatEvent.LOCK_CHAT, lockChatHandler, ChatEvent );
			
			// 选中世界频道
			view.selectedWorld();
		}
		
		private function chatToFriendHandler( event:ChatEvent ):void
		{
			view.selectedPrivate();
		}
		
		private function lockChatHandler( event:ChatEvent ):void
		{
			chatModel.isLocked = Boolean(event.data);
		}
		
		private function pushMsgHandler( event:ChatEvent ):void
		{
			var chatVo:ChatVo = event.data as ChatVo;
			chatService.sendRequestMsg( chatVo );
		}
		
		private function changeChannelHandler( event:ChatEvent ):void
		{
			var currentChannel:int = int( event.data );
			chatModel.currentChannel = currentChannel;
			view.setChannelStatus( chatModel.isPrivateChatChannel, chatModel.privateChatFriendVo);
			
			var vecList:Vector.<ChatVo> = chatModel.getCurrentChannelList();
			view.setChannelData( vecList );
		}
		
		private function updateMsgHandler( event:ChatEvent ):void
		{
			view.addMsg( event.data as ChatVo );
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