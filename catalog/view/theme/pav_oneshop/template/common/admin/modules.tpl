<?php 
	$d = array(
		'demo_widget_aboutus_data'=>'
			<div class="box-content">
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit phasellus et lacus ac turpis euismod elementum a sit amet est nulla.</p> 
				<ul class="list">
					<li><span class="fabox"><i class="fa fa-map-marker">&nbsp;</i></span>
						<span>123 Street name, California, USA</span></li>
					<li><span class="fabox"><i class="fa fa-mobile-phone">&nbsp;</i></span>
						<span>+ (00) 123 456 789 / + (00) 123 456 788</span></li>
					<li><span class="fabox"><i class="fa fa-envelope-o">&nbsp;</i></span>
						<span>Contact@oneshop.com</span></li>
					<li><span class="fabox"><i class="fa fa-skype">&nbsp;</i></span>
						<span>oneshop_support</span></li>	
				</ul>
			</div>
		',
		'demo_widget_stayconnect_data'=>'
			<div class="box-content">
				<div class="social">
					<p>Class aptent taciti sociosqu ad litora torquent per conbia nostra per inceptos</p>
					<ul>
						<li class="facebook"><a href="#"><i class="fa fa-facebook stack"><span>Facebook</span></i></a></li>
						<li class="twitter"><a href="#" class="twitter"><i class="fa fa-twitter stack"><span>Twitter</span></i></a></li>
						<li class="google"><a href="#"><i class="fa fa-google-plus stack"><span>Google Plus</span></i></a></li>
						<li class="youtube"><a href="#"><i class="fa fa-youtube stack"><span>Youtube</span></i></a></li>
						<li class="pinterest"><a href="#"><i class="fa fa-pinterest stack"><span>Printerest</span></i></a></li>
					</ul>
				</div>
				<div class="payment"><div class="box-heading"><span>Payment Methods</span></div>
					<ul>
						<li class="paypal"><a href="#"><span>Playpal</span></a></li>
						<li class="visa"><a href="#"><span>Visa</span></a></li>
						<li class="master"><a href="#"><span>master</span></a></li>
						<li class="ebay"><a href="#"><span>Ebay</span></a></li>
						<li class="weston"><a href="#"><span>Weston</span></a></li>
					</ul>
				</div>
			</div>
		'
	);
	$module = array_merge( $d, $module );

//	echo '<pre>'.print_r( $languages, 1 );die;
?>

<div class="inner-modules-wrap">
	<div class="vtabs mytabs" id="my-tab-innermodules">
		<a onclick="return false;" href="#tab-imodule-footer" class="selected"><?php echo $this->language->get('Footer');?></a>
	 </div>

	 		<div class="page-tabs-wrap">
	 		<div id="tab-imodule-footer">
	 			<h4><?php echo $this->language->get( 'About Us' ) ; ?></h4>
				<div id="language-widget_aboutus_data" class="htabs mytabstyle">
		            <?php foreach ($languages as $language) { ?>
		            <a href="#tab-language-widget_aboutus_data-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
		            <?php } ?>
		          </div>

				<?php foreach ($languages as $language) {   ?>
		          <div id="tab-language-widget_aboutus_data-<?php echo $language['language_id']; ?>">
		           
		            <table class="form">
		            	<?php $text =  isset($module['widget_aboutus_data'][$language['language_id']]) ? $module['widget_aboutus_data'][$language['language_id']] : $module['demo_widget_aboutus_data'];  ?>

		              <tr>
		                <td><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $this->language->get('About Us Module');?>: </td>
		                <td><textarea name="themecontrol[widget_aboutus_data][<?php echo $language['language_id']; ?>]" id="widget_aboutus_data-<?php echo $language['language_id']; ?>" rows="5" cols="60"><?php echo $text; ?></textarea></td>
		              </tr>
		            </table>
		          </div>
		          <?php } ?>

		        <h4><?php echo $this->language->get( 'Stay Connect' ) ; ?></h4>
				<div id="language-widget_stayconnect_data" class="htabs mytabstyle">
		            <?php foreach ($languages as $language) { ?>
		            <a href="#tab-language-widget_stayconnect_data-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
		            <?php } ?>
		          </div>

				<?php foreach ($languages as $language) {   ?>
		          <div id="tab-language-widget_stayconnect_data-<?php echo $language['language_id']; ?>">
		           
		            <table class="form">
		            	<?php $text =  isset($module['widget_stayconnect_data'][$language['language_id']]) ? $module['widget_stayconnect_data'][$language['language_id']] : $module['demo_widget_stayconnect_data'];  ?>

		              <tr>
		                <td><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $this->language->get('Stay Connect');?>: </td>
		                <td><textarea name="themecontrol[widget_stayconnect_data][<?php echo $language['language_id']; ?>]" id="widget_stayconnect_data-<?php echo $language['language_id']; ?>" rows="5" cols="60"><?php echo $text; ?></textarea></td>
		              </tr>
		            </table>
		          </div>
		          <?php } ?>

		       

				<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 

				<script type="text/javascript"><!--
				$("#language-widget_aboutus_data a").tabs();
				<?php foreach( $languages as $language )  { ?>
				CKEDITOR.replace('widget_aboutus_data-<?php echo $language['language_id']; ?>', {
					filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
				});
				<?php } ?>
				//--></script> 

				<script type="text/javascript"><!--
				$("#language-widget_stayconnect_data a").tabs();
				<?php foreach( $languages as $language )  { ?>
				CKEDITOR.replace('widget_stayconnect_data-<?php echo $language['language_id']; ?>', {
					filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
				});
				<?php } ?>
				//--></script> 

			</div>
	 </div>
	 <div class="clearfix clear"></div>	
</div>

