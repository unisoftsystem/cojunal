<?php
/**
 * @package   T3 Blank
 * @copyright Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license   GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;
?>

<!-- FOOTER -->
<footer id="t3-footer" class="wrap t3-footer">

    <?php if ($this->checkSpotlight('footnav', 'footer-1, footer-2, footer-3, footer-4')) : ?>
        <!-- FOOT NAVIGATION -->
        <div class="container">
			<?php $this->spotlight('footnav', 'footer-1, footer-2, footer-3, footer-4') ?>
		</div>
		<!-- //FOOT NAVIGATION -->
	<?php endif ?>

	<section class="t3-copyright">
		<div class="container">
			<div class="row">
				<div class="<?php echo $this->getParam('t3-rmvlogo', 1) ? 'col-md-8' : 'col-md-12' ?> copyright <?php $this->_c('footer') ?>">
					<jdoc:include type="modules" name="<?php $this->_p('footer') ?>" />
				</div>
				<?php if ($this->getParam('t3-rmvlogo', 1)): ?>
					<div class="col-md-4 poweredby text-hide">
						<a class="t3-logo t3-logo-color" href="http://t3-framework.org" title="<?php echo JText::_('T3_POWER_BY_TEXT') ?>"
						   target="_blank" <?php echo method_exists('T3', 'isHome') && T3::isHome() ? '' : 'rel="nofollow"' ?>><?php echo JText::_('T3_POWER_BY_HTML') ?></a>
					</div>
				<?php endif; ?>
			</div>
		</div>
	</section>

    <div id="back-to-top" data-spy="affix" data-offset-top="300" class="back-to-top affix-top">
        <button class="btn btn-primary" title="Back to Top"><i class="fa fa-angle-up"></i></button>
    </div>

    <script type="text/javascript">
        (function($) {
            // Back to top
            $('#back-to-top').on('click', function(){
                $("html, body").animate({scrollTop: 0}, 500);
                return false;
            });
        })(jQuery);
    </script>

</footer>
<!-- //FOOTER -->