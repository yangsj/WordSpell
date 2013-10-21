package app.modules.fight.panel.matching
{
	import flash.text.TextField;
	
	import app.data.GameData;
	import app.modules.model.GenderType;
	
	import victor.framework.core.BasePanel;
	import victor.framework.utils.HtmlText;
	
	
	/**
	 * ……自动匹配
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightMatchingPanel extends BasePanel
	{
		public var txtPlayer1:TextField;
		public var txtPlayer2:TextField;
		
		public function FightMatchingPanel()
		{
			super();
		}
		
		override protected function afterRender():void
		{
			super.afterRender();
			var color:uint = GenderType.getColor(GameData.instance.selfVo.gender);
			txtPlayer1.htmlText = HtmlText.color( GameData.instance.selfVo.name, color );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_matching" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightMatchingPanel";
		}
		
	}
}