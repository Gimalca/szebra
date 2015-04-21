<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

 
	$themeConfig = (array)$this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );  

	
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$helper->setDirection( $direction );
	/* Add scripts files */
	$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'catalog/view/javascript/common.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/common.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );

	
	$helper->addScriptList( $scripts );
	
	$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );	
	if( isset($themeConfig['customize_theme']) 
		&& file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css') ) {  
		$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css'  );
	}

	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/animation.css' );	
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );	
	$helper->addCssList( $styles );
	$layoutMode = $helper->getParam( 'layout' );
 
	// logo
	$keepHeader = isset($themeConfig['header'])?$themeConfig['header']:"";
	$logoType =isset($themeConfig['logo_type'])?$themeConfig['logo_type']:"logo-theme";

	// module parallax
	$pavparallax = $this->config->get('pavparallax');
?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
<meta charset="UTF-8" /> 
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($helper->getCssLinks() as $link) { ?>

<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
			<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>
	
	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style> 
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}</style>
	<?php } ?>
<?php 
	if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
	$css=array();
	$link = array();
	for( $i=1; $i<=3; $i++ ){
		if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
			$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
			$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
		}
		if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
			$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
		}
	}
	echo implode( "\r\n",$link );
?>
<style>
	<?php echo implode("\r\n",$css); ?>
</style>
<?php } else { ?>

<?php if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) { ?>
<link href='https://fonts.googleapis.com/css?family=Raleway:400,600,700,500' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,700,300' rel='stylesheet' type='text/css'>
<?php } else {?>
<link href='http://fonts.googleapis.com/css?family=Raleway:400,600,700,500' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,700,300' rel='stylesheet' type='text/css'>
<?php } ?>

<?php } ?>
<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>


<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
			<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
		});
//--></script>
<?php }	?>

<!--[if lt IE 9]>
<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/paneltool.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/colorpicker/js/colorpicker.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorpicker/css/colorpicker.css" />

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
<?php /* Start Pav Parallax Module */ ?>
<style>
	<?php foreach ($pavparallax as $item) { ?>
	<?php if($item['status']) {?>
	#pav-<?php echo $item['position']; ?> {
		background: url('<?php echo $this->model_tool_image->resize($item["image"], 1920, 1200); ?>')  50% 0 no-repeat fixed;
	}
	<?php } ?><?php } ?>
</style>

<?php /* End Pav Parallax Module */ ?>
</head>
<body id="offcanvas-container" class="offcanvas-container <?php echo $keepHeader; ?> layout-<?php echo $layoutMode; ?> fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?> lang-<?php echo $lang; ?>">
<section id="page" class="offcanvas-pusher" role="main">

	<section id="inicio" style="padding:3px">
		<div class="container" style="background-color:black; ">
			<div class=" col-lg-6" style="color:white; font-size:11px; line-height:18px">
				
					<?php echo $this->language->get('heading_title_index');?> Suministros Zebra Venezuela
				
			</div>
			
			<div class="col-lg-offset-2 col-lg-4" style="margin-top:0px">
					<?php /*9echo $currency;*/ ?>
					<?php echo $language; ?>
					<a style="margin-left:10px; font-size:11px; color:white;" href="<?php echo $account; ?>"><i class="fa fa-user"></i><?php echo ' '.$text_account; ?></a>
					<a href="https://www.facebook.com/pages/Suministros-Zebra-de-Venezuela/592408027448907"><i style="color:white; font-size:13px; margin-left:10px" class="fa fa-facebook"></i></a>
					<a href="https://twitter.com/zebravenezuela"><i style="color:white; font-size:13px; margin-left:10px" class="fa fa-twitter"></i></a>
					
					<div id="search" class="search pull-left" style="font-size: 14px">
                                            <div class="quickaccess-toggle"><i class="fa fa-search" style="color:white"></i>
                                                <!--form enctype="multipart/form-data" method="post" action="index.php?route=product/search" >
						<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
                                                </form-->
						<div class="button-search" style="color:white">&nbsp;</div>
                                                
					</div>
				
			</div>
			
		</div>
	</section>

<section id="header" class="clearfix">
	<div class="header-wrap pull-left">
		<div class="pull-left inner logo">
			<?php if( $logoType=='logo-theme'){ ?>
				<div id="logo-theme"><a href="<?php echo $home; ?>"><span><?php echo $name; ?></span></a></div>
			<?php } elseif ($logo) { ?>
			<div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
			<?php } ?>					
		</div>
		<div class="pull-left menu inner">
		<section id="pav-mainnav">
			<div class="container-inner">
				<?php 
				/**
				 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
				 */
				$modules = $helper->getModulesByPosition( 'mainmenu' ); 
				if( count($modules) && !empty($modules) ){ 
				?>
				<?php foreach ($modules as $module) { ?>
					<?php echo $module; ?>
				<?php } ?>
				<?php } elseif ($categories) {  ?>		
				 	<div class="navbar navbar-inverse"> 
						<nav id="mainmenutop" class="pav-megamenu" role="navigation"> 
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
									<span class="sr-only">Toggle navigation</span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>										
								</button>
							</div>
					  		<div class="collapse navbar-collapse navbar-ex1-collapse">
								<ul class="nav navbar-nav">
							  		<li>
							  			<a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><span><?php echo $this->language->get('text_home');?></span></a>
							  		</li>
									<?php foreach ($categories as $category) { ?>
								
									<?php if ($category['children']) { ?>			
									<li class="parent dropdown deeper ">
										<a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown">
											<span>
												<?php echo $category['name']; ?>
												<span class="fa fa-angle-down"></span>
											</span>															
										</a>
										<?php } else { ?>
										<li>
											<a href="<?php echo $category['href']; ?>"><span><?php echo $category['name']; ?></span></a>
											<?php } ?>
											<?php if ($category['children']) { ?>
									  		<ul class="dropdown-menu">
												<?php for ($i = 0; $i < count($category['children']);) { ?>								
											  	<?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
											  	<?php for (; $i < $j; $i++) { ?>
											  	<?php if (isset($category['children'][$i])) { ?>
											  	<li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
											  	<?php } ?>
											  	<?php } ?>								
												<?php } ?>
											</ul>
									  		<?php } ?>
										</li>
										<?php } ?>
									</li>
							  	</ul>
							</div>
						</nav>			
					</div>   
				<?php } ?>	
			</div>		
		</section>
		</div>
	</div>

	<div class="topbar">
		<div class="wrap-topbar pull-right">
			<div class="cart-m pull-left">
				<?php echo $cart; ?>
			</div>
		</div>
	</div>
</section>

<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' ); 
if( $modules ){
?>
<section id="pav-slideshow" class="pav-slideshow hidden-xs">
		<?php foreach ($modules as $module) { ?>
			<?php echo $module; ?>
		<?php } ?>
</section>
<?php } ?>
<section id="sys-notification">
	<div class="container">
		<?php if ($error) { ?>    
    		<div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
    	<?php } ?>

		<div id="notification"></div>
	</div>
</section>

<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'showcase' ); 
	$ospans = array();
	$cols   = 1;
	if( count($modules) ) { 
?>
<section style="background-color:#DBDBDB;margin-bottom: 30px; margin-top: -29px; padding:15px" id="pav-showcase">
 <div class="container">
  <div class="row box-product">
      <div class="col-md-2 ">
      	<a href="/lectores-portatiles"><img src="image/data/barra-lectores.jpg" alt="Lectores de Codigo de barra"  title="Lectores de Codigo de barra" /> </a>
      </div>
      <div class="col-md-2 ">
      	<a href="/ribbons-consumibles"><img src="image/data/barra-ribbons.jpg" alt="Ribbons"  title="Ribbons" /> </a>
      </div>
      <div class="col-md-2 ">
      	<a href="/etiquetas-consumibles"><img src="image/data/barra-etiquetas.jpg" alt="Etiquetas" title="Etiquetas" /> </a>
      </div>
      <div class="col-md-2 ">
      	<a href="/impresoras-industriales-zebra"><img src="image/data/barra-imp-industrial.jpg" alt="Impresoras Industriales"  title="Impresoras Industriales" /> </a>
      </div>  
      <div class="col-md-2 ">
      	<a href="/impresoras-zebra-escritorio"><img src="image/data/barra-imp-escritorio.jpg" alt="Impresoras de Escritorios" title="Impresoras de Escritorios" /> </a>
      </div>
      <div class="col-md-2 ">
     	<a href="/impresoras-carnet"><img src="image/data/barra-imp-carnet.jpg" alt="Lectores de Codigo de barra" title="Lectores de Codigo de barra" /> </a>
      </div>
   </div>  
 </div>
 </section>
<section id="pav-showcase">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {   ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
			<div class="col-lg-<?php echo floor(12/$cols);?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>
	</div>	
</section>
<?php } ?>



<?php
/**
 * Promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
 */
$modules = $helper->getModulesByPosition( 'promotion' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-promotion animated-area" id="pav-promotion">
	<div class="parallax-over">
		<div class="container">
			
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
				<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>	
		</div>
	</div>
</section>
<?php } ?>

	<?php if( isset($themeConfig['enable_offsidebars']) && $themeConfig['enable_offsidebars'] ) { ?>
	<section id="columns" class="offcanvas-siderbars"><div class="container">
	<div class="row visible-xs"><div class="container"> 
		<div class="offcanvas-sidebars-buttons">
			<button type="button" data-for="column-left" class="pull-left btn btn-danger"><i class="glyphicon glyphicon-indent-left"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>
			
			<button type="button" data-for="column-right" class="pull-right btn btn-danger"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="glyphicon glyphicon-indent-right"></i></button>
		</div>
	</div></div>
	<?php }else { ?>
	<section id="columns"><div class="container">
	<?php } ?>
	<div class="row">