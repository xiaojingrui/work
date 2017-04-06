<?php

function smarty_function_percentage($params, &$smarty)
{

    $first = $params["first"];
    $second = $params["second"];
    $total = $first + $second;

    if($first == 0 && $second == 0){
        return 0;
    }

    if($first != $second){
        if($first > $second){
            $result = $first / $total * 100;
        } else {
            $result = 100 - $second / $total * 100;
        }
    } else {
        $result = 50;
    }

    return $result;
}