package app.modules.fight.view.online
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellArea;
	import app.utils.appStage;
	
	import victor.framework.core.LoadViewBase;
	import victor.framework.core.ViewStruct;
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.HitTestUtils;
	import victor.framework.utils.HtmlText;
	import victor.framework.utils.MathUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightOnlineView extends LoadViewBase
	{
		public var txtPlayer1:TextField; // 玩家自己的名字
		public var txtPlayer2:TextField; // 玩家对手的名字
		public var txtTime1:TextField; // 时间显示
		public var txtTime2:TextField; // 时间显示
		public var txtMoney:TextField; // 自己金钱数量显示
		public var container1:Sprite; // 自己字母泡泡显示容器
		public var container2:Sprite; // 对手字母泡泡显示容器
		
		private var spellArea:SpellArea;
		private var propList:PropList;
		private var dict:Dictionary;
		private var totalTime:int = 60;
		
		public function FightOnlineView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			spellArea = new SpellArea();
			spellArea.x = 440;
			spellArea.y = 460;
			addChild( spellArea );
			
			propList = new PropList();
			propList.x = 665;
			propList.y = 469;
			addChild( propList );
		}
		
		public function initialize():void
		{
			totalTime = 60;
			TickManager.doInterval( timerHandler, 1000 );
			timerHandler();
			appStage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			TickManager.doInterval( enterFrameHandler, 40 );
		}
		
		public function clear():void
		{
			appStage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			TickManager.clearDoTime( enterFrameHandler );
			totalTime = 0;
			spellArea.clear();
			propList.clear();
		}
		
		public function delLetterFromDict( letter:String ):void
		{
			var ary:Array = dict[ letter.toLocaleLowerCase()];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dict[ letter.toLocaleLowerCase()] = ary;
			}
			else
			{
				delete dict[ letter.toLocaleLowerCase()];
			}
		}
		
		public function setLettersPool( list:Vector.<LetterBubbleVo> ):void
		{
//			var items:Vector.<LetterBubbleVo> = new Vector.<LetterBubbleVo>();
//			for ( var i:int = 0; i < 15; i ++ )
//			{
//				if ( i < list.length )
//				{
//					items.push( list[i] );
//				}
//				else
//				{
//					var letterBubbleVo:LetterBubbleVo = new LetterBubbleVo();
//					letterBubbleVo.id = -1;
//					letterBubbleVo.letter = "A";
//					letterBubbleVo.itemType = 0;
//					items.push( letterBubbleVo );
//				}
//			}
//			list = items;
			
//			dict = new Dictionary();
//			DisplayUtil.removedAll( container, false );
//			for each ( var vo:LetterBubbleVo in list )
//			{
//				var key:String = vo.letter.toLocaleLowerCase();
//				var bubble:LetterBubble = new LetterBubble();
//				bubble.setData( vo );
//				container.addChild( bubble );
//				dict[ key ] ||= [];
//				dict[ key ].push( bubble );
//			}
		}
		
		private function timerHandler():void
		{
			totalTime--;
			if ( totalTime >= 0 )
				txtTime1.htmlText = txtTime1.htmlText = HtmlText.color( "00:" + ( totalTime < 10 ? "0" + totalTime : totalTime ), totalTime <= 10 ? 0xff0000 : 0xffff00 );
		}
		
		/**
		 * 使用时间道具
		 */
		public function useExtraTimeProp():void
		{
			totalTime += 5;
		}
		
		/**
		 * 使用 扫帚
		 */
		public function useBroomProp():void
		{
		}
		
		public function useHintProp( key:String ):void
		{
			if ( dict )
			{
				var ary:Array = dict[ key ];
				var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
				if ( bubble ) bubble.hint();
			}
		}
		
		public function setPlayerName( playerName1:String, playerName2:String ):void
		{
			txtPlayer1.text = playerName1;
			txtPlayer2.text = playerName2;
		}
		
		public function updateMoneyDisplay():void
		{
			txtMoney.text = GameData.instance.selfVo.money.toString();
		}
		
		override public function hide():void
		{
			super.hide();
			clear();
		}
		
		override protected function addToParent():void
		{
			ViewStruct.addChild( this, ViewStruct.SCENE2 );
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			var charCode:int = event.charCode;
			var key:String = String.fromCharCode( charCode ).toLocaleLowerCase();
			if ( dict )
			{
				var ary:Array = dict[ key ];
				var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
				if ( bubble )
				{
					bubble.selected( true );
				}
				else
					Tips.showCenter( "按键无效" );
			}
		}
		
		protected function enterFrameHandler( event:Event = null ):void
		{
//			var mc1:LetterBubble, mc2:LetterBubble;
//			for ( var i:int = 0; i < container.numChildren; i++ )
//			{
//				mc1 = container.getChildAt( i ) as LetterBubble;
//				if ( mc1 )
//				{
//					for ( var j:int = 0; j < container.numChildren; j++ )
//					{
//						mc2 = container.getChildAt( j ) as LetterBubble;
//						if ( mc2 && mc1 != mc2 &&  HitTestUtils.pixelsHitTest2( mc1.point, mc1.bitmapData, mc2.point, mc2.bitmapData) )
//						{
//							var dist0:Number = LetterBubble.WH;
//							var dist1:Number = MathUtil.distance( mc1.x, mc1.y, mc2.x, mc2.y);
//							if ( dist1 < dist0 )
//							{
//								var rate:Number = ( dist0 / dist1 );
//								var movex:Number = Math.abs( mc1.x - mc2.x ) * rate;
//								var movey:Number = Math.abs( mc1.y - mc2.y ) * rate;
//								if ( mc1.x < mc2.x )
//								{
//									if ( mc2.isEdgeRight )
//										mc1.x = mc2.x - movex;
//									else mc2.x = mc1.x + movex;
//								}
//								else if ( mc2.isEdgeLeft )
//									mc1.x = mc2.x + movex;
//								else mc2.x = mc1.x - movex;
//								
//								if ( mc1.y < mc2.y )
//								{
//									if ( mc2.isEdgeDown )
//										mc1.y = mc2.y - movey;
//									else mc2.y = mc1.y + movey;
//								}
//								else if ( mc2.isEdgeUp )
//									mc1.y = mc2.y + movey;
//								else mc2.y = mc1.y - movey;
//							}
//							mc1.changeDirection( true );
//							mc2.changeDirection( true );
//						}
//					}
//				}
//			}
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_round" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_Round_MainPanel";
		}
	}
}