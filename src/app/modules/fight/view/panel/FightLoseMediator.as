package app.modules.fight.view.panel
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightLoseMediator extends FightResultBaseMediator
	{
		[Inject]
		public var view:FightLosePanel;

		public function FightLoseMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			super.onRegister();
			view.setData( fightModel.fightEndVo );
		}

	}
}
