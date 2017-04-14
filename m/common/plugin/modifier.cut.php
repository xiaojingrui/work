<?php

function smarty_modifier_cut($str, $max = 7)
{
	if (!is_string($str)) return "";
    // $chinese = preg_match("/[\x{4e00}-\x{9fa5}]/u", substr($str, 0, $max));
    // $chinese = count($chinese) ?: 0;
    // $max = $chinese + ($max - $chinese) * 2;
    return mb_substr($str, 0, $max);
}