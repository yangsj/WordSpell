<?php
	include_once("config.php");
	session_start();
	if(!$_SESSION["start"])
	{
		die("<h1>����ˢ���ظ�����</h1><a href='index.php'>��ʼ����</a>");
	}

	$versionNum = $_POST["versionNum"];
	$versionLog = $_POST["versionLog"];

	$versionLog = "�˰汾�������ݣ�" . $versionLog;

	if(!$versionNum)
	{
		die("<script>alert('�汾�Ż�汾���Բ���Ϊ��.');history.back();</script>");
	}

	$fullVersion = "ver_".$versionNum;
	echo "<h2>�����ύ�汾$fullVersion</h2>";
	echo "<hr />";

	echo "<h2>��һ�������°汾�⵽���أ�</h2><div style='color:gray;font-size:11px;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	$svnupdateVers = "svn update ".$versionLibPath." --username ".$svnUser." --password ".$svnPwd;
	system($svnupdateVers);
	echo "</div>";

	$fullversionPath = $versionLibPath.$fullVersion."\\";
	echo $fullversionPath;
	
	$createPathCmd  = "if not exist ".$fullversionPath." md ".$fullversionPath;
	system($createPathCmd);

	
	//svn ����ļ���
	//echo "<h4 style='color:green;'>";
	//$svnaddFloder = "svn add ". $fullversionPath . " --force";
	//system($svnaddFloder);
	//echo "</h4>";
	
	//copy �ļ�
	//echo "<br>====================================================================================================<br>";
	echo "<h2>�ڶ����������ļ����汾Ŀ¼</h2><br>";
	//echo "=====================================================================================================<br>";
	
	echo "<div style='font-size:12px;color:gray;width:800px;height:150px;overflow:scroll;border:1px solid gray;'>";
	
	//$assetsPath  = "if not exist ".$fullversionPath."\\assets md ".$fullversionPath;
	//$assetsFloder = "svn del ". $fullversionPath."\\assets\\*.swf";
	//system($assetsFloder);

	echo "<br />--------------------------------------";echo "<br />";

	system("copy /Y ".$releaseFloader."WordsSpell.swf ".$fullversionPath."Main.swf");
	system("xcopy /Y ".$releaseFloader."application.xml ".$fullversionPath);

	echo "<br />--------------------------------------";echo "<br />";

	system("xcopy /S/Y ".$releaseFloader."assets\\*.swf ".$fullversionPath."assets\\");
	system("xcopy /S/Y ".$releaseFloader."sound\\*.mp3 ".$fullversionPath."sound\\");

	echo "</div>";
	echo "<br>";
	
	/////////////////////////////////////////////////////////////////
	///////�������԰汾
	include_once("changefiles.php");
	$subver = writeVersion($versionRem, $versionNum);
	////////////////////////////////////////////////////////////////


	////////////////////////////////////////////////////////////////
	echo "<h2>���������ύ�ļ����汾��</h2>";

	///////������Դ�汾��Ϣ

	echo "<h4 style='color:green;font-size:12px;'>";
	echo "1���h��δʹ�õ����YԴ";
	echo "</h4>";

	echo "<div style='font-size:12px;color:green;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";

	// �����YԴ�汾����
	$filename5 = $fullversionPath."\\application.xml";
	$newArray = changeApplicationXmlVersions($filename5, $fullversionPath);

	// �h���汾Ŀ���δʹ�õ��YԴ
	$fileArray = glob($fullversionPath."assets\\*.swf");
	$fileArray = array_combine( $fileArray, glob($fullversionPath."sound\\*.mp3");
	foreach ( $fileArray as $fileUrl )
	{
		$fileUrl = str_ireplace("\\", "/", $fileUrl );
		$index = strrpos( $fileUrl, "/" ) + 1;
		$end = strrpos( $fileUrl, "." );
		$length = $end - $index;
		$fileName = substr( $fileUrl, $index, $length );
		if ( file_exists( $fileUrl ) ) {
			echo $fileName."_".$newArray[ $fileName ]."<br>";
			if ( $newArray[ $fileName ] != 1 ) {
				system( "svn del ".$fileUrl );
				echo "Delete ".$fileUrl."<br>";
			}
		}
	}
	echo "</div>";

	///////�ύ��svn///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//svn �ύ�ļ���
	echo "<h4 style='color:green;font-size:12px;'>";
	echo "2�������YԴ��ӵ��汾����";
	echo "</h4>";

	echo "<div style='font-size:12px;color:blue;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	$svnAddFiles = "svn add ".$fullversionPath."*.* --force";
	system($svnAddFiles);
	echo "</div>";
	
	//svn �ύ�ļ���
	$svncommitFloder = "svn commit ".$versionLibPath." --username ".$svnUser." --password ".$svnPwd." --message ".$versionLog;

	echo "<h4 style='color:green;font-size:12px;'>";
	echo "3�����°汾��";
	echo "</h4>";

	echo "<div style='font-size:12px;color:green;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	system($svncommitFloder);
	echo "</div>";

	////////////////////////////////////////////////////////////////

	echo "<br><h1>�����ɹ�</h1><br>";


	$_SESSION["start"] = null;
?>