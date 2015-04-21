<?php if( isset($widget_name)){
?>
<h3 class="menu-title"><span class="menu-title"><?php echo $widget_name;?></span></h3>
<?php
}?>
<div class="widget-product-list hidden-sm hidden-xs">
  <div class="widget-inner">
      <?php foreach ($products as $product) { ?>
      <div class="product-block w-product col-lg-4 col-md-4 col-sm-4 col-xs-12 clearfix">
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="product-meta">
          <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
          <?php if ($product['rating']) { ?>
          <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
          <?php } ?>
          <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
          <div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');"><span><i class="fa fa-shopping-cart"></i><?php echo $this->language->get('button_cart'); ?></span></a>
          </div>
        </div>
      </div>
      <?php } ?>
  </div>
</div>