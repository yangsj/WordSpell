package app.modules.fight.panel.search
{
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.text.TextField;
	
	import app.modules.friend.model.FriendVo;
	
	import victor.framework.utils.StringUitl;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightSearchPanel extends FightSearchBasePanel
	{
		public var txtSearch:TextField;
		
		private var vecList:Vector.<FriendVo>;
		
		public function FightSearchPanel()
		{
			super();
		}
		
		public function setData(list:Vector.<FriendVo>):void
		{
			vecList = list;
			setDataList( list );
		}
		
		protected function textInputHandler(event:Event):void
		{
			TweenMax.killDelayedCallsTo( searchMatching );
			TweenMax.delayedCall(0.1, searchMatching );
		}
		
		private function searchMatching():void
		{
			var input:String = txtSearch.text;
			var vec:Vector.<FriendVo>;
			if ( StringUitl.isEmpty( input ) == true )
				vec = vecList;
			else {
				vec = new Vector.<FriendVo>();
				for each ( var vo:FriendVo in vecList ) {
					if ( vo && vo.name.search( input ) != -1 ) {
						vec.push( vo );
					}
				}
			}
			setDataList( vec );
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			txtSearch.addEventListener(Event.CHANGE, textInputHandler );
		}
		
		override protected function beforeRender():void
		{
			super.beforeRender();
			createScroll( 264, 290 );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightSearchPanel";
		}
		
	}
}