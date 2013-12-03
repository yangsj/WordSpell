package app.modules.panel.personal.view
{
	import app.modules.ViewName;
	
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
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function InformationMediator()
		{
			super();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		
		
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
			
			view.setBaseData();
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}