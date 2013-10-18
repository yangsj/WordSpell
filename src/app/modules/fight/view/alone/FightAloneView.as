package app.modules.fight.view.alone
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	import app.utils.TextUtil;
	
	import victor.framework.utils.DisplayUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-27
	 */
	public class FightAloneView extends FightBaseView
	{
		// 所属地图名称
		public var txtName:TextField;

		private var dictProps:Dictionary;

		public function FightAloneView()
		{
			super();
		}

		override protected function onceInit():void
		{
			super.onceInit();
			
			txtName = TextUtil.cloneText( txtName );
			txtTime = TextUtil.cloneText( txtTime );
		}

		override public function initialize():void
		{
			dictProps = new Dictionary();
			
			super.initialize();
		}
		
		override public function clear():void
		{
			super.clear();
			selfTotalTime = 0;
			dictProps = null;
		}

		override public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
			var ary:Array = dictLetterSelf[ letter.toLocaleLowerCase()];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dictLetterSelf[ letter.toLocaleLowerCase()] = ary;
			}
			else
			{
				delete dictLetterSelf[ letter.toLocaleLowerCase()];
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

		override public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
			dictLetterSelf = new Dictionary();
			DisplayUtil.removedAll( container, false );
			for each ( var vo:LetterBubbleVo in list )
			{
				var key:String = vo.letter.toLocaleLowerCase();
				var bubble:LetterBubble = new LetterBubble();
				bubble.setData( vo );
				container.addChild( bubble );
				dictLetterSelf[ key ] ||= [];
				dictLetterSelf[ key ].push( bubble );
			}
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			if ( isSelf )
				selfTotalTime += 5;
		}
		
		/**
		 * 使用 扫帚
		 */
		override public function useBroomProp( isSelf:Boolean = true ):void
		{
		}
		
		override protected function timerHandler():void
		{
			selfTotalTime--;
			setTimeText( txtTime, selfTotalTime );
		}

		override public function setRoundName( roundName:String ):void
		{
			txtName.text = roundName;
		}
		
		override protected function enterFrameHandler( event:Event = null ):void
		{
			hitTestCheck( container );
		}

		override protected function get resNames():Array
		{
			return [ "ui_fight" ];
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_MainPanel";
		}
	}
}
