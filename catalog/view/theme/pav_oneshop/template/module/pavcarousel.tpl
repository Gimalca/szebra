<?php $id = rand(1,10); $span =  12/$columns;?>
<div class="pav-carousel">
	<div class="box-heading"><span><?php echo $this->language->get('text_logo_brand');?></span></div>
   	<div id="pavcarousel<?php echo $id;?>" class="carousel slide pavcarousel hidden-sm hidden-xs">
   		<div class="carousel-controls hidden-xs">
			<a class="carousel-control left fa fa-angle-left" href="#pavcarousel<?php echo $id;?>" data-slide="prev"></a>
			<a class="carousel-control right fa fa-angle-right" href="#pavcarousel<?php echo $id;?>" data-slide="next"></a>
		</div>
		<div class="carousel-inner">
			 <?php foreach ($banners as $i => $banner) { $i=$i+1;?>
				<?php if($i%$columns==1) { ?>
				<div class="row item <?php if(($i-1)==0) {?>active<?php } ?>">
				<?php } ?>
				<div class="item-carousel col-lg-3 col-sm-2 col-xs-12">
					<center>
						<div class="item-inner">
							<?php if ($banner['link']) { ?>
							<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
							<?php } else { ?>
							<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
							<?php } ?>
						</div>
					</center>
				</div>	
				<?php if( $i%$columns==0 || $i==count($banners)) { ?>
				</div>
				<?php } ?>
			<?php } ?>
		</div>
	</div>
</div>
<?php if( count($banners) > 1 ){ ?>
<script type="text/javascript"><!--
 $('#pavcarousel<?php echo $id;?>').carousel({interval:false});
--></script>
<?php } ?>
