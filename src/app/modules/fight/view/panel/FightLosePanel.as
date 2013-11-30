package app.modules.fight.view.panel
{
	import app.core.Text;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightLosePanel extends FightResultBasePanel
	{

		public function FightLosePanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtExp = Text.cloneText( txtExp );
			txtMoney = Text.cloneText( txtMoney );
			
			btnNext.visible = false;
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_LoseMainPanel";
		}

		override protected function get resNames():Array
		{
			return [ "ui_round_losePanel" ];
		}
	}
}
