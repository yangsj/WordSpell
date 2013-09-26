package app.modules.login.register
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.Language;
	import app.core.Tips;
	import app.core.components.controls.combo.ComboBox;
	import app.modules.login.register.event.RegisterEvent;
	import app.modules.login.register.vo.RegisterVo;
	import app.utils.appStage;
	
	import victor.framework.core.BasePanel;
	
	/**
	 * ……
	 * 区县：
	 * 黄浦区
	 * 卢湾区
	 * 金山区
	 * 徐汇区
	 * 长宁区
	 * 静安区
	 * 普陀区
	 * 闸北区
	 * 虹口区
	 * 杨浦区
	 * 闵行区
	 * 宝山区
	 * 嘉定区
	 * 浦东新区
	 * 松江区
	 * 青浦区
	 * 南汇区
	 * 奉贤区
	 * 崇明县
	 * 
	 * 年级：
	 * 一年级-六年级（预初）
	 * 初一到初三
	 * 高一到高三
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class RegisterView extends BasePanel
	{
		// required
		public var txtAccount:TextField;
		public var txtPw1:TextField;
		public var txtPw2:TextField;
		public var txtPhone:TextField;
		public var txtEmail:TextField;
		// optional
		public var txtName:TextField;
		public var txtArea:TextField;
		public var txtSchool:TextField;
		public var txtClass:TextField;
		public var txtQQ:TextField;
		
		public var btnRegister:InteractiveObject;
		public var btnLogin:InteractiveObject;
		
		private var areaComboBox:ComboBox;
		private var gradeComboBox:ComboBox;
		
		private var _registerVo:RegisterVo;
		
		public function RegisterView()
		{
			super();
			this.graphics.beginFill( 0, 0.4 );
			this.graphics.drawRect(0, 0, appStage.stageWidth, appStage.stageHeight );
			this.graphics.endFill();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			
			txtPhone.maxChars = 11;
			txtPhone.restrict = "0-9";
			txtQQ.restrict = "0-9";
			
			areaComboBox = new ComboBox( RegisterConfig.areaComboData );
			gradeComboBox = new ComboBox( RegisterConfig.gradeComboData );
			
			areaComboBox.x = txtArea.x;
			areaComboBox.y = txtArea.y;
			gradeComboBox.x = txtClass.x;
			gradeComboBox.y = txtClass.y;
			
			addChild( gradeComboBox );
			addChild( areaComboBox );
			
			txtArea.visible = false;
			txtClass.visible = false;
		}
		
		override protected function transitionIn():void
		{
		}
		
		override protected function transitionOut( delay:Number = 0.3 ):void
		{
			super.transitionOut( 0 );
		}
		
		protected function btnLoginHandler(event:MouseEvent):void
		{
			dispatchEvent( new RegisterEvent( RegisterEvent.LOGIN ));
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			var msg:String = "";
			var array:Array = Language.lang(Language.RegisterView_0).split("|");
			
			if ( !registerVo.nickName )
				msg = array[0];
			
			else if ( !registerVo.password )
				msg = array[1];
			
			else if (　!registerVo.passwordConfirm )
				msg = array[2];
			
			else if ( !registerVo.phone )
				msg = array[3];
			
			else if ( !registerVo.email )
				msg = array[4];
			
			if ( !msg )
			{
				if ( registerVo.password != registerVo.passwordConfirm )
				{
					txtPw2.text = "";
					msg =  array[5];
				}
				else
				{
					if ( !validatePhoneNumber( registerVo.phone ))
						msg = array[6];
					else if ( !validateEmail( registerVo.email ))
						msg = array[7];
				}
			}
			
			if ( msg ) Tips.showMouse( msg );
			
			else dispatchEvent( new RegisterEvent( RegisterEvent.REGISTER ));
		}
		
		/**
		 * 验证邮箱是否格式正确
		 * @param str
		 * @return 
		 */
		private function validateEmail(str:String):Boolean {
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(str);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 验证电话号码是否正确
		 * @param str
		 * @return 
		 */
		private function validatePhoneNumber(str:String):Boolean {
			var pattern:RegExp = /^\d{11}$/;
			var result:Object = pattern.exec(str);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		public function get registerVo():RegisterVo
		{
			_registerVo ||= new RegisterVo();
			_registerVo.nickName = txtAccount.text;
			_registerVo.password = txtPw1.text;
			_registerVo.passwordConfirm = txtPw2.text;
			_registerVo.phone = txtPhone.text;
			_registerVo.email = txtEmail.text;
			
			_registerVo.playerName = txtName.text;
			_registerVo.playerAddress = areaComboBox.label;//txtArea.text;
			_registerVo.schoolName = txtSchool.text;
			_registerVo.className = gradeComboBox.label;//txtClass.text;
			_registerVo.QQ = txtQQ.text;
			
			return _registerVo;
		}
		
		override protected function get skinName():String
		{
			return "ui_SkinRegisterUI";
		}
		
	}
}