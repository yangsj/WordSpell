package app.modules.map.main
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapModel;
	import app.modules.map.model.MapVo;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class MapWorldMediator extends BaseMediator
	{
		[Inject]
		public var view:MapWorldView;
		[Inject]
		public var mapModel:MapModel;
		
		public function MapWorldMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 更新地图数据
			addContextListener( MapEvent.UPDATE_MAP_DATA, updateMapDataHandler, MapEvent );
			
			// 选择地图
			addViewListener( MapEvent.OPEN_SELECTED_ROUND, openSelectedRoundHandler, MapEvent );
			
			initData();
		}
		
		private function initData():void
		{
			updateMapDataHandler();
		}
		
		private function updateMapDataHandler( event:MapEvent = null ):void
		{
			var temp:Vector.<MapVo> = new Vector.<MapVo>();
			for (var i:int = 0; i < 6; i++)
			{
				var mapVo:MapVo = new MapVo();
				mapVo.mapId = i;
				mapVo.isOpen = i != 5;
				temp.push( mapVo );
			}
			view.setAndUpdateMap( temp );
		}
		
		private function openSelectedRoundHandler( event:MapEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.SelectedRoundPanel, event.data ));
		}
		
		
	}
}