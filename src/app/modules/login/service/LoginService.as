package app.modules.login.service
{
	import app.events.GameEvent;
	import app.events.LoadEvent;
	import app.modules.login.login.vo.LoginVo;
	import app.modules.login.register.vo.RegisterVo;
	import app.utils.safetyCall;
	
	import victor.framework.core.BaseService;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-7
	 */
	public class LoginService extends BaseService
	{
		public function LoginService()
		{
			super();
		}
		
		public function login( loginVo:LoginVo, callBack:Function = null ):void
		{
			loginSuccessed();
			safetyCall( callBack );
		}
		
		public function register( registerVo:RegisterVo, callBack:Function = null ):void
		{
			loginSuccessed();
			safetyCall( callBack );
		}
		
		private function loginSuccessed():void
		{
			dispatch( new GameEvent( GameEvent.LOGIN_SUCCESSED ));
		}
		
	}
}