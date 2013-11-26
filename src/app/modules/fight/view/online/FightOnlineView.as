package app.modules.fight.view.online
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.model.vo.ItemType;
	
	import victor.framework.debug.Debug;
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
		
		override public function initialize( isPractice:Boolean = false ):void
		{
			selfTotalTime = 300;
			otherTotalTime = 300;
			super.initialize( isPractice );
		}
		
		override public function clear():void
		{
			super.clear();
			Debug.debug( "FightOnlineView.clear()" );
			clearDict( dictLetterOther );
		}
		
		public function answerResult( isWin:Boolean, isSelf:Boolean ):void
		{
			var msg:String = isWin ? "时间 +3 秒" : "时间 -10 秒";
			var time:int = isWin ? 3 : -10;
			var point:Point = getTimeTipsPoint( isSelf );
			
			Debug.debug( isSelf, time, selfTotalTime, otherTotalTime );
			
			if ( isSelf ) selfTotalTime += time;
			else otherTotalTime += time;
			
			Debug.debug( isSelf, time, selfTotalTime, otherTotalTime );
			
			Tips.show( msg, point.x, point.y, 25 );
		}
		
		/**
		 * 删除对手屏幕泡泡
		 * @param id
		 * @return 
		 */
		public function delBubbleByIdForOther( id:int ):LetterBubble
		{
			Debug.debug( "xiaochu bubble_id:" + id  );
			var letter:LetterBubble;
			for ( var i:int = 0; i < container2.numChildren; i++ )
			{
				letter = container2.getChildAt( i ) as LetterBubble;
				if ( letter && letter.data.id == id )
				{
					Debug.debug( "对手消除泡泡：" + letter.data.upperCase + "|" + letter.data.id );
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
			points = [[32.75,32],[102.65,32],[172.55,32],[242.45,32],[312.35,32],[382.25,32],[46.5,94.2],[110.9,94.2],[175.3,94.2],[239.75,94.2],[304.1,94.2],[368.5,94.2],[32.75,156.4],[96.15,156.4],[159.55,156.4],[222.95,156.4],[286.35,156.4],[349.75,156.4],[65.25,218.6],[128.65,218.6],[192.05,218.6],[255.45,218.6],[318.85,218.6],[382.25,218.6],[49,343],[112.4,343],[175.8,343],[239.2,343],[302.6,343],[366,343],[32.75,280.8],[102.65,280.8],[172.55,280.8],[242.45,280.8],[312.35,280.8],[382.25,280.8]];
			var dict:Dictionary = new Dictionary();
			DisplayUtil.removedAll( container, false );
			var key:String;
			var bubble:LetterBubble;
			var point:Array;
			for each ( var vo:LetterBubbleVo in list )
			{
				point = points.splice(int(Math.random() * points.length), 1)[0];
				key = vo.letter.toLocaleLowerCase();
				bubble = LetterBubble.itemInstance;
				bubble.setMoveArea( isAlone );
				bubble.setData( vo );
				bubble.x = point[0];
				bubble.y = point[1];
				container.addChild( bubble );
				dict[ key ] ||= [];
				dict[ key ].push( bubble );
				Debug.debug( (isSelf ? "自己屏幕：" : "对手屏幕：") + key );
			}
			if ( isSelf ) dictLetterSelf = dict;
		}
		
		override protected function timerHandler():void
		{
			selfTotalTime--;
			setTimeText( txtTime, selfTotalTime );
			
			otherTotalTime--;
			setTimeText( txtTime2, otherTotalTime );
			
			Debug.debug( "时间：", selfTotalTime, otherTotalTime );
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			var point:Point = getTimeTipsPoint( isSelf );
			if ( isSelf ) {
				selfTotalTime += 8;
			} else {
				otherTotalTime += 8;
			}
			Tips.show( "时间 +8s", point.x, point.y );
		}
		
		private function getTimeTipsPoint( isSelft:Boolean ):Point
		{
			var point:Point = new Point(container.x + 207, container.y + 207 );
			if ( !isSelft ){
				point.x = container2.x + 207;
			}
			return point;
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
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineView";
		}
	}
}