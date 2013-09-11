package app.modules.chat.service
{
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	
	import victor.framework.core.BaseService;
	
	
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
		
		public function sendRequestMsg(chatVo:ChatVo):void
		{
			chatVo.playerName = "凌云";
			chatModel.addMsg( chatVo );
		}
		
	}
}