<?php
	if($_GET['pw'] != "infoprojekt") {
		header('Content-Type: text/html; charset=iso-8859-1');
		header("HTTP/1.0 404 Not Found");
		header_remove("X-Powered-By");
		die("<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL ".$_SERVER['REQUEST_URI']." was not found on this server.</p>
</body></html>
");
}
?>