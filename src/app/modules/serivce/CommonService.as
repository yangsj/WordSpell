package app.modules.serivce
{
	import app.core.Alert;
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.main.event.MainUIEvent;
	import app.modules.model.PackModel;
	
	import ff.error_code_ret_t;
	import ff.msg_defConstants;
	import ff.server_cmd_e;
	import ff.update_property_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.debug.Debug;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-15
	 */
	public class CommonService extends BaseService
	{
		[Inject]
		public var packModel:PackModel;
		
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
			GameData.instance.updateLevel( data.level );
			GameData.instance.selfVo.money = data.coin;
			GameData.instance.selfVo.rightWordsNum = data.right_words_num;
			GameData.instance.selfVo.wrongWordsNum = data.wrong_words_num;
			
//			// 道具数量
//			var dict:Dictionary = data.items;
//			for ( var key:* in dict )
//				packModel.addNumByType( int( key ), dict[ key ] );
			
			dispatch( new MainUIEvent( MainUIEvent.UPDATE_PROPERTY ));
		}
		
		private function errorCodeNotify(  resp:SocketResp ):void
		{
			var data:error_code_ret_t = resp.data as error_code_ret_t;
			var errorCode:int = data.error_code;
//			errorHandler( data.error_code );
			var msg:String = data.error_msg;
			if ( !msg ) {
				msg = msg_defConstants.error_code_desc[errorCode];
			}
			
			if ( Debug.isDebug )
				msg += "[错误代码：" + errorCode + "]";
			if ( false )
				Tips.showCenter( msg );
			else Alert.show( msg );
		}
		
	}
}