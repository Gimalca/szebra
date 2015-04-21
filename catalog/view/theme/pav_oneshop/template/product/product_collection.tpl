<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/product_filter.tpl" );  ?>    
  
<div class="product-list"> 
	<div class="products-block">
		<?php
		$cols = $MAX_ITEM_ROW ;
		$span = floor(12/$cols);
		$small = floor(12/$MAX_ITEM_ROW_SMALL);
		$mini = floor(12/$MAX_ITEM_ROW_MINI);
		foreach ($products as $i => $product) { ?>
		<?php if( $i++%$cols == 0 ) { ?>
		<div class="row">
		<?php } ?>
	
		<div class="col-lg-<?php echo $span;?> col-md-3 col-sm-3 col-xs-<?php echo $mini;?>">			
			<div class="product-block">	
				<div class="group-item">
		    		<?php if ($product['thumb']) { ?>
			      <div class="image <?php echo $swapimg; ?>">
			      	<?php if( $product['special'] ) {   ?>
			          <div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
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
			      	<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
			      		<a href="<?php echo $zimage;?>" class="info-view colorbox product-zoom" rel="nofollow" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
			      	<?php } ?>
			      </div>
			      <?php } ?>	        	
		    	</div>
				<div class="product-meta">	
					<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
					
					<div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,250);?>...</div>
				  	<?php if ($product['price']) { ?>
					<div class="price">
						<?php if (!$product['special']) { ?>
						<?php echo $product['tax']; $product['price']; ?>
						<?php } else { ?>
						<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
						<?php } ?>
						<?php if ($product['tax']) { ?>
						<br />
						<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
						<?php } ?>
					</div>
					<?php } ?>
					<div class="cart">
						<a onclick="addToCart('<?php echo $product['product_id']; ?>');" data-hover="Add to cart"><span><i class="fa fa-shopping-cart"></i><?php echo $button_cart; ?></span></a>
				  	</div>
				  	
				</div>
			</div>
		</div>
		
		<?php if( $i%$cols == 0 || $i==count($products) ) { ?>
		</div>
		<?php } ?>				
		<?php } ?>
	</div>
</div>
<div class="pagination"><?php echo $pagination; ?></div>
