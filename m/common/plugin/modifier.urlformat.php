<?php

function smarty_modifier_urlformat($url, $page, $pn='/#{page}/i')
{
	if (!is_string($url)) return "";
    return preg_replace($pn, $page, $url);
}