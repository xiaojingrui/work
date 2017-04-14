<?php

/***
 * 这里的配置和后台开发的配置目录保持一致，不然会导致编译出来的模板失效，切记切记.
 * @author: yuhongfei@hupu.com
 * @date: 2015/12/07
 */

$root = '/data/www-data/hupu.com/m';
require_once($root . '/core/smarty/Smarty.class.php');
$frontRoot = '/data/www-data/hupu.com/front-end';

$smarty = new Smarty;
$smarty->template_dir = $frontRoot . '/template';
$smarty->compile_dir = $frontRoot . '/templates_c';
$smarty->config_dir = $frontRoot . '/config';
$smarty->cache_dir = $frontRoot . '/cache';
$smarty->addPluginsDir([$frontRoot . '/plugin']);
$smarty->left_delimiter = '{%';
$smarty->right_delimiter = '%}';

$smarty->compileAllTemplates(".tpl", true);
?>
