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
	import ff.property_info_t;
	import ff.server_cmd_e;
	import ff.user_login_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.log.Logger;
	import victor.framework.socket.SocketResp;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-7
	 */
	public class LoginService extends BaseService
	{
		[Inject]
		public var gameDb:GameData;
		
		public function LoginService()
		{
			super();
		}

		override protected function initRegist():void
		{
			// 登陆或注册成功通知
			regist( server_cmd_e.LOGIN_RET, loginSuccessedNotify, user_login_ret_t );
//			// 玩家数据通知
//			regist( server_cmd_e.USER_PROPERTY_RET, userDataNotify, property_info_t );
		}

//		private function userDataNotify( res:SocketResp ):void
//		{
//			var data:property_info_t = res.data as property_info_t;
//
//			setPlayerInfo( data );
//			
//			// 检查是否能进入游戏（登陆时检查一次）
//			if ( gameDb.hasSelfVo == false )
//			{
//				gameDb.hasSelfVo = true;
//				dispatch( new GameEvent( GameEvent.ACQUIRE_PLAYER_DATA ));
//			}
//		}

		private function loginSuccessedNotify( res:SocketResp ):void
		{
			var data:user_login_ret_t = res.data as user_login_ret_t;

			////////////////////////////////////////
			/////////// set player data ////////////
			////////////////////////////////////////

			var selfVo:PlayerSelfVo = GameData.instance.selfVo ||= new PlayerSelfVo();
			selfVo.uid = data.uid;
			setPlayerInfo( data.property_info );
			
			gameDb.hasSelfVo = true;

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
			req.address = registerVo.playerAddress;
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

		private function setPlayerInfo( data:property_info_t ):void
		{
			if ( data )
			{
				var selfVo:PlayerSelfVo = GameData.instance.selfVo ||= new PlayerSelfVo();
				selfVo.exp = data.exp;
				selfVo.address = data.adress;
				selfVo.email = data.email;
				selfVo.grade = data.grade;
				selfVo.level = data.level;
				selfVo.name = data.nick_name;
				selfVo.money = data.coin;
				selfVo.phone = data.phone;
				selfVo.qq = data.qq;
				selfVo.realName = data.real_name;
				selfVo.rightWordsNum = data.right_words_num;
				selfVo.wrongWordsNum = data.wrong_words_num;
				selfVo.school = data.school;
			}
			else
			{
				Logger.error("at setPlayerInfo function params value Invalid. at LoginService line 119");
			}
		}

	}
}
