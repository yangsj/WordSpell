package app.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import app.managers.LoaderManager;

	import victor.framework.interfaces.IDisposable;
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-18
	 */
	public class SpriteClip extends Sprite implements IDisposable
	{
		private var _frameRate:int = 24;
		private var _bitmapList:Vector.<FrameVo>;
		private var _bitmap:Bitmap;
		private var _frameIndex:int;
		private var _totalFrames:int;

		public function SpriteClip( linkage:String, domainName:String = "", frameRate:int = 24 )
		{
			_frameRate = frameRate;
			setLinkage( linkage, domainName );
		}

		////////////////////////// public functions ///////////////////////////////

		public function dispose():void
		{
			stop();
			if ( _bitmapList )
			{
				while ( _bitmapList.length > 0 )
				{
					var frameVo:FrameVo = _bitmapList.pop();
					if ( frameVo )
						frameVo.dispose();
					frameVo = null;
				}
				_bitmapList = null;
			}
			DisplayUtil.removedFromParent( _bitmap );
			_bitmap = null;
		}

		public function setLinkage( linkage:String, domainName:String = "" ):void
		{
			if ( linkage )
				setClip( LoaderManager.getObj( linkage, domainName ) as MovieClip );
		}

		public function setClip( clip:MovieClip ):void
		{
			if ( clip )
			{
				drawBitmap( clip );
				refreshFrameRate( _frameRate );
			}
		}

		public function refreshFrameRate( frameRate:int = 24 ):void
		{
			_frameRate = frameRate;
			_bitmap = new Bitmap();
			addChild( _bitmap );
			start();
		}

		public function start():void
		{
			TickManager.instance.clearDoTime( loop );
			TickManager.instance.doInterval( loop, 1000 / _frameRate );
			loop()
		}

		public function stop():void
		{
			TickManager.instance.clearDoTime( loop );
		}

		///////////////////// private fucntions ///////////////////

		private function drawBitmap( clip:MovieClip ):void
		{
			dispose();

			var frameVo:FrameVo;
			var bmd:BitmapData;
			var rec:Rectangle;
			var matrix:Matrix = new Matrix();
			_frameIndex = 1;
			_totalFrames = clip.totalFrames;
			_bitmapList = new Vector.<FrameVo>( _totalFrames );
			for ( var i:int = 1; i <= _totalFrames; i++ )
			{
				clip.gotoAndStop( i );
				frameVo = new FrameVo();
				rec = clip.getBounds( clip );
				matrix.tx = -rec.x;
				matrix.ty = -rec.y;
				bmd = new BitmapData( rec.width, rec.height, true, 0 );
				bmd.draw( clip, matrix );
				frameVo.point = new Point( rec.x, rec.y );
				frameVo.bitmapData = bmd;
				_bitmapList[ i - 1 ] = frameVo;
			}
		}

		private function loop():void
		{
			var frameVo:FrameVo = _bitmapList[ _frameIndex % _totalFrames ];
			_bitmap.x = frameVo.x;
			_bitmap.y = frameVo.y;
			_bitmap.bitmapData = frameVo.bitmapData;
			_frameIndex++;
		}

		/////////////////////// getters/setters ///////////////

	}
}
import flash.display.BitmapData;
import flash.geom.Point;

import victor.framework.interfaces.IDisposable;

class FrameVo implements IDisposable
{
	public var point:Point;
	public var bitmapData:BitmapData;

	public function get x():Number
	{
		return point.x;
	}

	public function get y():Number
	{
		return point.y;
	}

	public function dispose():void
	{
		if ( bitmapData )
			bitmapData.dispose();
		point = null;
		bitmapData = null;
	}
}

