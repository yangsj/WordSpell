package app.modules.fight.panel.search
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import app.core.Alert;
	import app.core.Tips;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.friend.model.FriendVo;
	
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
		protected var dictItems:Dictionary = new Dictionary();
		
		public function FightSearchBasePanel()
		{
			super();
		}
		
		public function setDataList( list:Vector.<FriendVo> ):void
		{
			if ( list )
			{
				DisplayUtil.removedAll( listContainer );
				var length:int = list.length;
				var item:FightSearchItem;
				for ( var i:int = 0; i < length; i++ )
				{
					item = getItem( i );
					item.setData( list[ i ]);
					listContainer.addChild( item );
				}
			}
			gameScroll.updateMainHeight( listContainer.height );
			gameScroll.setPos( 0 );
		}
		
		protected function getItem( index:int ):FightSearchItem
		{
			var item:FightSearchItem = dictItems[index] as FightSearchItem;
			if ( item == null )
			{
				item = new FightSearchItem();
				item.y = 40 * index;
				dictItems[index] = item;
			}
			return item;
		}
		
		protected function createScroll( scrollWidth, scrollHeight ):void
		{
			if ( gameScroll == null )
			{
				gameScroll = new GameScrollPanel();
				gameScroll.setTargetAndHeight( listContainer,scrollHeight, scrollWidth );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnConfirm.addEventListener(MouseEvent.CLICK, onBtnConfirmClickHandler );
		}
		
		protected function onBtnConfirmClickHandler(event:MouseEvent):void
		{
			if ( FightSearchItem.selectedItem )
			{
				Alert.show( "确定邀请加入对战", callBackFun, "确定", "取消" );
			}
			else
			{
				Tips.showMouse( "请选择一个玩家！" );
			}
			
			function callBackFun( type:int ):void
			{
				if ( type == Alert.YES )
				{
					dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.FightReadyPanel, FightSearchItem.selectedItem.friendVo ));
					hide();
				}
			}
		}
		
		override public function hide():void
		{
			super.hide();
			if ( FightSearchItem.selectedItem )
			{
				FightSearchItem.selectedItem.selected = false;
				FightSearchItem.selectedItem = null;
			}
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight_friend_search" ];
		}
	}
}