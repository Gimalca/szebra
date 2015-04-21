<?php 
/******************************************************
 * @package Pav Product Tabs module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,999999999999);
	
	$themeConfig = $this->config->get('themecontrol');
	$categoryConfig = array( 
		'category_pzoom'				     => 0,
		'quickview'                          => 1,
		'show_swap_image'					 => 0,
	); 
	$categoryConfig     = array_merge($categoryConfig, $themeConfig );
	$categoryPzoom 	    = $categoryConfig['category_pzoom'];
	$swapimg            = ($categoryConfig['show_swap_image'])?'swap':'';
	$quickview          = $categoryConfig['quickview'];
?>
<div class="box pav-categoryproducts no-boxshadown">
<?php if( !empty($module_description) ) { ?>
 <div class="module-desc">
	<?php echo $module_description;?>
 </div>
 <?php } ?>
	<div class="box-content">
		<div class="box-heading" id="producttabs<?php echo $id;?>">
			<?php foreach( $tabs as $tab => $category ) { 
				if( empty($category) ){ continue;}
				$tab = 'cattabs';

				///	echo '<pre>'.print_r( $category,1 ); die; 
				$products = $category['products'];
				$icon = $this->model_tool_image->resize( $category['image'], 160, 36 ); 
				?>
				<div class="icon-image"><?php if ( $icon ) { ?><img src="<?php echo $icon;?>" alt=""/><?php } ?></div>
				<span class="category_name">
					<?php echo $category['category_name'];?>
				</span>	
			<?php } ?>
		</div>
		<div class="tab-content">  
			<?php foreach( $tabs as $tab => $category ) { 
			if( empty($category) ){ continue;}
			$tab = 'boxcats';

			$active = ($tab == 0)?'active':'';

			$products = $category['products'];
			$icon = $this->model_tool_image->resize( $category['image'], 45,45 ); 
			?>
			<div class="tab-pane cat-products-block <?php echo $category['class']." ".$active;?> clearfix" id="tab-cattabs<?php echo $id.$category['category_id'];?>">	
		<?php if( count($products) > $itemsperpage ) { ?>
			<div class="carousel-controls hidden-xs">
				<a class="carousel-control left fa fa-angle-left" href="#<?php echo $tab.$id.$category['category_id'];?>"   data-slide="prev"></a>
				<a class="carousel-control right fa fa-angle-right" href="#<?php echo $tab.$id.$category['category_id'];?>"  data-slide="next"></a>
			</div>
			<?php } ?>
			<div class="box-products  pavproducts<?php echo $id;?> slide" id="<?php echo $tab.$id.$category['category_id'];?>">
			
			<div class="carousel-inner ">		
			 <?php $pages = array_chunk( $products, $itemsperpage);	 ?>	
			  <?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?> products-block">
					<?php foreach( $tproducts as $i => $product ) { ?>
						<?php if( $i++%$cols == 0 ) { ?>
						<div class="row products-item">
							<?php } ?>
							 <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 slide">
								  <div class="product-block clearfix ">
									<div class="product-inner">
									<div class="group-item">
							    		<?php if ($product['thumb']) { ?>
								      	<div class="image <?php echo $swapimg; ?>">
								      	<?php if( $product['special'] ) {   ?>
											<span class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></span>
										<?php } ?>
								    	<div class="image_container">
											<a href="<?php echo $product['href']; ?>" class="img front"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
											<!-- Show Swap -->
											<?php 
											if( $categoryConfig['show_swap_image'] ){
												$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
												if(isset($product_images) && !empty($product_images)) {
													$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
												?>	
												<a class="img back" href="<?php echo $product['href']; ?>">
													<img src="<?php echo $thumb2; ?>" alt="">
												</a>
											<?php } } ?>
										</div>	
										<?php if ($quickview) { ?>
										<a class="pav-colorbox hidden-sm hidden-md hidden-xs" href="index.php?route=themecontrol/product&amp;product_id=<?php echo $product['product_id']; ?>"><?php echo $this->language->get('quick_view'); ?></a>
										<?php } ?>
								      	<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
								      		<a href="<?php echo $zimage;?>" class="info-view colorbox-pavproduct product-zoom" rel="nofollow" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
								      	<?php } ?>
								      </div>
								      <?php } ?>	        	
						    	</div>
								<div class="product-meta">
								  <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3> 
								 
								  <div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,135);?>...</div>
								  <?php if ($product['price']) { ?>
									<div class="price">
									  <?php if (!$product['special']) { ?>
									  <?php echo $product['price']; ?>
									  <?php } else { ?>
									  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
									  <?php } ?>
									</div>
								  <?php } ?>
									
									
								</div>

								</div>
								</div>
							</div>
						  
						  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
						</div>
						<?php } ?>
					<?php } //endforeach; ?>
				</div>
			  <?php } ?>
			</div>  
			</div>
			</div>		
			<?php } // endforeach of tabs ?>	
		</div>

	</div>
</div>

<?php if( $categoryPzoom ) {  ?>
<script type="text/javascript">
<!--
  $(document).ready(function() {
    $('.colorbox-pavproduct').colorbox({
      overlayClose: true,
      opacity: 0.5,
      rel: false,
      onLoad:function(){
        $("#cboxNext").remove(0);
        $("#cboxPrevious").remove(0);
        $("#cboxCurrent").remove(0);
      }
    });
  });
//-->
</script>
<?php } ?>

<script type="text/javascript">
$(function () {
	$('.pavproducts<?php echo $id;?>').carousel({interval:99999999999999,auto:false,pause:'hover'});
	$('#producttabs<?php echo $id;?> span:first').tab('show');
});
</script>
