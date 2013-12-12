package victor.framework.core
{
	import flash.display.Sprite;
	
	import victor.framework.manager.LoaderManager;
	
	import victor.core.Reflection;
	import victor.framework.interfaces.IDisposable;
	import victor.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class BaseSprite extends Sprite implements IDisposable
	{
		protected var _skin:Sprite;
		
		public function BaseSprite()
		{
			super();
		}
		
		public function dispose():void
		{
			DisplayUtil.removedFromParent( _skin );
			Reflection.disposeReflection( this );
			_skin = null;
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