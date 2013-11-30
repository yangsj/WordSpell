package app.modules.panel.error_list.view
{
	import app.modules.panel.error_list.event.ErrorListEvent;
	import app.modules.panel.error_list.model.ErrorListModel;
	import app.modules.panel.error_list.service.ErrorListService;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.events.PanelEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListMediator extends BaseMediator
	{
		[Inject]
		public var view:ErrorListView;
		[Inject]
		public var errorListModel:ErrorListModel;
		[Inject]
		public var errorListService:ErrorListService;
		
		public function ErrorListMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			errorListModel.clearList();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( ErrorListEvent.GET_LIST_SUCCESSED, getListNotify, ErrorListEvent );
			
			addViewListener( PanelEvent.OPENED, openedPanelHandler, PanelEvent );
		}
		
		private function getListNotify( event:ErrorListEvent ):void
		{
//			view.setVo( errorListModel.list );
			view.setArrayList( errorListModel.englshList );
		}
		
		private function openedPanelHandler( event:PanelEvent ):void
		{
			errorListService.getErrorList();
		}
		
	}
}