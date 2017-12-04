<?php
/** 
 *------------------------------------------------------------------------------
 * @package       Solveto by iThemesLab
 *------------------------------------------------------------------------------
 * @copyright     Copyright (C) 2014 iThemesLab.com. All Rights Reserved.
 * @author        iThemesLab
 * @Link:         http://ithemeslab.com 
 *------------------------------------------------------------------------------
 */

defined('_JEXEC') or die;
?>

<!DOCTYPE html>
<html lang="<?php echo $this->language; ?>" dir="<?php echo $this->direction; ?>"
	  class='<jdoc:include type="pageclass" />'>

<head>
	<jdoc:include type="head" />
	<?php $this->loadBlock('head') ?>
	<?php $this->addCss('home') ?>
</head>

<body>

<div class="t3-wrapper"> <!-- Need this wrapper for off-canvas menu. Remove if you don't use of-canvas -->

	<?php $this->loadBlock('header') ?>

	<?php $this->loadBlock('mainbody-home-6') ?>

	<?php $this->loadBlock('footer') ?>

</div>


</body>
</html>