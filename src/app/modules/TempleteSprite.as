package app.modules
{
	import flash.display.Sprite;
	
	import app.managers.LoaderManager;
	
	import victor.framework.components.Reflection;
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class TempleteSprite extends Sprite implements IDisposable
	{
		protected var _skin:Sprite;
		
		public function TempleteSprite()
		{
			super();
		}
		
		public function dispose():void
		{
		}
		
		protected function setSkinWithName( skinName:String, domainName:String = "" ):void
		{
			if ( skinName )
			{
				DisplayUtil.removedAll( this, false );
				_skin = getObj( skinName, domainName ) as Sprite;
				addChild( _skin );
				Reflection.reflection( this, _skin );
			}
		}
		
		protected function getObj( skinName:String, domainName:String = "" ):Object
		{
			return LoaderManager.instance.getObj( skinName, domainName );
		}
		
		
	}
}