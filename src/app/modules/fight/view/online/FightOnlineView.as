package app.modules.fight.view.online
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.model.vo.ItemType;
	
	import victor.framework.log.Logger;
	import victor.framework.utils.DisplayUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightOnlineView extends FightBaseView
	{
		public var txtPlayer1:TextField; // 玩家自己的名字
		public var txtPlayer2:TextField; // 玩家对手的名字
		public var txtTime2:TextField; // 时间显示
		
		private var dictLetterOther:Dictionary;
		private var otherTotalTime:int = 60;
		
		public function FightOnlineView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			container2.mouseChildren = false;
			container2.mouseEnabled = false;
		}
		
		override public function initialize():void
		{
			selfTotalTime = 60;
			otherTotalTime = 60;
			super.initialize();
		}
		
		override public function clear():void
		{
			super.clear();
			Logger.debug( "FightOnlineView.clear()" );
			clearDict( dictLetterOther );
		}
		
		/**
		 * 删除对手屏幕泡泡
		 * @param id
		 * @return 
		 */
		public function delBubbleByIdForOther( id:int ):LetterBubble
		{
			Logger.debug( "xiaochu bubble_id:" + id  );
			var letter:LetterBubble;
			for ( var i:int = 0; i < container2.numChildren; i++ )
			{
				letter = container2.getChildAt( i ) as LetterBubble;
				if ( letter && letter.data.id == id )
				{
					Logger.debug( "对手消除泡泡：" + letter.data.upperCase + "|" + letter.data.id );
					letter.selected( true, false );
					var itemType:int = letter.data.itemType;
					if ( itemType != ItemType.DEFAULT ) delete dictProps[itemType+"_other"];
					break;
				}
			}
			return letter;
		}
		
		override public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
			if ( isSelf == false )
				return ;
			
			var key:String = letter.toLocaleLowerCase();
			var dict:Dictionary = isSelf ? dictLetterSelf : dictLetterOther;
			var ary:Array = dict[ key ];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dict[ key ] = ary;
			}
			else
			{
				delete dict[ key ];
			}
		}
		
		override public function setLettersPool( list1:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
			setPool( list1, isSelf ? container : container2, isSelf );
		}
		
		private function setPool( list:Vector.<LetterBubbleVo>, container:Sprite, isSelf:Boolean = true ):void
		{
			var dict:Dictionary = new Dictionary();
			DisplayUtil.removedAll( container, false );
			for each ( var vo:LetterBubbleVo in list )
			{
				var key:String = vo.letter.toLocaleLowerCase();
				var bubble:LetterBubble = new LetterBubble();
				bubble.setMoveArea( false );
				bubble.setData( vo );
				container.addChild( bubble );
				dict[ key ] ||= [];
				dict[ key ].push( bubble );
				Logger.debug( (isSelf ? "自己屏幕：" : "对手屏幕：") + key );
			}
			if ( isSelf ) dictLetterSelf = dict;
		}
		
		override protected function timerHandler():void
		{
			selfTotalTime--;
			setTimeText( txtTime, selfTotalTime, false );
			
			otherTotalTime--;
			setTimeText( txtTime2, otherTotalTime, false );
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			var tipsy:Number = container.y + 190;
			var tipsx:Number = container.x + 207;
			if ( isSelf ) {
				selfTotalTime += 8;
			} else {
				otherTotalTime += 8;
				tipsx = container2.x + 207;
			}
			Tips.show( "时间 +8s", tipsx, tipsy );
		}
		
		/**
		 * 使用 扫帚
		 */
		override public function useBroomProp( isSelf:Boolean = true ):void
		{
		}
		
		public function setPlayerName( playerName1:String, playerName2:String ):void
		{
			txtPlayer1.text = playerName1;
			txtPlayer2.text = playerName2;
		}
		
		override protected function enterFrameHandler( event:Event = null ):void
		{
			hitTestCheck( container );
			hitTestCheck( container2 );
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineView";
		}
	}
}