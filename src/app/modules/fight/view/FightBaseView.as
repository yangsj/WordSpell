package app.modules.fight.view
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellArea;
	import app.utils.appStage;
	
	import victor.framework.core.LoadViewBase;
	import victor.framework.core.ViewStruct;
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.HtmlText;
	import victor.framework.utils.MathUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightBaseView extends LoadViewBase
	{
		public var txtName:TextField;// 所属地图名称
		public var bgName:Sprite; // 名称底
		public var txtTime:TextField; // 时间显示
		public var bgTime:Sprite; // 时间底
		public var txtMoney:TextField; // 自己金钱数量显示
		public var container:Sprite; // 自己字母泡泡显示容器
		public var container2:Sprite;// 对手字母泡泡显示容器
		public var btnExit:InteractiveObject; // 退出【练习模式有】
		public var isAlone:Boolean = true;
		public var mapId:int = 0;
		
		private var _isValidOperate:Boolean = true;
		
		protected var spellArea:SpellArea;
		protected var propList:PropList;
		protected var effectContainer:Sprite;
		protected var dictLetterSelf:Dictionary;
		protected var selfTotalTime:int = 60;
		protected var dictProps:Dictionary;
		protected var dictCheckItem:Dictionary;
		protected var points:Array = [];
		
		public function FightBaseView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			spellArea = new SpellArea();
			addChild( spellArea );
			
			propList = new PropList();
			addChild( propList );
			
			effectContainer = new Sprite();
			addChild( effectContainer );
			
			btnExit ||= new Sprite();
			btnExit.addEventListener(MouseEvent.CLICK, onClickBtnExitHandler );
			
			mouseEnabled = false;
		}
		
		protected function onClickBtnExitHandler(event:MouseEvent):void
		{
			dispatchEvent( new FightAloneEvent( FightAloneEvent.EXIT_PRACTICE ));
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
		
		public function initialize( isDisplayTime:Boolean = true ):void
		{
			isValidOperate = true;
			
			appStage.addEventListener( KeyboardEvent.KEY_UP, keyDownHandler );
			appStage.focus = appStage;
			
			dictProps = new Dictionary();
			
			if ( bgName )
				bgName.visible = isDisplayTime;
			if ( txtTime )
				txtTime.visible = isDisplayTime;
			if ( bgTime )
				bgTime.visible = isDisplayTime;
			if ( isDisplayTime ) {
				timerHandler();
				TickManager.doInterval( timerHandler, 1000 );
			}
			TickManager.doInterval( enterFrameHandler, 20 );
		}
		
		public function clear():void
		{
			appStage.removeEventListener( KeyboardEvent.KEY_UP, keyDownHandler );
			TickManager.clearDoTime( enterFrameHandler );
			TickManager.clearDoTime( timerHandler );
			spellArea.clear();
			propList.clear();
			clearDict( dictLetterSelf );
			clearDict( dictProps );
			clearDict( dictCheckItem );
		}
		
		public function playAddMoneyEffect( num:int, point:Point ):void
		{
			if ( num > 0 )
			{
				// 252 26  // 820 30
				var endx:Number = isAlone ? 820 : 252;
				var endy:Number = isAlone ? 30 : 26;
				var mc:MovieClip = getObj("ui_Skin_AddMoneyEffectNum")as MovieClip;
				mc.txtNum.text = "+" + num;
				mc.x = point.x;
				mc.y = point.y;
				mc.gotoAndStop( mapId + 1 );
				effectContainer.addChild( mc ); 
				TweenMax.to( mc, 0.4, { x:endx, y:endy, ease:Linear.easeNone });
				TweenMax.to( mc, 0.3, { scaleX:0.1, 
										scaleY:0.1, 
										onComplete:DisplayUtil.removedFromParent, 
										onCompleteParams:[mc], 
										delay:0.4,
										ease:Back.easeIn });
				
				txtMoney.text = (int( txtMoney.text ) + 1) + "";
			}
		}
		
		public function playAddPropEffect( bubble:LetterBubble, point:Point ):void
		{
			var pos:Point = bubble.localToGlobal( new Point());
			bubble.x = pos.x;
			bubble.y = pos.y;
			effectContainer.addChild( bubble );
			TweenMax.to( bubble, 0.4, { x:point.x, y:point.y, ease:Linear.easeNone });
			TweenMax.to( bubble, 0.3, { scaleX:0.1, 
										scaleY:0.1, 
										ease:Back.easeIn, 
										delay:0.4, 
										onComplete:DisplayUtil.removedFromParent, 
										onCompleteParams:[bubble] });
		}
		
		public function delPropItemFromDict( itemType:int ):void
		{
			delete dictProps[ itemType ];
			delete dictProps[ itemType + "_data" ];
		}
		
		public function addPropItem( lettetVo:LetterBubbleVo, isSelf:Boolean = true ):void
		{
			if ( lettetVo ) 
			{
				if ( isSelf ) dictProps[ lettetVo.itemType + "_data" ] = lettetVo;
				else dictProps[ lettetVo.itemType + "_other" ] = lettetVo;
			}
		}
		
		public function displayPropItem( isSelf:Boolean = true ):void
		{
			var bubble:LetterBubble;
			var lettetVo:LetterBubbleVo;
			var point:Array;
			for ( var key:String in dictProps )
			{
				var selfKey:Boolean = key.indexOf( "_data" ) != -1;
				var destKey:Boolean = key.indexOf( "_other" ) != -1;
				if ( selfKey || destKey )
				{
					lettetVo = dictProps[ key ];
					point = points.splice(int(Math.random() * points.length), 1)[0];
					bubble = LetterBubble.itemInstance;
					bubble.setMoveArea( isAlone );
					bubble.setData( lettetVo );
					bubble.x = point[0];
					bubble.y = point[1];
					
					if ( isSelf ) dictProps[ lettetVo.itemType ] = bubble;
					
					if ( isSelf && selfKey ) container.addChild( bubble );
					else if ( isSelf==false && destKey ) container2.addChild( bubble );
				}
			}
		}
		
		public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
		}
		
		public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
		}
		
		public function setRoundName( roundName:String, isDisplayTime:Boolean = true ):void
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
				text.htmlText = getTimeString( seconds );
			
			function getTimeString( seconds:int ):String
			{
				if ( isAlone == false )
					return HtmlText.color( seconds + "", seconds <= 10 ? 0xff0000 : 0xffff00 );
				
				var min:int = int(seconds/60);
				var sec:int = seconds%60;
				return HtmlText.color( (min < 10 ? "0" + min : min) + ":" + (sec < 10 ? "0" + sec : sec), seconds <= 10 ? 0xff0000 : 0xffff00 );
			}
		}
		
		protected function clearDict( dict:Dictionary ):void
		{
			if ( dict ) {
				for ( var key:String in dict )
					delete dict[ key ];
			}
		}
		
		protected function timerHandler():void
		{
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			if ( isValidOperate )
			{
				var charCode:int = event.charCode;
				var key:String = String.fromCharCode( charCode ).toLocaleLowerCase();
				if ( dictLetterSelf && parent && !(event.target is TextField) )
				{
					var ary:Array = dictLetterSelf[ key ];
					var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
					
					if ( bubble ) bubble.selected( true );
					else Tips.showCenter( "按键无效" );
				}
			}
		}
		
		protected function enterFrameHandler( event:Event = null ):void
		{
		}
		
		protected function hitTestCheck( container:Sprite ):void
		{
			dictCheckItem ||= new Dictionary();
			clearDict( dictCheckItem );
			
			var mc1:LetterBubble, mc2:LetterBubble;
			for ( var i:int = 0; i < container.numChildren; i++ ) {
				mc1 = container.getChildAt( i ) as LetterBubble;
				if ( mc1 ) {
					for ( var j:int = 0; j < container.numChildren; j++ ) {
						mc2 = container.getChildAt( j ) as LetterBubble;
						if ( mc2 && mc1 != mc2 ) {
							
							var key1:String = mc1.name + mc2.name;
							var key2:String = mc2.name + mc1.name;
							if ( dictCheckItem[key1] || dictCheckItem[key2] ) continue;
							dictCheckItem[key1] = true;
							dictCheckItem[key2] = true;
							
							var dist0:Number = LetterBubble.RADIUS * ( mc1.scale + mc2.scale );
							var dist1:Number = MathUtil.distance( mc1.x, mc1.y, mc2.x, mc2.y) + 1;
							if ( dist1 <= dist0 ) {
								var rate:Number = ( dist0 / dist1 );
								var absx:Number = Math.abs( mc1.x - mc2.x );
								var absy:Number = Math.abs( mc1.y - mc2.y );
								var movex:Number = absx * rate;
								var movey:Number = absy * rate;
								var dx1:Number = mc1.direX;
								var dy1:Number = mc1.direY;
								var dx2:Number = mc2.direX;
								var dy2:Number = mc2.direY;
								
								// 校正泡泡的间距
								if ( dist1 < dist0 )
								{
									if ( mc1.x < mc2.x ) {
										if ( mc2.isEdgeRight )
											mc1.x = mc2.x - movex;
										else mc2.x = mc1.x + movex;
									} else {
										if ( mc2.isEdgeLeft )
											mc1.x = mc2.x + movex;
										else mc2.x = mc1.x - movex;
									}
									
									if ( mc1.y < mc2.y ) {
										if ( mc2.isEdgeDown )
											mc1.y = mc2.y - movey;
										else mc2.y = mc1.y + movey;
									} else {
										if ( mc2.isEdgeUp )
											mc1.y = mc2.y + movey;
										else mc2.y = mc1.y - movey;
									}
								}
								
								// 方式1：与原来方向相反
//								mc1.changeDirection( -1, -1 );
//								mc2.changeDirection( -1, -1 );
								
								// 方式2：可能改变一个方向，也可能改变两个方向
								if ( dx1 == dx2 ) {
									mc1.changeDirection( 1, -1 );
									mc2.changeDirection( 1, -1 );
								} else if ( dy1 == dy2 ) {
									mc1.changeDirection( -1, 1 );
									mc2.changeDirection( -1, 1 );
								} else　{
									if ( absx == absy )　{
										mc1.changeDirection( -1, -1 );
										mc2.changeDirection( -1, -1 );
									}　
									else　if ( absx > absy )　{
										mc1.changeDirection( -1, 1 );
										mc2.changeDirection( -1, 1 );
									}　else　{
										mc1.changeDirection( 1, -1 );
										mc2.changeDirection( 1, -1 );
									}
								}
							}
						}
					}
				}
			}
		}

		public function get isValidOperate():Boolean
		{
			return _isValidOperate;
		}

		public function set isValidOperate(value:Boolean):void
		{
			_isValidOperate = value;
			container.mouseChildren = value;
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight", "ui_prop_list" ];
		}

	}
}