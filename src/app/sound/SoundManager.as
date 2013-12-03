package app.sound
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import app.managers.LoaderManager;
	
	import org.robotlegs.mvcs.Actor;
	
	import victor.framework.debug.Debug;
	
	
	public class SoundManager extends Actor
	{
		
		/**当前背景音乐*/
		private static var currSound:Sound;
		private static var currSoundChannel:SoundChannel;
		private static var dictSound:Dictionary = new Dictionary();
		private static var sndTransformBg:SoundTransform = new SoundTransform(0.3);
		private static var sndTransformEffect:SoundTransform = new SoundTransform(1);
		
		public function SoundManager()
		{
		}	
		
		public static function stopSound():void{
			if(currSoundChannel){
				currSoundChannel.stop();
			}
		}
		
		/**
		 * 主界面背景音乐
		 */
		public static function playMainSceneSoundBg():void
		{
			playSound( SoundType.mainSceneBgSound );
		}
		
		/**
		 * 战斗界面背景音乐
		 */
		public static function playFightSoundBg():void
		{
			playSound( SoundType.fightSceneBgSound + int( Math.random() * 2 ) );
		}
		
		private static function playSound( soundName:String ):void{
			
			stopSound();
			
			if ( currSound ) {
				currSound.removeEventListener(Event.COMPLETE, loadCompleted );
				currSound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler );
			}
			
			currSound = dictSound[soundName] as Sound;
			if ( currSound ) {
				currSoundChannel = currSound.play( 0, int.MAX_VALUE, sndTransformBg );
			} else {
				var url:String = LoaderManager.getUrl( soundName );
				var urlReq:URLRequest = new URLRequest( url );
				currSound = new Sound( urlReq );
				currSound.addEventListener(Event.COMPLETE, loadCompleted );
				currSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler );
				
				Debug.debug( "load sound:" + url );
			}
			function loadCompleted( event:Event ):void {
				dictSound[soundName] = currSound;
				playSound( soundName );
			}
			
			function ioErrorHandler( event:IOErrorEvent ):void {
				Debug.error( "加载" + soundName + "出错  | " +　event.text );
			}
		}
		
		protected static function onSoundCompleteEvent(event:Event):void
		{
			if(currSound){
				currSoundChannel=currSound.play(0,9999999);
				currSoundChannel.removeEventListener(Event.SOUND_COMPLETE,onSoundCompleteEvent);
			}
		}	
		
		public static function playEffectMusic( soundType:String ):void
		{
			var sound:Sound = LoaderManager.getObj( soundType ) as Sound;
			if ( sound ) {
				sound.play( 0, 0, sndTransformEffect );
			}
		} 
	}
}
