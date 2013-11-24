package app.modules.panel.rank.view
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.panel.rank.model.RankVo;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-25
	 */
	public class RankItem extends TempleteSprite
	{
		public var txtRank:TextField;  // 名次
		public var txtName:TextField;  // 昵称
		public var txtLevel:TextField; // 等级
		public var txtValidity:TextField;  // 有效期
		public var txtHonor:TextField;// 荣誉
		
		private static const pool:Vector.<RankItem> = new Vector.<RankItem>();
		public static function get instance():RankItem
		{
			if ( pool && pool.length > 0 )
				return pool.pop();
			return new RankItem();
		}
		
		public function RankItem()
		{
			setSkinWithName( "ui_Skin_RankItem" );
		}
		
		protected function removedFromParentHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED, removedFromParentHandler );
			if ( pool )
				pool.push( this );
		}
		
		public function setData( data:RankVo ):void
		{
			addEventListener( Event.REMOVED, removedFromParentHandler );
			
			txtRank.text = data.rank.toString();
			txtName.text = data.name;
			txtLevel.text = "Lv." + data.level;
			txtValidity.text = data.validity;
			txtHonor.text = data.honor.toString();
		}
		
	}
}