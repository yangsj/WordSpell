package victor.framework.manager
{

	/**
	 * @author fireyang
	 */
	public interface ITickManager
	{
		function init( frameRate:int ):void;

		function doTimeout( func:Function, delay:int = 20, args:Array = null ):void;

		function doInterval( func:Function, delay:int = 20, args:Array = null ):void;

		function clearDoTime( func:Function ):void;
	}
}
