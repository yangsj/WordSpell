<?php
	include_once("log.php");
	
	
	function changeApplicationXmlVersions($file, $parent_url)
	{
		$url = str_ireplace("\\", "/", $parent_url );

		$doc = new DOMDocument();
		$doc->load($file);
		
		$assests = $doc->getElementsByTagName("asset");

		foreach($assests as $ai)
		{
			$src = $ai->getAttribute("src");
			$id = $ai->getAttribute("id");
			$file_url = $url.$src;
			if ( file_exists($file_url))
			{
				// 生成md5
				$md5_str = md5_file($file_url);
				$new_src = str_ireplace($id, $md5_str, $src);
				$new_name = str_ireplace($id, $md5_str, $file_url);

				// 修改配置
				$ai -> setAttribute("src", $new_src);
				// 重命名文件名
				rename($file_url, $new_name);
			}
		}

		$doc->save($file);
	}


	function changeApplicationXml($file, $versionNum, $subver)
	{
		$filename = $file;
		$appfd = fopen($filename, "r+");
		$contents = fread($appfd, filesize($filename));
		$contents = preg_replace("/version=\"[0-9]+\"/i", "version=\"".$versionNum."_".$subver."\"", $contents);
		fclose($appfd);
		
		$appfd = fopen($filename, "r+");
		fwrite($appfd, $contents);
		fclose($appfd);
	}

	function changeConfigXml($file, $lang)
	{
		$filename = $file;
		$appfd = fopen($filename, "r+");
		$contents = fread($appfd, filesize($filename));

		$contents = preg_replace("/item name=\"language\" value=\"[a-zA-z_0-9]+\"/", "item name=\"language\" value=\"".$lang."\" ", $contents);
		fclose($appfd);
		
		$appfd = fopen($filename, "w+");
		fwrite($appfd, $contents);
		fclose($appfd);
	}
	
?>