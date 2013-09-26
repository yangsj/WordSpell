package app.modules.login.register
{
	import app.core.components.controls.combo.ComboData;
	import app.core.components.controls.combo.ComboItemVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-26
	 */
	public class RegisterConfig
	{
		public function RegisterConfig()
		{
		}
		
		private static const AREA_NAME:Array = [[ "请选择", null], 
												[ "黄浦区", 1 ], 
												[ "卢湾区", 2 ], 
												[ "金山区", 3 ], 
												[ "徐汇区", 4 ], 
												[ "长宁区", 5 ], 
												[ "静安区", 6 ], 
												[ "普陀区", 7 ], 
												[ "闸北区", 8 ], 
												[ "虹口区", 9 ], 
												[ "杨浦区", 10 ], 
												[ "闵行区", 11 ], 
												[ "宝山区", 12 ], 
												[ "嘉定区", 13 ], 
												[ "浦东新区", 14 ], 
												[ "松江区", 15 ], 
												[ "青浦区", 16 ], 
												[ "南汇区", 17 ], 
												[ "奉贤区", 18 ], 
												[ "崇明县", 19 ]
											];

		private static const GRADE_NAME:Array = [[ "请选择", null ], 
												[ "一年级", 1 ], 
												[ "二年级", 2 ], 
												[ "三年级", 3 ], 
												[ "四年级", 4 ], 
												[ "五年级", 5 ], 
												[ "六年级（预初）", 6 ], 
												[ "初一", 7 ], 
												[ "初二", 8 ], 
												[ "初三", 9 ], 
												[ "高一", 10 ], 
												[ "高二", 11 ], 
												[ "高三", 12 ]
											];
		
		
		private static var _areaComboData:ComboData;
		
		/**
		 * 区县数据
		 */
		public static function get areaComboData():ComboData
		{
			if ( _areaComboData == null )
			{
				var itemVo:ComboItemVo;
				_areaComboData = new ComboData();
				for each ( var ary:Array in AREA_NAME )
				{
					itemVo = new ComboItemVo();
					itemVo.label = ary[0];
					itemVo.data  = ary[1];
					_areaComboData.addItem( itemVo );
				}
			}
			return _areaComboData;
		}
		
		private static var _gradeComboData:ComboData;
		
		/**
		 * 年级数据
		 */
		public static function get gradeComboData():ComboData
		{
			if ( _gradeComboData == null )
			{
				var itemVo:ComboItemVo;
				_gradeComboData = new ComboData();
				for each ( var ary:Array in GRADE_NAME )
				{
					itemVo = new ComboItemVo();
					itemVo.label = ary[0];
					itemVo.data  = ary[1];
					_gradeComboData.addItem( itemVo );
				}
			}
			return _gradeComboData;
		}
		

	}
}