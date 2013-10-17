package app.modules.fight.view
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
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
	 * 			2013-10-17
	 */
	public class FightBaseView extends LoadViewBase
	{
		public var txtMoney:TextField; // 自己金钱数量显示
		public var txtTime:TextField; // 时间显示
		public var container:Sprite; // 自己字母泡泡显示容器
		
		protected var spellArea:SpellArea;
		protected var propList:PropList;
		protected var effectContainer:Sprite;
		protected var dictLetterSelf:Dictionary;
		protected var selfTotalTime:int = 60;
		
		public function FightBaseView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			spellArea = new SpellArea();
			spellArea.x = 440;
			spellArea.y = 460;
			addChild( spellArea );
			
			propList = new PropList();
			propList.x = 665;
			propList.y = 469;
			addChild( propList );
			
			effectContainer = new Sprite();
			addChild( effectContainer );
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
		
		public function initialize():void
		{
			selfTotalTime = 60;
			TickManager.doInterval( timerHandler, 1000 );
			timerHandler();
			appStage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			TickManager.doInterval( enterFrameHandler, 20 );
		}
		
		public function clear():void
		{
			appStage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			TickManager.clearDoTime( enterFrameHandler );
			spellArea.clear();
			propList.clear();
		}
		
		public function playAddPropEffect( bubble:LetterBubble, point:Point ):void
		{
			var pos:Point = bubble.localToGlobal( new Point());
			bubble.x = pos.x;
			bubble.y = pos.y;
			effectContainer.addChild( bubble );
			TweenMax.to( bubble, 0.3, {x:point.x, y:point.y, onComplete: complete, onCompleteParams:[bubble]});
			function complete( bubble:DisplayObject ):void
			{
				TweenMax.to( bubble, 0.2, {scaleX:0.3, scaleY:0.3, onComplete:DisplayUtil.removedFromParent, onCompleteParams:[bubble]});
			}
		}
		
		public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
		}
		
		public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
		}
		
		public function setRoundName( roundName:String ):void
		{
		}
		
		public function updateMoneyDisplay():void
		{
			txtMoney.text = GameData.instance.selfVo.money.toString();
		}
		
		/**
		 * 使用时间道具
		 */
		public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
		}
		
		/**
		 * 使用 扫帚
		 */
		public function useBroomProp( isSelf:Boolean = true ):void
		{
		}
		
		/**
		 * 提示
		 * @param key
		 * @param isSelf
		 */
		public function useHintProp( key:String, isSelf:Boolean = true ):void
		{
			if ( dictLetterSelf )
			{
				var ary:Array = dictLetterSelf[ key ];
				var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
				if ( bubble ) bubble.hint();
			}
		}
		
		protected function setTimeText( text:TextField, seconds:int ):void
		{
			if ( seconds >= 0 )
				text.htmlText = txtTime.htmlText = getTimeString( seconds );
			
			function getTimeString( seconds:int ):String
			{
				var min:int = int(seconds/60);
				var sec:int = seconds%60;
				return HtmlText.color( (min < 10 ? "0" + min : min) + ":" + (sec < 10 ? "0" + sec : sec), seconds <= 10 ? 0xff0000 : 0xffff00 );
			}
		}
		
		protected function timerHandler():void
		{
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			var charCode:int = event.charCode;
			var key:String = String.fromCharCode( charCode ).toLocaleLowerCase();
			if ( dictLetterSelf )
			{
				var ary:Array = dictLetterSelf[ key ];
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
		}
		
		protected function hitTestCheck( container:Sprite ):void
		{
			var mc1:LetterBubble, mc2:LetterBubble;
			for ( var i:int = 0; i < container.numChildren; i++ )
			{
				mc1 = container.getChildAt( i ) as LetterBubble;
				if ( mc1 )
				{
					for ( var j:int = 0; j < container.numChildren; j++ )
					{
						mc2 = container.getChildAt( j ) as LetterBubble;
						if ( mc2 && mc1 != mc2 &&  HitTestUtils.pixelsHitTest2( mc1.point, mc1.bitmapData, mc2.point, mc2.bitmapData) )
						{
							var dist0:Number = 82;//( mc1.width + mc2.width ) >> 1;
							var dist1:Number = MathUtil.distance( mc1.x, mc1.y, mc2.x, mc2.y);
							if ( dist1 < dist0 )
							{
								var rate:Number = ( dist0 / dist1 );
								var movex:Number = Math.abs( mc1.x - mc2.x ) * rate;
								var movey:Number = Math.abs( mc1.y - mc2.y ) * rate;
								if ( mc1.x < mc2.x )
								{
									if ( mc2.isEdgeRight )
										mc1.x = mc2.x - movex;
									else mc2.x = mc1.x + movex;
								}
								else if ( mc2.isEdgeLeft )
									mc1.x = mc2.x + movex;
								else mc2.x = mc1.x - movex;
								
								if ( mc1.y < mc2.y )
								{
									if ( mc2.isEdgeDown )
										mc1.y = mc2.y - movey;
									else mc2.y = mc1.y + movey;
								}
								else if ( mc2.isEdgeUp )
									mc1.y = mc2.y + movey;
								else mc2.y = mc1.y - movey;
							}
							mc1.changeDirection( true );
							mc2.changeDirection( true );
						}
					}
				}
			}
		}
	}
}