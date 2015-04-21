<article class="blog-item row">	
	<?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
	<div class="col-md-3 col-sm-4 col-xs-12">
		<figure class="blog-body">									
			<a href="<?php echo $blog['link'];?>">
				<img src="<?php echo $blog['thumb_small'];?>" title="<?php echo $blog['title'];?>" alt="" class="img-responsive" />
			</a>
		</figure>		
	</div>	
	<?php } ?>	
			
	
	<?php if( $config->get('cat_show_title') ) { ?>
	
	<div class="col-md-9 col-sm-8 col-xs-12">
		<header class="blog-header clearfix">
		<?php if( $config->get('cat_show_created') ) { ?>
			<span class="created">
				<span class="day"><?php echo date("d",strtotime($blog['created']));?></span>
				<span class="month"><?php echo date("M",strtotime($blog['created']));?></span> /
				<span class="month"><?php echo date("Y",strtotime($blog['created']));?></span>
			</span>
		<?php } ?>
		<h4 class="blog-title"><a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h4>
		<?php } ?>
		</header>
	
	
		<footer>	
			<section class="blog-meta">
				<?php if( $config->get('cat_show_author') ) { ?>
				<span class="author"><span><i class="fa fa-pencil"></i><?php echo $this->language->get("text_write_by");?></span> <?php echo $blog['author'];?></span>
				<?php } ?>
				
				<?php if( $config->get('cat_show_category') ) { ?>
				<!--span class="publishin">
					<span><i class="fa fa-gavel"></i><?php echo $this->language->get("text_published_in");?></span>
					<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
				</span-->
				<?php } ?>
				
				<?php if( $config->get('cat_show_hits') ) { ?>
				<!--span class="hits"><span><i class="fa fa-insert-template"></i><?php echo $this->language->get("text_hits");?></span> <?php echo $blog['hits'];?></span-->
				<?php } ?>
				
				<?php if( $config->get('cat_show_comment_counter') ) { ?>
				<span class="comment_count"><span><i class="fa fa-comment"></i><?php echo $this->language->get("text_comment_count");?></span> <?php echo $blog['comment_count'];?></span>
				<?php } ?>
			</section>
		
		
			<?php if( $config->get('cat_show_description') ) {?>			
			<section class="description">
				<?php echo $blog['description'];?>
			</section>
			<?php } ?>
		
			<?php if( $config->get('cat_show_readmore') ) { ?>
			<section class="btn-more-link">
				<a href="<?php echo $blog['link'];?>" class="readmore btn btn-theme-default"><?php echo $this->language->get('text_readmore');?></a>
			</section>
			<?php } ?>	
		
		</footer>	
	</div>

</article>