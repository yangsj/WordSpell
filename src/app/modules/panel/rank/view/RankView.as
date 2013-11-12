package app.modules.panel.rank.view
{
	import victor.framework.core.BasePanel;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankView extends BasePanel
	{
		public function RankView()
		{
		}
		
		override protected function get resNames():Array
		{
			return ["ui_Ranking"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_RankingViewPanel";
		}
		
	}
}