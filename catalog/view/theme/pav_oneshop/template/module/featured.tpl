<?php 
	$cols = 4;
	$span = 12/$cols;
  $themeConfig = $this->config->get('themecontrol');
  $categoryConfig = array( 
    'show_swap_image'  => 0
  ); 

  $categoryConfig  = array_merge($categoryConfig, $themeConfig );
?>
<div class="box box-product featured highlighted nopadding">
  <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
  <div class="box-content">
    <div class="box-product" >
			  <?php foreach ($products as $i => $product) { ?>
				 <?php if( $i++%$cols == 0 ) { ?>
				  <div class="row">
				<?php } ?> 
			  <div class="product-item col-lg-<?php echo $span;?> col-md-3 col-sm-3 col-xs-12">
        <?php if($i==1) {?>
        <div class="product-block first">
        <?php }else{ ?>
        <div class="product-block">
        <?php } ?>
      <?php if ($product['thumb']) { ?>
      <div class="image">
        <a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>       
      </div>
      <?php } ?>
          <div class="product-meta">
        <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
         <?php if ($product['rating']) { ?>
		 <?php } ?> 

        <?php if ($product['price']) { ?>
          <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span>
          <span class="price-new"><?php echo $product['special']; ?></span>          
          <?php } ?>
          </div>
        <?php } ?>

          <div class="cart">
            <a onclick="addToCart('<?php echo $product['product_id']; ?>');" data-hover="Add to cart"><span><i class="fa fa-shopping-cart"></i><?php echo $button_cart; ?></span></a>
          </div>
         

    </div>
			  </div></div>
			  
			 <?php if( $i%$cols == 0 || $i==count($products) ) { ?>
				 </div>
				<?php } ?>
			
			  <?php } ?>

    </div>
  </div>
   </div>
