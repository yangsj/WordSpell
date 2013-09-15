package app.modules.login.service
{
	import app.events.GameEvent;
	import app.modules.login.login.vo.LoginVo;
	import app.modules.login.register.vo.RegisterVo;
	import app.utils.safetyCall;
	
	import ff.account_req_t;
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	import ff.user_login_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
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
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.LOGIN_RET, loginSuccessedNotify, user_login_ret_t );
		}
		
		private function loginSuccessedNotify( res:SocketResp ):void
		{
			loginSuccessed();
		}
		
		public function login( loginVo:LoginVo, callBack:Function ):void
		{
			var req:account_req_t = new account_req_t();
			req.nick_name = loginVo.accountNumber;
			req.password = loginVo.passwrod;
			req.register_flag = false;
			call( client_cmd_e.LOGIN_REQ, req, callBack );
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