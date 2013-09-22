package app.modules.login.service
{
	import app.data.GameData;
	import app.data.PlayerBaseVo;
	import app.data.PlayerSelfVo;
	import app.events.GameEvent;
	import app.modules.login.login.vo.LoginVo;
	import app.modules.login.register.vo.RegisterVo;
	
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
			var data:user_login_ret_t = res.data as user_login_ret_t;
			
			////////////////////////////////////////
			/////////// set player data ////////////
			////////////////////////////////////////
			
			var selfVo:PlayerSelfVo = GameData.instance.selfVo ||= new PlayerSelfVo();
			selfVo.uid = data.uid;
			selfVo.exp = data.exp;
			selfVo.level = data.level;
			
			////////////////////////////////////////
			/////////// set player data ////////////
			////////////////////////////////////////
				
			loginSuccessed();
		}
		
		public function login( loginVo:LoginVo, callBack:Function ):void
		{
			var req:account_req_t = new account_req_t();
			req.nick_name = loginVo.accountName;
			req.password = loginVo.password;
			req.register_flag = false;
			call( client_cmd_e.LOGIN_REQ, req, callBack );
		}
		
		public function register( registerVo:RegisterVo, callBack:Function = null ):void
		{
			var req:account_req_t = new account_req_t();
			req.real_name = registerVo.playerName;
			req.nick_name = registerVo.nickName;
			req.password = registerVo.password;
			req.age = registerVo.playerAge;
			req.email = registerVo.email;
			req.grade = registerVo.className;
			req.phone = registerVo.phone;
			req.qq = registerVo.QQ;
			req.school = registerVo.schoolName;
			req.register_flag = true;
			call( client_cmd_e.LOGIN_REQ, req, callBack );
		}
		
		private function loginSuccessed():void
		{
			dispatch( new GameEvent( GameEvent.LOGIN_SUCCESSED ));
		}
		
	}
}