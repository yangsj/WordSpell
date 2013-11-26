package app.modules.fight.view.practice
{
	import flash.display.DisplayObject;
	
	import app.modules.fight.view.alone.FightAloneView;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-20
	 */
	public class FightPracticeView extends FightAloneView
	{
		public function FightPracticeView()
		{
			super();
		}
		
		override public function setBg(mapId:int):void
		{
			this.mapId = mapId;
			if ( bgContainer.numChildren != 1 ) {
				bgContainer.addChild( getObj( "ui_Skin_FightPracticeBg" ) as DisplayObject );
			}
		}
		
		override public function setRoundName( roundName:String, isDisplayTime:Boolean = true ):void
		{
			txtName.text = "错误单词练习";
		}
		
		override protected function resetText():void
		{
		}
		
	}
}