package app.modules.fight.panel.search
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-18
	 */
	public class FightSearchItem extends TempleteSprite
	{
		public var txtName:TextField;
		public var mcStatus:MovieClip; // 1:在线  2:闯关中 3:对战中
		public var mcBg:MovieClip;
		public var mcSelected:MovieClip;
		
		private var _selected:Boolean = false;
		private var _nameBitmap:Bitmap;
		
		public static var selectedItem:FightSearchItem;
		
		public function FightSearchItem()
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
		
		public function setData():void
		{
			
			DisplayUtil.removedFromParent( _nameBitmap );
			txtName.visible = false;
			_nameBitmap = new Bitmap( new BitmapData( txtName.width, txtName.height, true, 0 ));
			_nameBitmap.bitmapData.draw( txtName );
			_nameBitmap.x = txtName.x;
			_nameBitmap.y = txtName.y;
			_skin.addChild( _nameBitmap );
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