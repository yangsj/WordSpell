package victor.framework.core
{
	import app.managers.LoaderManager;
	import app.modules.panel.PanelLoading;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class LoadViewBase extends ViewSprite
	{
		public function LoadViewBase()
		{
			super();
		}
		
		override final protected function firstRun():void
		{
		}
		
		override final public function show():void
		{
			if ( resNames && resNames.length == 0 )
				addDisplayList();
			else startLoadResource();
		}
		
		private function startLoadResource():void
		{
			PanelLoading.instance.show();
			LoaderManager.instance.load( resNames, addDisplayList, loadProgress, domainName );
		}
		
		private function loadProgress( perent:Number ):void
		{
			PanelLoading.instance.setProgressValue( perent );
		}
		
		private function addDisplayList():void
		{
			PanelLoading.instance.hide();
			
			createSkin();
			
			beforeRender();
			
			addToParent();
			
			afterRender();
		}
		
		/**
		 * 添加到显示列表前
		 */
		protected function beforeRender():void
		{
		}
		
		/**
		 * 添加到显示列表
		 */
		protected function addToParent():void
		{
		}
		
		/**
		 * 添加到显示列表后
		 */
		protected function afterRender():void
		{
		}
		
		/**
		 * 需要加载的资源在配置文件中名称清单，若是该数组的长度是0，则默认不加载
		 */
		protected function get resNames():Array
		{
			return [];
		}
	}
}