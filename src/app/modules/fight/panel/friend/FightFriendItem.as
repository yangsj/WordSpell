package app.modules.fight.panel.friend
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-18
	 */
	public class FightFriendItem extends TempleteSprite
	{
		public var txtName:TextField;
		public var mcStatus:MovieClip; // 1:在线  2:闯关中 3:对战中
		public var mcBg:MovieClip;
		public var mcSelected:MovieClip;
		
		private var _selected:Boolean = false;
		
		public static var selectedItem:FightFriendItem;
		
		public function FightFriendItem()
		{
			super();
			setSkinWithName( "ui_Skin_FightFriendItem" );
			
			mouseChildren = false;
			buttonMode = true;
			selected = false;
			
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( _selected)
				return;
			if ( type == MouseEvent.MOUSE_OUT || type == MouseEvent.MOUSE_OVER )
			{
				mcSelected.gotoAndStop( 2 );
				mcSelected.visible = type == MouseEvent.MOUSE_OVER;
			}
			else if ( type == MouseEvent.CLICK )
			{
				if ( selectedItem )
					selectedItem.selected = false;
				selectedItem = this
				selected = true;
			}
		}
		
		public function setBg( frame:int ):void
		{
			mcBg.gotoAndStop( frame%2 + 1 );
		}
		
		public function setStatus( status:int ):void
		{
			mcStatus.gotoAndStop( status % 3 + 1 );
		}

		/**
		 * 是否选择
		 */
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * @private
		 */
		public function set selected(value:Boolean):void
		{
			_selected = value;
			mcSelected.gotoAndStop( 1 );
			mcSelected.visible = value;
		}

		
	}
}