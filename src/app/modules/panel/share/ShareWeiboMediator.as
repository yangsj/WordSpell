package app.modules.panel.share
{
	import app.core.Tips;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-13
	 */
	public class ShareWeiboMediator extends BaseMediator
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var view:ShareWeiboPanel;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ShareWeiboMediator()
		{
			super();
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		private function shareWeiboHandler( event:ShareWeiboEvent ):void
		{
			Tips.showMouse( "分享" );
			view.hide();
		}	
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( ShareWeiboEvent.SHARE_WEIBO, shareWeiboHandler, ShareWeiboEvent );
		}	
		
	}
}