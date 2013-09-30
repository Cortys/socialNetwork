<?
	require_once "init.php";
	$n = noInject($_POST["mail"]);
	$p = $_POST["pass"];
	/*$sql = "SELECT *, count(id) AS zahl FROM accounts WHERE mail='$n' AND activate=''";
	$erg = $db->query($sql);
	$d = $erg->fetch_array(MYSQLI_ASSOC);
	if($d["pass"] == md5($p.$salts[$d["salt"]])) {
		$iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB);
		$iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
		$z = time();
		$zC = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5(date("W")), $z, MCRYPT_MODE_ECB, $iv);
		$login = array($d['mail'], md5($z.$d['pass'].$z), $zC, $d['id']);
		$_SESSION['ermeto24'] = $login;
		echo "LOGGED";
	}
	else
		echo "WRONG";*/
?>