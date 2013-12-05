package app.modules.map.panel
{
	import app.core.Alert;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.map.model.MapModel;
	import app.modules.map.model.RoundVo;
	import app.modules.map.panel.event.SelectedRoundEvent;
	import app.modules.map.service.MapService;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.events.PanelEvent;
	
	
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
			 // 关闭
			 addViewListener( PanelEvent.CLOSE, closeHandler, PanelEvent );
			 
			 // 获取数据请求
			 mapService.getChapterDetailInfo( view.mapVo.mapId );
		}
		
		private function closeHandler( event:PanelEvent ):void
		{
			mapModel.isNeddOpenFromFight = false;
		}
		
		private function chapterDetailNotify( event:SelectedRoundEvent ):void
		{
			view.setData( mapModel.currentMapVo.chapterList );
		}
		
		private function selectedRoundhandler( event:SelectedRoundEvent ):void
		{
			Alert.show( "模式选择", callback, "闯  关", "练  习", "" );
			function callback( type :int ):void
			{
				if ( type != Alert.CLOSE )
				{
					var roundVo:RoundVo = event.data as RoundVo;
					mapModel.currentRoundVo = roundVo;
					mapModel.isNeddOpenFromFight = true;
					mapModel.isSelectedRound = ( type == Alert.YES );
					
					dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.SelectedRoundPanel ));	
					dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.FightAlone ));
				}
			}
		}
		
	}
}