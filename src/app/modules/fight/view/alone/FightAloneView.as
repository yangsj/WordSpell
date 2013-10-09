package app.modules.fight.view.alone
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellArea;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	import app.utils.appStage;
	
	import victor.framework.core.LoadViewBase;
	import victor.framework.core.ViewStruct;
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.HtmlText;


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

		private var dict:Dictionary;

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
		}

		public function initialize():void
		{
			totalTime = 60;
			TickManager.doInterval( timerHandler, 1000 );
			timerHandler();
			appStage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		public function clear():void
		{
			appStage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
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
			dict = new Dictionary();
			DisplayUtil.removedAll( container, false );
			for each ( var vo:LetterBubbleVo in list )
			{
				var key:String = vo.letter.toLocaleLowerCase();
				var bubble:LetterBubble = new LetterBubble();
				bubble.setData( vo );
				container.addChild( bubble );
				dict[ key ] ||= [];
				dict[ key ].push( bubble );
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
			downKey( key );
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
			downKey( key );
		}
		
		private function downKey( key:String ):void
		{
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
