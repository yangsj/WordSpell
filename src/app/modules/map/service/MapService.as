package app.modules.map.service
{
	import app.events.GameEvent;
	import app.modules.map.model.MapModel;
	
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
		[Inject]
		public var mapModel:MapModel;
		
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
			
			
			// 获取到数据检查是否进入游戏（登陆时检查一次）
			if ( mapModel.hasMapList == false )
			{
				mapModel.hasMapList = true;
				dispatch( new GameEvent( GameEvent.ACQUIRE_MAP_DATA ));
			}
		}
		
	}
}