package app.modules.fight.view.alone
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
	import app.utils.TextUtil;
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
	public class FightAloneView extends LoadViewBase
	{
		// 所属地图名称
		public var txtName:TextField;
		// 倒计时时间显示文本框
		public var txtTime:TextField;
		// 金币显示文本框
		public var txtMoney:TextField;
		// 字母泡泡显示容器
		public var container:MovieClip;

		private var spellArea:SpellArea;
		private var propList:PropList;
		private var effectContainer:Sprite;

		private var dictLetter:Dictionary;
		private var dictProps:Dictionary;

		private var totalTime:int = 60;

		public function FightAloneView()
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
			
			effectContainer = new Sprite();
			addChild( effectContainer );
			
			var fiter1:Array = txtName.filters;
			var fiter2:Array = txtTime.filters;
			DisplayUtil.removedFromParent( txtName );
			DisplayUtil.removedFromParent( txtTime );
			txtTime = TextUtil.getText(26, 0xffff00, 452,6,120,30, "left");
			txtName = TextUtil.getText( 18, 0x006699, 15, 11, 300, 25, "left");
			txtName.filters = fiter1;
			txtTime.filters = fiter2;
			_skin.addChild( txtName );
			_skin.addChild( txtTime );
		}

		public function initialize():void
		{
			dictProps = new Dictionary();
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
			dictProps = null;
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

		public function delLetterFromDict( letter:String ):void
		{
			var ary:Array = dictLetter[ letter.toLocaleLowerCase()];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dictLetter[ letter.toLocaleLowerCase()] = ary;
			}
			else
			{
				delete dictLetter[ letter.toLocaleLowerCase()];
			}
		}
		
		public function delPropItemFromDict( itemType:int ):void
		{
			delete dictProps[ itemType ];
			delete dictProps[ itemType + "_data" ];
		}
		
		public function addPropItem( lettetVo:LetterBubbleVo ):void
		{
			if ( lettetVo ) dictProps[ lettetVo.itemType + "_data" ] = lettetVo;
		}
		
		public function displayPropItem():void
		{
			var bubble:LetterBubble;
			var lettetVo:LetterBubbleVo;
			for ( var key:String in dictProps )
			{
				if ( key.indexOf( "_data" ) != -1 )
				{
					lettetVo = dictProps[ key ];
					bubble = new LetterBubble();
					bubble.setData( lettetVo );
					container.addChild( bubble );
					dictProps[ lettetVo.itemType ] = bubble;
				}
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
			
			dictLetter = new Dictionary();
			DisplayUtil.removedAll( container, false );
			for each ( var vo:LetterBubbleVo in list )
			{
				var key:String = vo.letter.toLocaleLowerCase();
				var bubble:LetterBubble = new LetterBubble();
				bubble.setData( vo );
				container.addChild( bubble );
				dictLetter[ key ] ||= [];
				dictLetter[ key ].push( bubble );
			}
		}

		private function timerHandler():void
		{
			totalTime--;
			if ( totalTime >= 0 )
				txtTime.htmlText = HtmlText.color( "00:" + ( totalTime < 10 ? "0" + totalTime : totalTime ), totalTime <= 10 ? 0xff0000 : 0xffff00 );
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
			if ( dictLetter )
			{
				var ary:Array = dictLetter[ key ];
				var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
				if ( bubble ) bubble.hint();
			}
		}

		public function setRoundName( roundName:String ):void
		{
			txtName.text = roundName;
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
			if ( dictLetter )
			{
				var ary:Array = dictLetter[ key ];
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
							var dist0:Number = ( mc1.width + mc2.width + 5 ) >> 1;
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
