package app.modules.login.login
{
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import app.Language;
	import app.core.Tips;
	import app.modules.friend.view.rightMenu.RightMenu;
	import app.modules.friend.view.rightMenu.RightMenuType;
	import app.modules.login.login.event.LoginEvent;
	import app.modules.login.login.vo.LoginVo;
	import app.utils.appStage;
	
	import victor.framework.core.BaseScene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class LoginView extends BaseScene
	{
		public var txtAccountNumber:TextField;
		public var txtPassword:TextField;
		public var txtTips1:TextField;
		public var txtTips2:TextField;
		public var forgetPassword:InteractiveObject;
		public var btnLogin:InteractiveObject;
		public var btnRegister:InteractiveObject;
		
		private var _loginVo:LoginVo;
		
		public function LoginView()
		{
			super();
		}
		
		override public function show():void
		{
			super.show();
			appStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		override public function hide():void
		{
			super.hide();
			appStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtAccountNumber.tabEnabled = true;
			txtPassword.tabEnabled = true;
			txtAccountNumber.tabIndex = 0;
			txtPassword.tabIndex = 1;
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			forgetPassword.addEventListener(MouseEvent.CLICK, txtForgetPasswordHandler );
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			btnLogin.removeEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.removeEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			forgetPassword.removeEventListener(MouseEvent.CLICK, txtForgetPasswordHandler );
		}
		
		protected function txtForgetPasswordHandler(event:MouseEvent):void
		{
			// 忘记密码
			// test
			event.stopPropagation();
			RightMenu.instance.setList( RightMenuType.testRightMenu );
		}
		
		protected function focusInOutHandler(event:FocusEvent):void
		{
			var type:String = event.type;
			var target:TextField = event.target as TextField;
			if ( type == FocusEvent.FOCUS_IN )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = false;
				else txtTips2.visible = false;
			}
			else if ( type == FocusEvent.FOCUS_OUT )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = !target.text;
				else txtTips2.visible = !target.text;
			}
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			dispatchEvent( new LoginEvent( LoginEvent.ACTION_REGISTER ));
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			if ( event.keyCode == Keyboard.ENTER )
				btnLoginHandler( null );
		}
		
		protected function btnLoginHandler( event:MouseEvent = null ):void
		{
			if ( txtAccountNumber.text && txtPassword.text )
				dispatchEvent( new LoginEvent( LoginEvent.ACTION_LOGIN ));
			else Tips.showMouse( Language.lang( Language.LoginView_0 ) );
		}
		
		public function get loginVo():LoginVo
		{
			_loginVo ||= new LoginVo();
			_loginVo.accountName = txtAccountNumber.text;
			_loginVo.passwrod = txtPassword.text;
			return _loginVo;
		}
		
		override protected function get skinName():String
		{
			return "ui_SkinLoginUI";
		}
		
	}
}