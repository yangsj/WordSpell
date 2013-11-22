package app.modules.fight.view.alone
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
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
		
		override public function initialize( isDisplayTime:Boolean = true ):void
		{
			selfTotalTime = 60;
			super.initialize( isDisplayTime );
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

		override public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
			points=[[41,44.2],[121.8,44.2],[202.6,44.2],[283.4,44.2],[364.2,44.2],[445,44.2],[525.8,44.2],[606.6,44.2],[687.4,44.2],[768.2,44.2],[849,44.2],[41,238.6],[121.8,238.6],[202.6,238.6],[283.4,238.6],[364.2,238.6],[445,238.6],[525.8,238.6],[606.6,238.6],[687.4,238.6],[768.2,238.6],[849,238.6],[41,141.4],[121.8,141.4],[202.6,141.4],[283.4,141.4],[364.2,141.4],[445,141.4],[525.8,141.4],[606.6,141.4],[687.4,141.4],[768.2,141.4],[849,141.4],[41,335.8],[121.8,335.8],[202.6,335.8],[283.4,335.8],[364.2,335.8],[445,335.8],[525.8,335.8],[606.6,335.8],[687.4,335.8],[768.2,335.8],[849,335.8]];
			dictLetterSelf = new Dictionary();
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
			{
				selfTotalTime += 5;
				Tips.showCenter( "时间 +5s" );
			}
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

		override public function setRoundName( roundName:String, isDisplayTime:Boolean = true ):void
		{
			bgName.visible = isDisplayTime;
			txtName.visible = isDisplayTime;
			txtName.text = roundName;
		}
		
		override protected function enterFrameHandler( event:Event = null ):void
		{
			hitTestCheck( container );
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_MainPanel";
		}
	}
}
