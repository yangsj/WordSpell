package app.modules.fight.view.alone
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellArea;
	import app.utils.appStage;
	
	import victor.framework.core.LoadViewBase;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	
	
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
		
		public function delLetterFromDict( key:String ):void
		{
			delete dict[ key ];
		}
		
		public function setLettersPool( ary:Array ):void
		{
			dict = new Dictionary();
			DisplayUtil.removedAll( container, false );
			for each ( var letter:String in ary )
			{
				var bubble:LetterBubble = new LetterBubble();
				bubble.setLabel( letter );
				container.addChild( bubble );
				dict[ letter ] = bubble;
			}
		}
		
		override public function hide():void
		{
			super.hide();
			appStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		override protected function addToParent():void
		{
			ViewStruct.addChild( this, ViewStruct.SCENE2 );
			appStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		protected function keyDownHandler(event:KeyboardEvent):void
		{
			var charCode:int = event.charCode;
			var key:String = String.fromCharCode( charCode ).toLocaleLowerCase();
			if ( "abcdefghijklmnopqrstuvwxyz".search( key ) != -1 )
			{
				var bubble:LetterBubble = dict[ key ];
				if ( bubble )
				{
					bubble.selected( true );
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