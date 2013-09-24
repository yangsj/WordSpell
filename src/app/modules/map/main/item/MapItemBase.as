package app.modules.map.main.item
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class MapItemBase
	{
		// 开启状态帧
		protected const FRAME_OPEN:String = "frame_open";
		// 未开启状态帧
		protected const FRAME_CLOSE:String = "frame_close";
		
		protected var skin:MovieClip;
		
		public function MapItemBase( skin:MovieClip )
		{
			this.skin = skin;
			skin.mouseChildren = false;
			skin.buttonMode = true;
			skin.stop();
			skin.addEventListener(MouseEvent.CLICK, onClickHandler );
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
		}
		
		
	}
}