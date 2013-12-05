package app.modules.panel.personal.view
{
	import app.modules.ViewName;
	import app.modules.panel.personal.events.PersonalEvent;
	import app.modules.panel.personal.service.PersonalService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-3
	 */
	public class InformationMediator extends BaseMediator
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var view:InformationPanel;
		[Inject]
		public var personalService:PersonalService;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function InformationMediator()
		{
			super();
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		private function changeInfoHandler( event:PersonalEvent ):void
		{
			personalService.changeInfo( view.registerVo );
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override public function onRemove():void
		{
			super.onRemove();
			openView( ViewName.Personal );
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( PersonalEvent.CHANGE_INFO, changeInfoHandler, PersonalEvent );
			
			view.setBaseData();
		}
		
	}
}