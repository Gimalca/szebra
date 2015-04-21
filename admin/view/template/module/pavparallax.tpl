<?php
/******************************************************
 * @package  : Pav Parallax module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/
?>
<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>

	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
	<div class="success"><?php echo $success; ?></div>
	<?php } ?>

	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
				<a onclick="$('#action').val('save-edit');$('#form').submit();" class="button"><?php echo $this->language->get('text_save_edit'); ?></a>
				<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
			</div>
		</div>
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<input name="action" type="hidden" id="action"/>  
				<div class="vtabs">
					<?php $module_row = 1; ?>
					
					<?php foreach ($modules as $module) { ?>
					<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
					<?php $module_row++; ?>
					<?php } ?>
					<span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span>
				</div>
				<?php $module_row = 1; ?>
				<?php foreach ($modules as $module) { ?>
				<div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
					<table class="form">
						<tr>
							<td><?php echo $entry_image; ?></td>
							<td>
								<?php $thumb = isset( $module['image'])?$this->model_tool_image->resize( $module['image'], 100, 100) :$no_image; ?>
								<div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb<?php echo $module_row; ?>" />
									<input type="hidden" name="pavparallax[<?php echo $module_row; ?>][image]" value="<?php echo $module['image']; ?>" id="image<?php echo $module_row; ?>"  />
									<br />
									<a onclick="image_upload('image<?php echo $module_row; ?>', 'thumb<?php echo $module_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $module_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $module_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a>
              					</div>
							</td>
						</tr>
						<tr>
							<td><?php echo $entry_percent; ?></td>
							<td><input type="text" name="pavparallax[<?php echo $module_row; ?>][percent]" value="<?php echo isset($module['percent'])?$module['percent']:'50%'; ?>"/></td>
						</tr>
						<tr>
							<td><?php echo $entry_scroll; ?></td>
							<td><input type="text" name="pavparallax[<?php echo $module_row; ?>][scroll]" value="<?php echo isset($module['scroll'])?$module['scroll']:'0.5'; ?>"/></td>
						</tr>
						<tr>
							<td><?php echo $entry_position; ?></td>
							<td><select name="pavparallax[<?php echo $module_row; ?>][position]">
								<?php foreach( $positions as $key=>$value ) { ?>
								<?php if ($module['position'] == $key) { ?>
								<option value="<?php echo $key;?>" selected="selected"><?php echo $this->language->get('text_'.$value); ?></option>
								<?php } else { ?>
								<option value="<?php echo $key;?>"><?php echo $this->language->get('text_'.$value); ?></option>
								<?php } ?>
								<?php } ?> 
								</select>
							</td>
						</tr>
						<tr>
							<td><?php echo $entry_status; ?></td>
							<td><select name="pavparallax[<?php echo $module_row; ?>][status]">
								<?php if ($module['status']) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</td>
						</tr>
					</table>
				</div>
				<?php $module_row++; ?>
				<?php } ?>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
function addModule() {  
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '<table class="form">';

	html += '	<tr>';
	html += '		<td><?php echo $entry_image; ?></td>';
	html += '		<td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + module_row + '" /><input type="hidden" name="pavparallax[' + module_row + '][image]" value="" id="image' + module_row + '" /><br /><a onclick="image_upload(\'image' + module_row + '\', \'thumb' + module_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + module_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + module_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '	</tr>';

	html += '	<tr>';
	html += '		<td><?php echo $entry_percent; ?></td>';
	html += '		<td class="left"><input type="text" name="pavparallax[' + module_row + '][percent]" value="50%"/></td>';
	html += '	</tr>';

	html += '	<tr>';
	html += '		<td><?php echo $entry_scroll; ?></td>';
	html += '		<td class="left"><input type="text" name="pavparallax[' + module_row + '][scroll]" value="0.5"/></td>';
	html += '	</tr>';

	html += '	<tr>';
	html += '		<td><?php echo $entry_position; ?></td>';
	html += '		<td><select name="pavparallax[' + module_row + '][position]">';
						<?php foreach( $positions as $key=>$value ) { ?>
						<?php if ($key == "promotion") { ?>
	html += '			<option selected="selected" value="<?php echo $key;?>"><?php echo $this->language->get('text_'.$value); ?></option>';
						<?php } else { ?>
	html += '			<option value="<?php echo $key;?>"><?php echo $this->language->get('text_'.$value); ?></option>';      
						<?php } ?>
						<?php } ?>
	html += '		</select></td>';
	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $entry_status; ?></td>';
	html += '		<td><select name="pavparallax[' + module_row + '][status]">';
	html += '			<option value="1"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select></td>';
	html += '	</tr>';
	html += '</table>';

	html += '</div>';
	
	$('#form').append(html);

	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script>

<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 

<?php echo $footer; ?>