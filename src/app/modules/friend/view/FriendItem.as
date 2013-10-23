package app.modules.friend.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendVo;
	import app.utils.appStage;
	
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendItem extends TempleteSprite
	{
		/**
		 * mcSelected
		 */
		public var mcSelected:MovieClip;
		/**
		 * 玩家状态：1帧在线|2帧闯关|3帧对战中|4帧离线
		 */
		public var mcStatus:MovieClip;
		/**
		 * 玩家名称
		 */
		public var txtName:TextField;
		
		private var _data:FriendVo;
		private var _selected:Boolean;
		
		private var _tips1:Sprite;
		private var _tips2:MovieClip;
		
		// 聊天
		private const Chat:String = "btnChat";
		// 对战
		private const Battle:String = "btnBattle";
		// 删除
		private const Delete:String = "btnDel";
		
		public function FriendItem()
		{
			setSkinWithName( "ui_Skin_FriendItem" );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
			mouseChildren = false;
			mcStatus.stop();
			selected = false;
			
			_tips1 = getObj( "ui_Skin_FriendItemSuspendTips" ) as Sprite;
			_tips1.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler );
			_tips1.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler );
			_tips1.addEventListener(MouseEvent.CLICK, mouseTips1ClickHandler );
			
			_tips2 = getObj( "ui_Skin_FriendItemClickTips" ) as MovieClip;
			_tips2.addEventListener(MouseEvent.MOUSE_OVER, mouseTips2Handler );
			_tips2.addEventListener(MouseEvent.MOUSE_OUT, mouseTips2Handler );
			_tips2.mcBg.stop();
		}
		
		protected function mouseTips2Handler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.MOUSE_OVER )
				addTips2();
			else DisplayUtil.removedFromParent( _tips2 );
		}
		
		protected function mouseTips1ClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			switch ( targetName )
			{
				case Chat:
					dispatchEvent( new FriendEvent( FriendEvent.CHAT, data, true ));
					break;
				case Battle:
					dispatchEvent( new FriendEvent( FriendEvent.BATTLE, data, true ));
					break;
				case Delete:
					dispatchEvent( new FriendEvent( FriendEvent.DELETE, data, true ));
					break;
			}
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.CLICK )
			{
				selected = true;
				addTips2();
			}
			if ( type == MouseEvent.MOUSE_OVER )
			{
				mcSelected.visible = true;
				addTips1();
			}
			else if ( type == MouseEvent.MOUSE_OUT )
			{
				mcSelected.visible = false;
				DisplayUtil.removedFromParent( _tips1 );
				DisplayUtil.removedFromParent( _tips2 );
			}
		}
		
		private function addTips2():void
		{
			DisplayUtil.removedFromParent( _tips1 );
			if ( _tips2.parent == null )
			{
				var point:Point = this.localToGlobal( new Point());
				if ( point.x - _tips2.width < 0 )
					_tips2.x = point.x + width - 15;
				else _tips2.x = point.x - _tips2.width + 2;
				
				_tips2.y = point.y - 30;
				if ( point.y + _tips2.height > appStage.stageHeight )
					_tips2.y = appStage.stageHeight - _tips2.height - 30;
				
				appStage.addChild( _tips2 );
			}
		}
		
		private function addTips1():void
		{
			if ( _tips1.parent == null )
			{
				var point:Point = this.localToGlobal( new Point());
				if ( point.x - _tips1.width < 0 )
					_tips1.x = point.x + width - 15;
				else _tips1.x = point.x - _tips1.width + 2;
				
				_tips1.y = point.y - 5;
				if ( point.y + _tips1.height > appStage.stageHeight )
					_tips1.y = appStage.stageHeight - _tips1.height - 5;
				
				appStage.addChild( _tips1 );
			}
		}
		
		public function setData( data:FriendVo ):void
		{
			mcStatus.gotoAndStop( data.status );
			
			_tips2.txtName.text = data.name;
			_tips2.txtGrade.text = data.grade;
			_tips2.txtLevel.text = "Lv " + data.grade;
			_tips2.mcBg.gotoAndStop( data.gender + 1 );
		}

		public function get data():FriendVo
		{
			return _data ||= new FriendVo();
		}

		public function set data(value:FriendVo):void
		{
			_data = value;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			mcSelected.visible = value;
		}

		
	}
}