package app.modules.fight.panel.search
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import app.core.Alert;
	import app.core.Tips;
	import app.modules.fight.panel.friend.FightFriendItem;
	
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	
	
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
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			
			if ( gameScroll == null )
			{
				gameScroll = new GameScrollPanel( "ui_Skin_ScrollBar_FightFriend" );
				gameScroll.setTargetAndHeight(listContainer,285);
				// test
				for ( var i:int = 0; i < 15; i++ )
				{
					var item:FightFriendItem = new FightFriendItem();
					item.y = 40 * i;
					item.setBg( i );
					item.setStatus( i );
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
					Tips.showCenter( "开始匹配" );
				}
			}
		}
		
		override public function hide():void
		{
			super.hide();
			FightFriendItem.selectedItem = null;
		}
		
		public function setList( list:Array ):void
		{
			
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight_friend" ];
		}
	}
}