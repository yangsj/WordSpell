###地图数据结构###
1. 世界地图数据结构：

		Array
		|____[0]MapVo章节1
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据（此部分可以考虑独立）【建第2点详息】
		|____[1]MapVo章节2
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据
		|____[2]MapVo章节3
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据
		|____[3]MapVo章节4
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据
		|____[4]MapVo章节5
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据
		|____[5]MapVo章节6
			|____id章节id
			|____status开启状态
			|____ChapterVo章节地图详细数据

2. 地图章节数据结构

	备注：使用即时拉取需要显示的章节地图数据（或使用缓存：拉取一次后，单独更新改变的部分）

		Array
		|____[0]ChapterVo
			|____mapId章节id
			|____chapterId
			|____status
			|____list小关卡数据列表（RoundVo）
				|____[0]RoundVo
					|____roundId关卡id
					|____starNum星级评分
					|____status开启状态
					|____type 关卡类型（简单、进阶、达人）
				|____[1]RoundVo
					|____roundId关卡id
					|____starNum星级评分
					|____status开启状态
					|____type 关卡类型（简单、进阶、达人）
				|____[2]RoundVo
					|____roundId关卡id
					|____starNum星级评分
					|____status开启状态
					|____type 关卡类型（简单、进阶、达人）
				|____[3]RoundVo
					|____roundId关卡id
					|____starNum星级评分
					|____status开启状态
					|____type 关卡类型（简单、进阶、达人）
				|____[4]RoundVo
					|____roundId关卡id
					|____starNum星级评分
					|____status开启状态
					|____type 关卡类型（简单、进阶、达人）
		|____[1]ChapterVo
		|____[2]ChapterVo
		|____[3]ChapterVo
		|____[4]ChapterVo
		|____[5]ChapterVo
		|____[6]ChapterVo
		|____[7]ChapterVo
		|____[8]ChapterVo
		|____[9]ChapterVo