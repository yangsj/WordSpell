package app.modules.panel.personal.command
{
	import app.modules.ViewName;
	import app.modules.panel.personal.service.PersonalService;
	import app.modules.panel.personal.view.PersonalMediator;
	import app.modules.panel.personal.view.PersonalPanel;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalInitCommand extends BaseCommand
	{
		public function PersonalInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Personal, PersonalPanel, PersonalMediator );
			
			injectActor( PersonalService );
		}
		
	}
}