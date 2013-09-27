package app.modules.fight.view.spell
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import app.managers.LoaderManager;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellArea extends Sprite
	{
		private var _skin:Sprite;
		
		public var txtChinese:TextField;
		
		public function SpellArea()
		{
			super();
			createSkin();
		}
		
		private function createSkin():void
		{
			_skin = LoaderManager.getObj( "ui_Skin_Round_SpellArea" ) as Sprite;
			addChild( _skin );
			txtChinese = _skin.getChildByName( "txtChinese" ) as TextField;
		}
		
		public function setInitData( spellVo:SpellVo ):void
		{
			txtChinese.text = spellVo.chinese;
			
		}
		
		/**
		 * 设置单个字母显示
		 * @param index 位置
		 * @param letter 字母
		 */
		public function setSingleLetter( index:int, letter:String ):void
		{
			
		}
		
	}
}