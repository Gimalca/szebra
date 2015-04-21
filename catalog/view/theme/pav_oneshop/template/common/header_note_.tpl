<?php 
 
	// module parallax
	$pavparallax = $this->config->get('pavparallax');
	if (isset($pavparallax)) {
		$helper->addScript( 'catalog/view/javascript/parallax/jquery.parallax-1.1.3.js' );
	}

?>


<?php /* Start Pav Parallax Module */ ?>
<style>
	<?php foreach ($pavparallax as $item) { ?>
	<?php if($item['status']) {?>
	#pav-<?php echo $item['position']; ?> {
		background-image: url('<?php echo $this->model_tool_image->resize($item["image"], 800, 800); ?>') !important;
	}
	<?php } ?>
	<?php } ?>
</style>
<script type="text/javascript">
$(document).ready(function(){
	<?php foreach ($pavparallax as $item) { ?>
	<?php if($item['status']) {?>	
	$('#pav-<?php echo $item["position"]; ?>').parallax("<?php echo $item['percent'] ?>", <?php echo $item['scroll'] ?>);
	<?php } ?>
	<?php } ?>
}) 
</script>
<?php /* End Pav Parallax Module */ ?>

