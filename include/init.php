<?
	session_start();
	error_reporting(E_ALL);
	
	require_once "db.php";
	
	function doSql($sql, $opt=null) {
		global $db;
		if(count(explode("\n", $sql)) > 1)
			return !!($db->multi_query($sql));
		
		$erg = $db->query($sql);
		if(!$erg)
			return false;
		
		if(preg_match("/^SELECT/", $sql)) { //select abfrage
			$r = array();
			while($line = $erg->fetch_array($opt?$opt=='SIMPLE'?MYSQLI_ASSOC:$opt:MYSQLI_BOTH)) {
				if(count($line) == 1 && $opt == 'SIMPLE')
					$line = $line[0];
				array_push($r, $line);
			}
			return $r;
		}
		if(preg_match("/^INSERT/", $sql)) //db insert
			return mysqli_insert_id($db);
		
		return true;
	}
	
	function preparedRead($stmt) {
		$parameters = array();
		$results = array();
		$row = array();
		
		$meta = $stmt->result_metadata();
		while ($field = $meta->fetch_field()) {
			$parameters[] = &$row[$field->name];
		}
		
		call_user_func_array(array($stmt, 'bind_result'), $parameters);
		
		if($stmt->fetch()) {
			foreach($row as $k => $v) {
				$results[$k] = $v;
			}
		}
		else
			$results = 0;
		$stmt->free_result();
		
		return $results;
	}
	
	function noInject($val) {
		return htmlentities(str_replace(";","",$val), ENT_QUOTES, 'UTF-8', false);
	}
?>