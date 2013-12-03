package app.modules.map.main.item
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.Tips;
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class MapItem extends MapItemBase
	{
		private var mapVo:MapVo;
		private var tips:MovieClip;
		private var txtTips:TextField;
		
		public function MapItem( skin:MovieClip )
		{
			super( skin );
			skin.mouseChildren = true;
			tips = skin.getChildByName( "tips" ) as MovieClip || new MovieClip();
			txtTips = tips.getChildByName( "txt" ) as TextField || new TextField();
			tips.mouseEnabled = false;
			tips.mouseChildren = false;
			skin.addEventListener(MouseEvent.ROLL_OVER, mouseHandler );
			skin.addEventListener(MouseEvent.ROLL_OUT , mouseHandler );
			tips.visible = false;
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.ROLL_OVER ) {
				skin.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler );
				tips.visible = true;
				tips.x = skin.mouseX;
				tips.y = skin.mouseY;
			} else if ( type == MouseEvent.ROLL_OUT ) {
				tips.visible = false;
			} else if ( type == MouseEvent.MOUSE_MOVE ) {
				TweenLite.killTweensOf( tips );
				TweenLite.to( tips, 0.5, {x: skin.mouseX, y: skin.mouseY, ease: Back.easeOut });
			}
		}
		
		override protected function onClickHandler(event:MouseEvent):void
		{
			super.onClickHandler( event );
			if ( isOpen )
				skin.dispatchEvent( new MapEvent( MapEvent.OPEN_SELECTED_ROUND, mapVo, true ));
			else Tips.showMouse( "该章节地图未激活！" );
		}
		
		public function setAndUpdateData( mapVo:MapVo ):void
		{
			this.mapVo = mapVo;
			skin.gotoAndStop( isOpen ? FRAME_OPEN : FRAME_CLOSE );
			txtTips.text = mapVo.mapName;
		}
		
		/**
		 * 地图开启的
		 */
		public function get isOpen():Boolean
		{
			return mapVo.isOpen;
		}
		
		/**
		 * 地图未开启
		 */
		public function get isClose():Boolean
		{
			return !mapVo.isOpen;
		}
		
		
	}
}