package app.modules.panel.personal.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	import app.modules.model.GenderType;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.core.BasePanel;
	import victor.framework.debug.Debug;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-3
	 */
	public class InformationPanel extends BasePanel
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var checkboxArea:SimpleButton;
		public var checkboxGrade:SimpleButton;
		public var btnCommit:SimpleButton;
		
		public var txtRealName:TextField;
		public var txtArea:TextField;
		public var txtSchool:TextField;
		public var txtClass:TextField;
		public var txtQQ:TextField;
		public var txtEmail:TextField;
		public var txtName:TextField;
		public var txtCurPw:TextField;
		public var txtChangePw:TextField;
		public var txtConfirmPw:TextField;
		
		public var tab0:MovieClip;
		public var tab1:MovieClip;
		
		private var tabControl:TabButtonControl;
		private var gender:int = 0;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function InformationPanel()
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
		
		override protected function onceInit():void
		{
			tabControl = new TabButtonControl( tabControlHandler );
			tabControl.addTarget( tab0, GenderType.MALE );
			tabControl.addTarget( tab1, GenderType.FEMALE );
		}
		
		private function tabControlHandler( mc:MovieClip, data:int ):void
		{
			gender = data;
			Debug.debug( "性别：" + data );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_InformationPanel";
		}
		override protected function get resNames():Array
		{
			return ["ui_Personal"];
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}