package app.modules.serivce
{
	import app.data.GameData;
	import app.modules.main.event.MainUIEvent;
	
	import ff.error_code_ret_t;
	import ff.server_cmd_e;
	import ff.update_property_ret_t;
	
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
			
			// gm
			regist(server_cmd_e.UPDATE_PROPERTY_RET, updatePropertyNotify, update_property_ret_t );
		}
		
		private function updatePropertyNotify( resp:SocketResp ):void
		{
			var data:update_property_ret_t = resp.data as update_property_ret_t;
			GameData.instance.selfVo.exp = data.exp;
			GameData.instance.selfVo.level = data.level;
			GameData.instance.selfVo.money = data.coin;
			// 道具数量
			
			dispatch( new MainUIEvent( MainUIEvent.UPDATE_PROPERTY ));
		}
		
		private function errorCodeNotify(  resp:SocketResp ):void
		{
			var data:error_code_ret_t = resp.data as error_code_ret_t;
			errorHandler( data.error_code );
		}
		
	}
}