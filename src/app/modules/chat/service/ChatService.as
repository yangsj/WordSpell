package app.modules.chat.service
{
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	
	import ff.chat_msg_req_t;
	import ff.chat_msg_ret_t;
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatService extends BaseService
	{
		[Inject]
		public var chatModel:ChatModel;
		
		public function ChatService()
		{
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.CHAT_RET, chatNotify, chat_msg_ret_t );
		}
		
		private function chatNotify(  res:SocketResp ):void
		{
			trace( res.data );
			var data:chat_msg_ret_t = res.data as chat_msg_ret_t;
			var chatVo:ChatVo = new ChatVo();
			chatVo.channel = 1;
			chatVo.msg = data.value;
			chatModel.addMsg( chatVo );
		}
		
		public function sendRequestMsg(chatVo:ChatVo):void
		{
			var req:chat_msg_req_t = new chat_msg_req_t();
			req.value = chatVo.msg;
			call( client_cmd_e.CHAT_REQ, req );
		}
		
	}
}