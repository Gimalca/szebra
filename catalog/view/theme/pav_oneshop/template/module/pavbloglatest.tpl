<?php if( !empty($blogs) ) { ?>
<div class="box blog-lastest">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content" >
		<div class="pavblog-latest slide" id="blog-carousel">
			<?php if( count($blogs) > 4 ) { ?>
			<div class="carousel-controls">
				<a class="carousel-control left fa fa-angle-left" href="#blog-carousel" data-slide="prev"></a>
				<a class="carousel-control right fa fa-angle-right" href="#blog-carousel" data-slide="next"></a>
			</div>
			<?php } ?>
			<div class="carousel-inner">
			<?php 
				$itemsperpage = 4;
				$pages = array_chunk( $blogs, $itemsperpage); $span = 12/$cols;
			?>
			<?php foreach ($pages as  $k => $tblogs ) { ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tblogs as $i => $blog ) { ?>
						<?php if( $i++%$cols == 0 ) { ?>
							<div class="row box-blog">
						<?php } ?>
							<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 pav-blog-list">
								<div class="blog-item">					
										<?php if( $blog['thumb']  )  { ?>
											<div class="image">
												<a href="<?php echo $blog['link'];?>" class="blog-article">
												<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" class="img-responsive" alt="">
												</a>								
											</div>
										<?php } ?>
									<div class="blog-body">	
										<h4 class="blog-title">
											<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
										</h4>	
										<div class="description">
											<?php $blog['description'] = strip_tags($blog['description']); ?>
											
											<?php echo utf8_substr( $blog['description'],0, 90 );?>...
										</div>
										<!--div class="group-blog">
											<span class="author"><span><?php echo $this->language->get("text_write_by");?></span> <?php echo $blog['author'];?></span>
											<span><?php echo $blog['created'];?></span>
											<span class="comment"><?php echo $this->language->get("text_comment_count");?><?php echo $blog['comment_count'];?></span>
											
										</div-->
									</div>					
								</div>
							</div>	
						<?php if( $i%$cols == 0 || $i==count($tblogs) ) { ?>
							</div>
						<?php } ?>							
					<?php } //end foreach 2?>
				</div>
			<?php } //end foreach 1 ?>
			</div>
		</div>
 	</div>
 </div>

<script type="text/javascript">
$('#blog-carousel').carousel({interval:99999,auto:'false',pause:'hover'});
</script>
<?php } ?>