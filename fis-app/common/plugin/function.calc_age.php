<?php

function smarty_function_calc_age($params, &$smarty)
{
	$birthday = $params["birth"];
	$age = date('Y', time()) - date('Y', strtotime($birthday)) - 1;
	if (date('m', time()) == date('m', strtotime($birthday))){  
		if (date('d', time()) > date('d', strtotime($birthday))){  
		  $age++;  
		}  
	}elseif (date('m', time()) > date('m', strtotime($birthday))){  
		 $age++;  
	}  
	return $age;
}
