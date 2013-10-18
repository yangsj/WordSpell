package app.modules.fight.panel.result
{
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightOnlineResultPanel extends BasePanel
	{
		public function FightOnlineResultPanel()
		{
			super();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_fight_online_result"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineResultPanel";
		}
		
	}
}