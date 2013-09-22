package app.startup
{
	import app.GameConfig;
	import app.core.Alert;
	import app.events.ServiceEvent;
	import app.modules.LoadingEffect;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.socket.ISocketManager;
	import victor.framework.socket.MessageSocket;
	import victor.framework.socket.SocketEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitServiceCommand extends BaseCommand
	{
		public function InitServiceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var socket : MessageSocket = new  MessageSocket( GameConfig.isDebug );
			injector.mapValue(ISocketManager, socket);
			socket.addEventListener(SocketEvent.CLOSE, onSocketClose);
			socket.addEventListener(SocketEvent.CONNECTED, onSocketConnected );
			socket.addEventListener(SocketEvent.IO_ERROR, onIoError );
			socket.addEventListener(SocketEvent.CALL_START, onStartCall );
			socket.addEventListener(SocketEvent.CALL_END, onEndCall );
			
			socket.connect( GameConfig.serverHost, GameConfig.serverPort );
		}
		
		private function onStartCall( event:SocketEvent ):void
		{
			LoadingEffect.show();
		}
		
		private function onEndCall( event:SocketEvent ):void
		{
			LoadingEffect.hide();
		}
		
		private function onSocketConnected( event:SocketEvent ):void
		{
			dispatch( new ServiceEvent( ServiceEvent.CONNECTED ));
		}
		
		private function failed():void
		{
			dispatch( new ServiceEvent( ServiceEvent.FAILED ));
			Alert.show( "连接失败！" );
			LoadingEffect.hide();
		}
		
		/**
		 * 连接关闭
		 */
		private function onSocketClose(event : SocketEvent) : void 
		{
			dispatch( new ServiceEvent( ServiceEvent.CLOSED ));
			Alert.show( "连接关闭！" );
			LoadingEffect.hide();
		}
		
		private function onIoError( event:SocketEvent ):void
		{
			Alert.show( "连接错误！" );
			LoadingEffect.hide();
		}
		
	}
}