package app.modules.fight.panel.search
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import app.core.Alert;
	import app.core.Tips;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.fight.panel.friend.FightFriendItem;
	
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-18
	 */
	public class FightSearchBasePanel extends BasePanel
	{
		public var listContainer:Sprite;
		public var btnConfirm:InteractiveObject;
		protected var gameScroll:GameScrollPanel;
		
		public function FightSearchBasePanel()
		{
			super();
		}
		
		protected function createScroll( scrollWidth, scrollHeight ):void
		{
			if ( gameScroll == null )
			{
				DisplayUtil.removedAll( listContainer );
				gameScroll = new GameScrollPanel();
				gameScroll.setTargetAndHeight( listContainer,scrollHeight, scrollWidth );
				// test
				for ( var i:int = 0; i < 35; i++ )
				{
					var item:FightFriendItem = new FightFriendItem();
					item.y = 40 * i;
					item.setBg( i );
					item.setStatus( i );
					item.txtName.appendText( i + "" );
					item.setData();
					listContainer.addChild( item );
				}
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnConfirm.addEventListener(MouseEvent.CLICK, onBtnConfirmClickHandler );
		}
		
		protected function onBtnConfirmClickHandler(event:MouseEvent):void
		{
			if ( FightFriendItem.selectedItem )
			{
				Alert.show( "确定邀请加入对战", callBackFun, "确定", "取消", "玩家" );
			}
			else
			{
				Tips.showMouse( "请选择一个玩家！" );
			}
			
			function callBackFun( type:int ):void
			{
				if ( type == Alert.YES )
				{
//					Tips.showCenter( "开始匹配" );
					dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.FightMatchingPanel, null ));
					hide();
				}
			}
		}
		
		override public function hide():void
		{
			super.hide();
			if ( FightFriendItem.selectedItem )
			{
				FightFriendItem.selectedItem.selected = false;
				FightFriendItem.selectedItem = null;
			}
		}
		
		public function setList( list:Array ):void
		{
			
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight_friend_search" ];
		}
	}
}