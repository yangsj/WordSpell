package app.modules.serivce
{
	import ff.error_code_ret_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-15
	 */
	public class CommonService extends BaseService
	{
		public function CommonService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 错误提示
			regist(server_cmd_e.ERROR_CODE_RET, errorCodeNotify, error_code_ret_t );
		}
		
		private function errorCodeNotify(  resp:SocketResp ):void
		{
			var data:error_code_ret_t = resp.data as error_code_ret_t;
			errorHandler( data.error_code );
		}
		
	}
}