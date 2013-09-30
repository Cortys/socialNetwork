<?php
	
	include 'include/config.php';
	if(FORCE_HTTPS && !IS_HTTPS) {
		header('Location: '.HTTPS_LINK);
	}
	
	include 'include/loggedIn.php';
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Social Network</title>
	
	<link rel="stylesheet" href="./embed/general.css" type="text/css">
	<link rel="stylesheet" href="./embed/logged<?php echo $login?'In':'Out'; ?>.css" type="text/css">
	
	<script type="text/javascript">
		var login = <?php echo $login?'true':'false'; ?>;
	</script>
	
	<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
	<![endif]-->
	<script src="./embed/frameworks/jquery2.js" type="text/javascript"></script>
	<script src="./embed/general.js" type="text/javascript"></script>
	<script src="./embed/logged<?php echo $login?'In':'Out'; ?>.js" type="text/javascript"></script>
</head>
<body>
	<?php
		include 'pages/logged'.($login?'In':'Out').'.php';
	?>
</body>
</html>