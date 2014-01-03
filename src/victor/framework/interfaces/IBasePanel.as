package victor.framework.interfaces
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-1-4
	 */
	public interface IBasePanel
	{
		function show():void;
		function hide():void;
		
		function get parent():DisplayObjectContainer;
	}
}