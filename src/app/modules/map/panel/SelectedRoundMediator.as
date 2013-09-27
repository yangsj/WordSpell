package app.modules.map.panel
{
	import app.core.Tips;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.map.model.MapModel;
	import app.modules.map.panel.event.SelectedRoundEvent;
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
			 addContextListener( SelectedRoundEvent.CHAPTER_DETAIL, chapterDetailNotify, SelectedRoundEvent );
			 
			 // 选择关卡
			 addViewListener( SelectedRoundEvent.SELECTED_ROUND, selectedRoundhandler, SelectedRoundEvent );
			 
			 // 获取数据请求
			 mapService.getChapterDetailInfo( view.mapVo.mapId );
		}
		
		private function chapterDetailNotify( event:SelectedRoundEvent ):void
		{
			view.setData( mapModel.currentMapVo.roundList );
		}
		
		private function selectedRoundhandler( event:SelectedRoundEvent ):void
		{
			trace( event.data );
//			Tips.showMouse( "准备闯关！功能开发中，敬请期待" );
			
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.SelectedRoundPanel ));			
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.FightAlone ));
		}
		
	}
}