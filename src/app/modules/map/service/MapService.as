package app.modules.map.service
{
	import ff.game_info_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapService extends BaseService
	{
		public function MapService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.GAME_INFO_RET, mapDataNotify, game_info_t );
		}
		
		private function mapDataNotify( resp:SocketResp ):void
		{
			var data:game_info_t = resp.data as game_info_t;
			
		}
		
	}
}