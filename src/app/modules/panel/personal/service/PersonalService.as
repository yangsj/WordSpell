package app.modules.panel.personal.service
{
	import app.modules.panel.personal.model.PersonalModel;
	import app.modules.panel.personal.events.PersonalEvent;
	
	import ff.client_cmd_e;
	import ff.get_wrong_history_req_t;
	import ff.get_wrong_history_ret_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalService extends BaseService
	{
		[Inject]
		public var personalModel:PersonalModel;
		
		public function PersonalService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.GET_WRONG_HISTORY_RET, getSuccessedNotify, get_wrong_history_ret_t );
		}
		
		private function getSuccessedNotify( resp:SocketResp ):void
		{
			var data:get_wrong_history_ret_t = resp.data as get_wrong_history_ret_t;
			
			personalModel.englshList = data.wrong_words;
			personalModel.chineseList = data.chinese;
			
			dispatch( new PersonalEvent( PersonalEvent.ERROR_LIST_SUCCESSED ));
		}
		
		/**
		 * 获取错误单词列表
		 */
		public function getErrorList():void
		{
			var req:get_wrong_history_req_t = new get_wrong_history_req_t();
			call( client_cmd_e.GET_WRONG_HISTORY_REQ, req );
		}
		
		/**
		 * 更改个人信息
		 */
		public function changeInfo():void
		{
			
		}
		
	}
}