package app.startup
{
	import app.events.ViewEvent;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.interfaces.IView;
	import victor.framework.log.Logger;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-6
	 */
	public class ShowViewCommand extends BaseCommand
	{
		[Inject]
		public var event:ViewEvent;

		public function ShowViewCommand()
		{
			super();
		}

		override public function execute():void
		{
			if ( event )
			{
				var viewName:String = event.viewName;
				var view:IView;
				if ( viewName )
				{
					var cls:Class = getViewByName(viewName ) as Class;
					if ( cls )
					{
						view = injector.getInstance( cls );
						if ( view )
						{
							if ( event.type == ViewEvent.SHOW_VIEW )
							{
								view.data = event.data;
								if ( view.parent == null )
									view.show();
							}
							else if ( event.type == ViewEvent.HIDE_VIEW )
							{
								if ( view.parent )
									view.hide();
							}
						}
					}
					else
					{
						Logger.error( "找不到[" + viewName + "]绑定的类" );
					}
				}
				else
				{
					Logger.error( "viewName不存在！" );
				}
			}
		}
	}
}
