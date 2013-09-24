package victor.framework.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class MathUtil
	{
		public function MathUtil()
		{
		}
		
		/**
		 * 获取指定值在指定区间内
		 * @param value
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */
		public static function range(value : Number, min : int, max : int) : Number
		{
			if (value < min)
				value = min;
			
			else if (value > max)
				value = max;
			
			return value;
		}
		
		/**
		 * 指定的值是否在指定范围内
		 * @param value
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */
		public static function isRange(value : Number, min : int, max : int) : Boolean
		{
			if ( value < min || value > max )
				return false;
			
			return true;
		}
	}
}