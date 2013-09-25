package app.modules.map.panel
{
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapModel;
	import app.modules.map.service.MapService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundMediator extends BaseMediator
	{
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var mapService:MapService;
		[Inject]
		public var view:SelectedRoundView;
		
		public function SelectedRoundMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 获取详息数据
			 addContextListener( MapEvent.CHAPTER_DETAIL, chapterDetailNotify, MapEvent );
			 
			 
			 // 获取数据请求
			 mapService.getChapterDetailInfo( view.mapVo.mapId );
		}
		
		private function chapterDetailNotify( event:MapEvent ):void
		{
			view.setData( mapModel.currentMapVo.roundList );
		}
		
	}
}