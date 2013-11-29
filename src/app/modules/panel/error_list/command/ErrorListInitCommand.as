package app.modules.panel.error_list.command
{
	import app.modules.ViewName;
	import app.modules.panel.error_list.model.ErrorListModel;
	import app.modules.panel.error_list.service.ErrorListService;
	import app.modules.panel.error_list.view.ErrorListMediator;
	import app.modules.panel.error_list.view.ErrorListView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListInitCommand extends BaseCommand
	{
		public function ErrorListInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.ErrorListPanel, ErrorListView, ErrorListMediator );
			
			injectActor( ErrorListModel );
			injectActor( ErrorListService );
		}
		
	}
}