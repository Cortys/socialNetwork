<?php
	include "block.php";
	include "init.php";
	
	$c = file_get_contents('dataStruct.sql');
	echo '<pre>';
	echo '<h3>'.(doSql($c)?'erfolgreich aktualisiert':'fehlgeschlagen: '.($db->error)).'</h3>';
	echo $c;
	echo '</pre>';
?>