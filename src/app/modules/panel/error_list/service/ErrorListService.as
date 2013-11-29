package app.modules.panel.error_list.service
{
	import app.modules.panel.error_list.event.ErrorListEvent;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListService extends BaseService
	{
		public function ErrorListService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			
		}
		
		private function getSuccessedNotify( resp:SocketResp ):void
		{
			
			dispatch( new ErrorListEvent( ErrorListEvent.GET_LIST_SUCCESSED ));
		}
		
		public function getErrorList():void
		{
			dispatch( new ErrorListEvent( ErrorListEvent.GET_LIST_SUCCESSED ));
		}
		
	}
}