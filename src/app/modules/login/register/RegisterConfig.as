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
												[ "黄浦区", "黄浦区" ], 
												[ "卢湾区", "卢湾区" ], 
												[ "金山区", "金山区" ], 
												[ "徐汇区", "徐汇区" ], 
												[ "长宁区", "长宁区" ], 
												[ "静安区", "静安区" ], 
												[ "普陀区", "普陀区" ], 
												[ "闸北区", "闸北区" ], 
												[ "虹口区", "虹口区" ], 
												[ "杨浦区", "杨浦区" ], 
												[ "闵行区", "闵行区" ], 
												[ "宝山区", "宝山区" ], 
												[ "嘉定区", "嘉定区" ], 
												[ "浦东新区", "浦东新区" ], 
												[ "松江区", "松江区" ], 
												[ "青浦区", "青浦区" ], 
												[ "南汇区", "南汇区" ], 
												[ "奉贤区", "奉贤区" ], 
												[ "崇明县", "崇明县" ]
											];

		private static const GRADE_NAME:Array = [[ "请选择", null ], 
												[ "一年级", "一年级" ], 
												[ "二年级", "二年级" ], 
												[ "三年级", "三年级" ], 
												[ "四年级", "四年级" ], 
												[ "五年级", "五年级" ], 
												[ "六年级（预初）", "六年级（预初）" ], 
												[ "初一", "初一" ], 
												[ "初二", "初二" ], 
												[ "初三", "初三" ], 
												[ "高一", "高一" ], 
												[ "高二", "高二" ], 
												[ "高三", "高三" ]
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