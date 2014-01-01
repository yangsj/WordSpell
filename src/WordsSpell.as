package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import app.AppContext;
	
	import victor.utils.appStage;
	
	[SWF( width = "960", height = "560", frameRate = "60" )]
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class WordsSpell extends Sprite
	{
		public function WordsSpell()
		{
			if ( stage )
				initApp();
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		private function initApp( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp );
			
			appStage = stage;
			appStage.align = StageAlign.TOP_LEFT;
			appStage.scaleMode = StageScaleMode.NO_SCALE;
			appStage.color = 0;
			
			// 初始化并启动应用
			new AppContext( this );
			
			this.graphics.beginBitmapFill(new ui_Skin_PreloaderBG());
			this.graphics.drawRect( 0, 0, appStage.stageWidth, appStage.stageHeight );
			this.graphics.endFill();
		}
		
		
	}
}