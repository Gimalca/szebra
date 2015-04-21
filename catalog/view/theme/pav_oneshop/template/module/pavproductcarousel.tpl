<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,9)+rand();	
	
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
<div class="productcarousel">
	<div class="box-heading <?php echo $prefix;?>"><span class="headding-title"><?php echo ($type_product == 'featured')?$this->language->get('text_featured_oneshop'):$heading_title; ?></span></div>
	<div class="box-content" >
 		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			
			<?php /*if( empty($message) ) { ?>
			<div class="box-description"><?php echo trim($message);?></div>
			<?php } */?>

			<?php if( count($products) > $itemsperpage ) { ?>
			<div class="carousel-controls hidden-xs">
				<a class="carousel-control left fa fa-angle-left" href="#productcarousel<?php echo $id;?>"   data-slide="prev"></a>
				<a class="carousel-control right fa fa-angle-right" href="#productcarousel<?php echo $id;?>"  data-slide="next"></a>
			</div>
			<?php } ?>
			<div class="carousel-inner ">		
			 <?php 
				$pages = array_chunk( $products, $itemsperpage);
			 ?>	
			  <?php foreach ($pages as  $k => $tproducts ) {   ?>
					<div class="item <?php if($k==0) {?>active<?php } ?>">
						<?php foreach( $tproducts as $i => $product ) { ?>
							<?php if( $i++%$cols == 0 ) { ?>
							  <div class="row box-product">
							<?php } ?>
								  <div class="col-lg-<?php echo $span;?> col-md-4 col-sm-4 col-xs-12">
								  	<div class="product-block">
								  	<div class="group-item">
							    		<?php if ($product['thumb']) { ?>
								      <div class="image <?php echo $swapimg; ?>">
								      	<?php if( $product['special'] ) {   ?>
											<span class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></span>
										<?php } ?>
								    	<div class="image_container">
											<a href="<?php echo $product['href']; ?>" class="img front"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"/></a>
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
								      	<?php /*if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
								      		<a href="<?php echo $zimage;?>" class="info-view colorbox product-zoom" rel="colorbox" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
								      	<?php }*/ ?>
								      </div>
								      <?php } ?>	        	
							    	</div>
									<div class="product-meta">
										<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
										<?php if(!empty($product['description'])){?>
										<?php if ($product['rating']) { ?>
											<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
											<?php } ?>
										<div class="description">
											<?php echo utf8_substr( strip_tags($product['description']),0,50);?>...
										</div><?php }?>
										<?php if ($product['price']) { ?>
										 <div class="price">
											  <?php if (!$product['special']) { ?>
											  <?php echo $product['price']; ?>
											  <?php } else { ?>
											  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
											  <?php } ?>
											</div>
										  <?php } ?> 
											<div class="cart">
											<a class="addtocart" onclick="addToCart('<?php echo $product['product_id']; ?>');" data-hover="Add to cart"><span><i class="fa fa-shopping-cart"></i><?php echo $button_cart; ?></span></a>
											</div>
											
								  	</div>
								  </div></div>
						  
						  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
							 </div>
							<?php } ?>
						<?php } //endforeach; ?>
					</div>
			  <?php } ?>
			</div>  
		</div>
 </div> </div>

<script type="text/javascript">
$('#productcarousel<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
</script>
