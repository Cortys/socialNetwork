<?php
	define(IS_HTTPS, isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on');
	define(FORCE_HTTPS, true);
	define(HTTPS_LINK, 'https://ssl-id.de/la-mann.com/socialNetwork');
?>