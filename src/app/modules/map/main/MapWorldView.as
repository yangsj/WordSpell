package app.modules.map.main
{
	import flash.events.MouseEvent;
	
	import app.modules.map.event.MapEvent;
	import app.utils.appStage;
	
	import victor.framework.core.BaseScene;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class MapWorldView extends BaseScene
	{
		public function MapWorldView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect(0,0,appStage.stageWidth, appStage.stageHeight);
			this.graphics.endFill();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			addEventListener(MouseEvent.CLICK, openSelectedRoundHandler );
		}
		
		protected function openSelectedRoundHandler(event:MouseEvent):void
		{
			dispatchEvent( new MapEvent( MapEvent.OPEN_SELECTED_ROUND ));
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MainBackground";
		}
	}
}