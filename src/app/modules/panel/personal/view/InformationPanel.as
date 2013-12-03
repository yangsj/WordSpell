package app.modules.panel.personal.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.Language;
	import app.core.Tips;
	import app.data.GameData;
	import app.data.PlayerSelfVo;
	import app.modules.login.register.CheckboxPanel;
	import app.modules.login.register.RegisterConfig;
	import app.modules.login.register.event.RegisterEvent;
	import app.modules.model.GenderType;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.core.BasePanel;
	import victor.framework.debug.Debug;
	import victor.framework.manager.TickManager;
	
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
		
		private var areaPanel:CheckboxPanel;
		private var gradePanel:CheckboxPanel;
		
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
		
		private function areaCallBackFun( data:Array ):void
		{
			txtArea.text = data[0] + "";
		}
		
		private function gradeCallBackFun( data:Array ):void
		{
			txtClass.text = data[0] + "";
		}
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function checkboxAreaHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			gradePanel.tweenClose();
			if ( areaPanel.isOpen )
				areaPanel.tweenClose();
			else areaPanel.tweenOpen();
		}
		
		protected function checkboxGradeHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			areaPanel.tweenClose();
			if ( gradePanel.isOpen )
				gradePanel.tweenClose();
			else gradePanel.tweenOpen();
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override protected function onceInit():void
		{
			btnCommit.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			checkboxArea.addEventListener(MouseEvent.CLICK, checkboxAreaHandler );
			checkboxGrade.addEventListener(MouseEvent.CLICK, checkboxGradeHandler );
			
			tabControl = new TabButtonControl( tabControlHandler );
			tabControl.addTarget( tab0, GenderType.MALE );
			tabControl.addTarget( tab1, GenderType.FEMALE );
			
			areaPanel = new CheckboxPanel();
			areaPanel.x = checkboxArea.x + 25;
			areaPanel.y = checkboxArea.y + checkboxArea.height * 0.5 + 5;
			_skin.addChild( areaPanel );
			areaPanel.callBackFun = areaCallBackFun;
			areaPanel.setData( RegisterConfig.AREA_NAME, true );
			
			gradePanel = new CheckboxPanel();
			gradePanel.x = checkboxGrade.x + 25;
			gradePanel.y = checkboxGrade.y + checkboxGrade.height * 0.5 + 5;
			_skin.addChild( gradePanel );
			gradePanel.callBackFun = gradeCallBackFun;
			gradePanel.setData( RegisterConfig.GRADE_NAME, false );
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
		
		public function setBaseData():void
		{
			var selfVo:PlayerSelfVo = GameData.instance.selfVo;
			
			txtName.text = selfVo.name;
			txtEmail.text = selfVo.email;
			txtQQ.text = selfVo.qq;
			txtSchool.text = selfVo.school;
			txtRealName.text = selfVo.realName;
			
			tabControl.setTargetByIndex( selfVo.gender );
			areaPanel.selectedForItem( RegisterConfig.getAreaIndexByName( selfVo.address ));
			gradePanel.selectedForItem( RegisterConfig.getGradeIndexByName( selfVo.grade ));
		}
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}