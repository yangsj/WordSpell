package app.modules.serivce
{
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemVo;
	
	import ff.item_t;
	import ff.pack_info_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class PackService extends BaseService
	{
		[Inject]
		public var packModel:PackModel;
		
		public function PackService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.PACK_INFO_RET, packInfoNotify, pack_info_t );
		}
		
		private function packInfoNotify( resp:SocketResp ):void
		{
			var data:pack_info_t = resp.data as pack_info_t;
			var itemList:Array = data.item_list;
			var itemVo:ItemVo;
			for each ( var item:item_t in itemList )
			{
				itemVo = new ItemVo();
				itemVo.id = item.item_id;
				itemVo.type = item.item_type;
				itemVo.num = item.item_num;
				
				packModel.updateItem( itemVo );
			}
		}
		
		
	}
}