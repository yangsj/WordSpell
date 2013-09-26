package victor.framework.manager
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * @author fireyang
	 */
	public class TickManager implements ITickManager
	{
		private var _ticker:Shape;
		// 上一次时间
		private var _lastTime:int;
		private var _stepTime:int;
		private var _correctTime:int;
		private var _timeQueue:Vector.<TimeVO>;
		private static var _instance:ITickManager;

		// = new Vector.<TimeVO>();
		public function init( frameRate:int ):void
		{
			if ( _ticker )
			{
				return;
			}
			_timeQueue = new Vector.<TimeVO>();
			_stepTime = int( 1000 / frameRate );
			_ticker = new Shape();
			_lastTime = getTimer();
			var _timer:Timer = new Timer( 10 );
			_timer.addEventListener( TimerEvent.TIMER, onTick );
			_timer.start();
			// _ticker.addEventListener(Event.ENTER_FRAME, onTick);
		}

		public static function get instance():ITickManager
		{
			if ( _instance == null )
			{
				_instance = new TickManager();
			}
			return _instance;
		}

		public function doTimeout( func:Function, delay:int = 20, ... args ):void
		{
			clearDoTime( func );
			var t:TimeVO = new TimeVO( func, Math.max( delay, 20 ), args, _correctTime || getTimer(), 1, false );
			_timeQueue.push( t );
		}

		public function doInterval( func:Function, delay:int = 20, ... args ):void
		{
			clearDoTime( func );
			var t:TimeVO = new TimeVO( func, Math.max( delay, 20 ), args, _correctTime || getTimer(), 1, true );
			_timeQueue.push( t );
		}

		/**
		 * 清除事件
		 */
		public function clearDoTime( func:Function ):void
		{
			// trace("clearDoTime");
			var index:int = 0;
			while ( index < _timeQueue.length )
			{
				if ( _timeQueue[ index ].func == func )
				{
					_timeQueue.splice( index, 1 );
					break;
				}
				index++;
			}
		}

		private function doTick():void
		{
			var timeObj:TimeVO = null;
			var curTime:int = _correctTime || getTimer();
			var index:int = 0;
			while ( index < _timeQueue.length )
			{
				timeObj = _timeQueue[ index ];
				if ( timeObj.delay <= 20 || curTime - timeObj.startTime >= timeObj.delay * timeObj.index )
				{
					if ( !timeObj.repeat )
					{
						_timeQueue.splice( index, 1 );
						index--;
					}
					timeObj.func.apply( null, timeObj.args );
					timeObj.index = int(( curTime - timeObj.startTime ) / timeObj.delay ) + 1;
				}
				index++;
			}
		}

		private function onTick( event:Event ):void
		{
			var nextTime:int = 0;
			var nowTime:int = getTimer();
			var deltaT:int = nowTime - _lastTime;
			if ( deltaT >= _stepTime )
			{
				// 跳帧处理
				nextTime = deltaT / _stepTime;
				var index:int = 0;
				_correctTime = _lastTime;
				while ( index < nextTime )
				{
					_correctTime = _lastTime + ( index + 1 ) * _stepTime;
					doTick();
					index++;
				}
				_lastTime = _correctTime;
				_correctTime = 0;
			}
		}
	}
}

class TimeVO
{
	public var func:Function;
	public var delay:int;
	public var args:*;
	public var startTime:int;
	public var index:int;
	public var repeat:Boolean;

	public function TimeVO( func:Function, delay:int, args:*, startTime:int = -1, index:int = 1, repeat:Boolean = true )
	{
		this.func = func;
		this.delay = delay;
		this.args = args;
		this.startTime = startTime;
		this.index = index;
		this.repeat = repeat;
	}
}
