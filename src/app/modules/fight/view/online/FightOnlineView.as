package app.modules.fight.view.online
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	
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
		public var container2:Sprite; // 对手字母泡泡显示容器
		
		private var dictLetterOther:Dictionary;
		private var otherTotalTime:int = 60;
		
		public function FightOnlineView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
		}
		
		override public function initialize():void
		{
			otherTotalTime = 60;
			super.initialize();
		}
		
		override public function clear():void
		{
			super.clear();
		}
		
		override public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
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
			setPool( list1, isSelf ? container : container2, isSelf ? 1 : 2 );
		}
		
		private function setPool( list:Vector.<LetterBubbleVo>, container:Sprite, type:int ):void
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
			}
			if ( type == 1 ) dictLetterSelf = dict;
			else if ( type == 2 ) dictLetterOther = dict;
		}
		
		private function timerHandler():void
		{
			selfTotalTime--;
			setTimeText( txtTime, selfTotalTime );
			
			otherTotalTime--;
			setTimeText( txtTime2, otherTotalTime );
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			if ( isSelf )
				selfTotalTime += 5;
			else otherTotalTime += 5;
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
			return [ "ui_round" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineView";
		}
	}
}