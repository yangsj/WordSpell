package app.modules.fight.view.panel
{
	import app.modules.fight.model.FightEndVo;
	import app.core.Text;
	
	import victor.utils.UtilsFilter;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightWinPanel extends FightResultBasePanel
	{

		public function FightWinPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtExp = Text.cloneText( txtExp );
			txtMoney = Text.cloneText( txtMoney );
		}

		override public function setData( endVo:FightEndVo ):void
		{
			super.setData( endVo );
			mcStar.gotoAndStop( Math.max( endVo.starNum, 1 ));
			mcStar.filters = endVo.starNum == 0 ? [ UtilsFilter.COLOR_GREW ] : [];
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_WinMainPanel";
		}

		override protected function get resNames():Array
		{
			return [ "ui_round_winPanel" ];
		}

	}
}
