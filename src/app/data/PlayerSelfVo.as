package app.data
{
	
	/**
	 * ……玩家自己的数据
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class PlayerSelfVo extends PlayerBaseVo
	{
		public static var isInit:Boolean = false;
		public function PlayerSelfVo()
		{
			super();
			if ( isInit )
			{
				throw new Error("PlayerSelfVo不能重复创建");
			}
			isInit = true;
		}
	}
}