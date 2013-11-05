package app.modules.task.view
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.task.model.TaskVo;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-5
	 */
	public class TaskItem extends TempleteSprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var txtDes:TextField;
		
		// 创建对象池
		private static const vecPools:Vector.<TaskItem> = new Vector.<TaskItem>();
		public static function get itemInstance():TaskItem
		{
			if ( vecPools && vecPools.length > 0 )
				return vecPools.pop();
			return new TaskItem();
		}
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function TaskItem()
		{
			setSkinWithName( "ui_Skin_TaskItem" );
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		private function addListeners():void
		{
			addEventListener( Event.REMOVED, removedFromParentHandeler );
		}
		
		private function removeListeners():void
		{
			removeEventListener( Event.REMOVED, removedFromParentHandeler );
		}
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function removedFromParentHandeler(event:Event):void
		{
			removeListeners();
			
			if ( vecPools ) vecPools.push( this );
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function setData( vo:TaskVo ):void
		{
			txtDes.htmlText = vo.fullDescribe;
			
			addListeners();
		}
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}