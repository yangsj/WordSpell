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

	echo "<h2>��һ�������°汾�⵽���أ�</h2><div style='color:gray;font-size:8px;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	$svnupdateVers = "svn update ".$versionLibPath." --username ".$svnUser." --password ".$svnPwd;
	system($svnupdateVers);
	echo "</div>";

	$fullversionPath = $versionLibPath.$fullVersion."\\";

	echo $fullversionPath;
	
	$createPathCmd  = "if not exist ".$fullversionPath." md ".$fullversionPath;
	//echo "<h4 style='color:green;'> exec CMD:".$createPathCmd."</h4>";
	system($createPathCmd);
	
	//svn ����ļ���
	echo "<h4 style='color:green;'>";
	$svnaddFloder = "svn add ". $fullversionPath . " --force";
	system($svnaddFloder);
	echo "</h4>";

	//svn �ύ�ļ���
	echo "<h4 style='color:green;font-size:8px;'>";
	$svncommitFloder = "svn commit ".$fullversionPath." --username ".$svnUser." --password ".$svnPwd." --message ".$versionLog;
	echo "�ύ�����У�";
	echo $svncommitFloder;
	//system($svncommitFloder);
	echo "</h4>";
	
	//copy �ļ�
	//echo "<br>====================================================================================================<br>";
	echo "<h2>�ڶ����������ļ����汾Ŀ¼</h2><br>";
	//echo "=====================================================================================================<br>";
	
	echo "<div style='font-size:9px;color:gray;width:800px;height:150px;overflow:scroll;border:1px solid gray;'>";

	system("xcopy /Y ".$releaseFloader."*.swf ".$fullversionPath);
	system("xcopy /Y ".$releaseFloader."application.xml ".$fullversionPath);

	echo "<br />";echo "<br />";

	system("xcopy /S/Y ".$releaseFloader."assets\*.swf ".$fullversionPath."assets\\");

	echo "</div>";
	echo "<br>";
	
	/////////////////////////////////////////////////////////////////
	//�������԰汾
	include_once("changefiles.php");
	$subver = writeVersion($versionRem, $versionNum);
	////////////////////////////////////////////////////////////////


	//echo "<br>========================================================================================================<br>";
	echo "<h2>���������ύ�ļ����汾��</h2><br>";
	//echo "===========================================================================================================<br>";

	echo "<div style='font-size:9px;color:blue;width:800px;height:150px;overflow:scroll;border:1px solid gray;'>";
	$svnAddFiles = "svn add ".$fullversionPath."*.* --force";
	system($svnAddFiles);
	echo "</div>";

	echo "<h3 style='font-size:12px;'>";
	echo $svncommitFloder;
	echo "</h3>";


	echo "<div style='font-size:9px;color:green;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	system($svncommitFloder);

	$svncommitVersionRem = "svn commit ".$versionRem." --username ".$svnUser." --password ".$svnPwd." --message ".$versionLog;
	//echo $svncommitVersionRem;
	system($svncommitVersionRem);
	echo "</div>";


	///////������Դ�汾��Ϣ
	echo "<h3 style='font-size:12px;'>������Դ�汾��Ϣ</h3>";
	$filename5 = $fullversionPath."\\application.xml";
	$filename6 = $releaseFloader."\\application.xml";
	//echo $filename;
	changeApplicationXmlVersions($filename5, $versionNum, $subver);
	changeApplicationXmlVersions($filename6, $versionNum, $subver);

	system($svncommitFloder);

	echo "<br><h1>�����ɹ�</h1><br>";

	$_SESSION["start"] = null;
?>