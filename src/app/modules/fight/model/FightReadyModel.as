package app.modules.fight.model
{
	import app.data.PlayerBaseVo;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-19
	 */
	public class FightReadyModel extends Actor
	{
		public function FightReadyModel()
		{
			super();
		}
		
		private var _invitePlayerVo:PlayerBaseVo;
		
		public function get invitePlayerVo():PlayerBaseVo
		{
			return _invitePlayerVo;
		}

		public function set invitePlayerVo(value:PlayerBaseVo):void
		{
			_invitePlayerVo = value;
		}

	}
}