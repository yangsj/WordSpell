package victor.framework.interfaces
{
	import flash.display.Stage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-1
	 */
	public interface IDebug
	{
		
		function warn( args:Array ):void;
		
		function debug( args:Array ):void;
		
		function error( args:Array ):void;
		
		function printServer( args:Array ):void;
		
		function initStage( stage:Stage, pass:String = " " ):void;
		
	}
}