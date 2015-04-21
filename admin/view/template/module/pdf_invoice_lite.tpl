<?php echo $header; ?>
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <script type="text/javascript">setTimeout("$('.success').slideUp();",5000);</script>
  <?php } ?>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<div id="tabs" class="htabs">
			<a href="#tab-1" class="tab1"><i></i> <?php echo $this->language->get('text_tab_1'); ?></a>
			<a href="#tab-6" class="tab6"><i></i> <?php echo $this->language->get('text_tab_6'); ?></a>
			<a href="#tab-2" class="tab2"><i></i> <?php echo $this->language->get('text_tab_2'); ?></a>
			<a href="#tab-about" class="tababout"><i></i> <?php echo $this->language->get('text_tab_about'); ?></a>
		</div>
		<div id="tab-1">
		  <table class="form">
			<tr>
			  <td><?php echo $this->language->get('entry_mail'); ?></td>
			  <td>
				<input class="switch" type="checkbox" id="pdf_invoice_mail" name="pdf_invoice_mail" value="1" <?php if($pdf_invoice_mail) echo 'checked="checked"'; ?>/>
			  </td>
			</tr>
			<tr>
			  <td><?php echo $this->language->get('entry_admincopy'); ?></td>
			  <td>
				<input class="switch" type="checkbox" id="pdf_invoice_admincopy" name="pdf_invoice_admincopy" value="1" <?php if($pdf_invoice_admincopy) echo 'checked="checked"'; ?>/>
			  </td>
			</tr>
			<tr>
			  <td><?php echo $this->language->get('entry_mailcopy'); ?></td>
			  <td>
				<input class="switch" type="checkbox" id="pdf_invoice_adminalertcopy" name="pdf_invoice_adminalertcopy" value="1" <?php if($pdf_invoice_adminalertcopy) echo 'checked="checked"'; ?>/>
			  </td>
			</tr>
			<tr>
			  <td><?php echo $this->language->get('entry_invoiced_only'); ?></td>
			  <td>
				<input class="switch" type="checkbox" id="pdf_invoice_invoiced" name="pdf_invoice_invoiced" value="1" <?php if($pdf_invoice_invoiced) echo 'checked="checked"'; ?>/>
			  </td>
			</tr>
			<tr>
				<td><?php echo $this->language->get('entry_auto_notify'); ?></td>
				<td>
					<select name="pdf_invoice_auto_notify">
						<option value="">- <?php echo $this->language->get('text_disabled'); ?> -</option>
						<?php foreach ($order_statuses as $order_status) { ?>
						<?php if ($order_status['order_status_id'] == $pdf_invoice_auto_notify) { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</td>
			</tr>
			<tr>
				<td><?php echo $this->language->get('entry_adminlanguage'); ?></td>
				<td>
					<select name="pdf_invoice_adminlang">
						<option value=""><?php echo $this->language->get('text_order_language'); ?></option>
					<?php foreach ($languages as $language) { ?>
						<?php if ($language['language_id'] == $pdf_invoice_adminlang) { ?>
						<option value="<?php echo $language['language_id']; ?>" selected="selected" style="background:url('view/image/flags/<?php echo $language['image']; ?>') 3px 2px no-repeat;padding-left:25px;"><?php echo $language['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $language['language_id']; ?>" style="background:url('view/image/flags/<?php echo $language['image']; ?>') 3px 2px no-repeat;padding-left:25px"> <?php echo $language['name']; ?></option>
						<?php } ?>
					<?php } ?>
					</select>
				</td>
			</tr>
			<tr>
			  <td><?php echo $this->language->get('entry_icon'); ?></td>
			  <td>
				<div style="width:380px">
				<?php foreach ($icons as $icon) { ?>
				  <label style="display:inline-block;width:70px;"><input type="radio" name="pdf_invoice_icon" value="<?php echo $icon; ?>" <?php if($pdf_invoice_icon == $icon) echo 'checked="checked"'; ?>/><img src="../image/invoice/<?php echo $icon; ?>"/></label>
				<?php } ?>
				</div>
			  </td>
			</tr>
		</table>
		</div>
		<div id="tab-6">
			<table class="form">
				<tr>
					<td><?php echo $this->language->get('entry_company_id'); ?></td>
					<td><input type="text" name="pdf_invoice_company_id" value="<?php echo $pdf_invoice_company_id; ?>" size="63"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('entry_vat_number'); ?></td>
					<td><input type="text" name="pdf_invoice_vat_number" value="<?php echo $pdf_invoice_vat_number; ?>" size="63"/></td>
				</tr>
				<?php if ($group_settings) { ?>
				<tr>
					<td><?php echo $this->language->get('entry_customer_vat'); ?></td>
					<td class="customer_groups">
						<div class="inlineEdit">
							<div class="switchBtn"><?php echo $this->language->get('entry_customer_vat_btn'); ?></div>
							<div class="switchContent">
								<?php $i=0; foreach ($customer_groups as $group) { ?>
									<h4><?php echo $group['name']; ?></h4>
									<div>
										<span><?php echo $this->language->get('entry_custom_comp_display'); ?></span>
										<input class="switch" type="checkbox"  id="customergroup<?php echo $i++; ?>" name="customer_groups[<?php echo $group['customer_group_id']; ?>][company_id_display]" value="1" <?php if($group['company_id_display']) echo 'checked="checked"'; ?> />
									</div>
									<div>
										<span><?php echo $this->language->get('entry_custom_comp_required'); ?></span>
										<input class="switch" type="checkbox"  id="customergroup<?php echo $i++; ?>" name="customer_groups[<?php echo $group['customer_group_id']; ?>][company_id_required]" value="1" <?php if($group['company_id_required']) echo 'checked="checked"'; ?> />
									</div>
									<br />
									<div>
										<span><?php echo $this->language->get('entry_custom_tax_display'); ?></span>
										<input class="switch" type="checkbox"  id="customergroup<?php echo $i++; ?>" name="customer_groups[<?php echo $group['customer_group_id']; ?>][tax_id_display]" value="1" <?php if($group['tax_id_display']) echo 'checked="checked"'; ?> />
									</div>
									<div>
										<span><?php echo $this->language->get('entry_custom_tax_required'); ?></span>
										<input class="switch" type="checkbox"  id="customergroup<?php echo $i++; ?>" name="customer_groups[<?php echo $group['customer_group_id']; ?>][tax_id_required]" value="1" <?php if($group['tax_id_required']) echo 'checked="checked"'; ?> />
									</div>
								<?php } ?>
							</div>
						</div>
					</td>
				</tr>
				<?php } ?>
				<tr>
				  <td><?php echo $this->language->get('entry_customer_id'); ?></td>
				  <td>
					<input class="switch" type="checkbox" id="pdf_invoice_customerid" name="pdf_invoice_customerid" value="1" <?php if($pdf_invoice_customerid) echo 'checked="checked"'; ?>/>
				  </td>
				  <tr>
					<td><?php echo $this->language->get('entry_customer_format'); ?></td>
					<td>
						<?php echo $this->language->get('entry_customer_prefix'); ?> <input type="text" name="pdf_invoice_customerprefix" value="<?php echo $pdf_invoice_customerprefix; ?>" size="9"  style="margin-right:30px"/>
						<?php echo $this->language->get('entry_customer_size'); ?> <input type="text" name="pdf_invoice_customersize" value="<?php echo $pdf_invoice_customersize; ?>" size="1"/>
					</td>
				</tr>
				</tr>
				<tr>
				  <td><?php echo $this->language->get('entry_tax'); ?></td>
				  <td>
					<input class="switch" type="checkbox" id="pdf_invoice_tax" name="pdf_invoice_tax" value="1" <?php if($pdf_invoice_tax) echo 'checked="checked"'; ?>/>
				  </td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('entry_duedate'); ?></td>
					<td><input type="text" name="pdf_invoice_duedate" value="<?php echo $pdf_invoice_duedate; ?>" size="3"/></td>
				</tr>
			</table>
		</div>
		<div id="tab-2">
			<table class="form">
				<tr>
				  <td><?php echo $this->language->get('entry_logo'); ?></td>
				  <td valign="top"><div class="image" style="text-align:center; float:left;"><img src="<?php echo $thumb_header; ?>" alt="" id="thumb_header" />
					  <input type="hidden" name="pdf_invoice_logo" value="<?php echo $pdf_invoice_logo; ?>" id="pdf_invoice_logo" />
					  <br />
					  </div>
					  <div style="margin-left:10px;float:left;"><br /><a onclick="image_upload('pdf_invoice_logo', 'thumb_header');"><?php echo $this->language->get('text_browse'); ?></a><br /><br /><a onclick="$('#thumb_header').attr('src', '<?php echo $no_image; ?>'); $('#pdf_invoice_logo').attr('value', '');"><?php echo $this->language->get('text_clear'); ?></a></div>
					</td>
				</tr>
				<tr>
				  <td><?php echo $this->language->get('entry_columns'); ?></td>
				  <td class="colors">
					<div>
						<span><?php echo $this->language->get('entry_col_image'); ?></span>
						<input class="switch" type="checkbox"  id="pdf_invoice_col_image" name="pdf_invoice_col_image" value="1" <?php echo $pdf_invoice_col_image ? 'checked="checked"':''; ?>/>
					</div>
					<div>
						<span><?php echo $this->language->get('entry_col_product'); ?></span>
						<input class="switch" type="checkbox"  id="pdf_invoice_col_product" name="pdf_invoice_col_product" value="1" <?php echo $pdf_invoice_col_product ? 'checked="checked"':''; ?>/>
					</div>
					<div>
						<span><?php echo $this->language->get('entry_col_model'); ?></span>
						<input class="switch" type="checkbox"  id="pdf_invoice_col_model" name="pdf_invoice_col_model" value="1" <?php echo $pdf_invoice_col_model ? 'checked="checked"':''; ?>/>
					</div>
					<div>
						<span><?php echo $this->language->get('entry_col_quantity'); ?></span>
						<input class="switch" type="checkbox"  id="pdf_invoice_col_quantity" name="pdf_invoice_col_quantity" value="1" <?php echo $pdf_invoice_col_quantity ? 'checked="checked"':''; ?>/>
					</div>
					<div>
						<span><?php echo $this->language->get('entry_col_unitprice'); ?></span>
						<input class="switch" type="checkbox"  id="pdf_invoice_col_unitprice" name="pdf_invoice_col_unitprice" value="1" <?php echo $pdf_invoice_col_unitprice ? 'checked="checked"':''; ?>/>
					</div>
				   </td>
				</tr>
				<tr>
				  <td><?php echo $this->language->get('entry_inlineqty'); ?></td>
				  <td>
					<input class="switch" type="checkbox" id="pdf_invoice_inlineqty" name="pdf_invoice_inlineqty" value="1" <?php if($pdf_invoice_inlineqty) echo 'checked="checked"'; ?>/>
				  </td>
				</tr>
				<tr>
				  <td><?php echo $this->language->get('entry_thumbsize'); ?></td>
				  <td><input type="text" name="pdf_invoice_thumbwidth" value="<?php echo $pdf_invoice_thumbwidth; ?>" size="3" />
					x
					<input type="text" name="pdf_invoice_thumbheight" value="<?php echo $pdf_invoice_thumbheight; ?>" size="3" />
				  </td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('entry_filename'); ?></td>
					<td>
						<div class="inlineEdit">
							<div class="switchBtn">
								<?php
								$pdfFilename = array();
								if($this->config->get('pdf_invoice_filename_prefix') && $this->config->get('pdf_invoice_filename_'.$this->config->get('config_language')))
									$pdfFilename[] = trim($this->language->get('entry_filename_prefix'));
								if($this->config->get('pdf_invoice_filename_invnum'))
									$pdfFilename[] = $this->language->get('entry_filename_invnum');
								if($this->config->get('pdf_invoice_filename_ordnum'))
									$pdfFilename[] =  $this->language->get('entry_filename_ordnum');
								$pdfFilename = implode('-', $pdfFilename) ? implode('-', $pdfFilename).'.pdf' : 'invoice.pdf';
								?>
								<img style="position:relative;top:3px" src="view/pdf_invoice_pro/img/pdf.png" alt="filename"/> <?php echo $pdfFilename; ?>
							</div>
							<div class="switchContent">
								<img style="position:relative;top:3px" src="view/pdf_invoice_pro/img/pdf.png" alt="filename"/>
						<label><input type="checkbox" name="pdf_invoice_filename_prefix" value="1" <?php if($pdf_invoice_filename_prefix) echo 'checked="checked"'; ?> /><?php echo $this->language->get('entry_filename_prefix'); ?></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" name="pdf_invoice_filename_invnum" value="1" <?php if($pdf_invoice_filename_invnum) echo 'checked="checked"'; ?> /><?php echo $this->language->get('entry_filename_invnum'); ?></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" name="pdf_invoice_filename_ordnum" value="1" <?php if($pdf_invoice_filename_ordnum) echo 'checked="checked"'; ?> /><?php echo $this->language->get('entry_filename_ordnum'); ?></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.pdf
							</div>
						</div>
					</td>
				</tr>
			</table>
			<table class="form">
			<tr>
			  <td colspan="2">
				<div id="language-msg" class="htabs">
					<?php foreach ($languages as $language) { ?>
					<a href="#tab-language-<?php echo $language['code']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" alt="" /> <?php echo $language['name']; ?></a>
					<?php } ?>
				</div>
				<?php foreach ($languages as $language) { ?>
					<div id="tab-language-<?php echo $language['code']; ?>">
						<table class="form">
							<tr>
								<td><?php echo $this->language->get('entry_filename_prefix_text'); ?></td>
								<td><input type="text" name="pdf_invoice_filename_<?php echo $language['code']; ?>" value="<?php echo ${'pdf_invoice_filename_'.$language['code'] }; ?>" size="63"/></td>
							</tr>
							<tr>
								<td><?php echo $this->language->get('entry_size'); ?></td>
								<td>
									<select name="pdf_invoice_size_<?php echo $language['code']; ?>">
										<option value="letter" <?php if(${'pdf_invoice_size_'.$language['code']} == 'Letter') echo 'selected="selected"'; ?>>letter</option>
										<option value="A4" <?php if(${'pdf_invoice_size_'.$language['code']} == 'A4') echo 'selected="selected"'; ?>>A4</option>
									</select>
								</td>
							</tr>
							<tr>
								<td><?php echo $this->language->get('entry_footer'); ?></td>
								<td><input type="text" name="pdf_invoice_footer_<?php echo $language['code']; ?>" value="<?php echo ${'pdf_invoice_footer_'.$language['code'] }; ?>" size="63"/></td>
							</tr>
						</table>
					</div>
				<?php } ?>
				</td>
			</tr>
		</table>
		</div>
		<div id="tab-about">
			<table class="form about">
				<tr>
					<td colspan="2" style="text-align:center;padding:30px 0 50px"><img src="view/pdf_invoice_pro/img/logo-lite<?php echo rand(1,1); ?>.gif"/></td>
				</tr>
				<tr>
					<td>Version</td>
					<td><?php echo $module_version; ?></td>
				</tr>
				<tr>
					<td>Free support</td>
					<td>I take care of maintaining my modules at top quality and affordable price.<br/>In case of bug, incompatibility, or if you want a new feature, just contact me on my mail.</td>
				</tr>
				<tr>
					<td>Contact</td>
					<td><a href="mailto:sirius_box-dev@yahoo.fr">sirius_box-dev@yahoo.fr</a></td>
				</tr>
				<tr>
					<td>Links</td>
					<td>
						If you like this module, please consider to make a star rating <span style="position:relative;top:3px;width:80px;height:17px;display:inline-block;background:url(data:data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAARCAYAAADUryzEAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAwNy8wNy8xMrG4sToAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzbovLKMAAACr0lEQVQ4jX1US0+TURA98/Xri0KBYqG8BDYItBoIBhFBBdRNTTQx0Q0gujBiAkEXxoXxD6iJbRcaY1iQEDXqTgwQWkWDIBU3VqWQoEgECzUU+n5910VbHhacZHLvzD05c+fMzaVhgxYJIwIYi+8B8FJ5bzjob9ucB4DmLttGMGyoAGMsyc1G7bEvA91roz2NL7Y7TziHHSxFmWsorbuUFgn79BaTLnMn3LYEZqPukCKruFAUGEd54w1ekqK69x8CSkoqMnJv72noTmN+O9Q5KlE44GqxmHTS7Qho5MH+X8SJUuMhAIbM/CrS1tSnCYsmkOoUnO7SiP3dHV8Mw5AoKkRCfTwR96ei+ZZGVVDDJQhIWAVbfhjDe8eQnd/Aq8+/VAIsAcGbR8ejQiR8jcwGbYZEkTFVd7I9B4IXcL+GEPwdK4SN0XJSDaCoAvHZsA4/93hWHNVNnbZpjoG5gl7XvpFnxggxAZRaA0rokliIAIkaxMnwdWLE7XW77jd12qYBgCMiNHfZlhgTCkZfPfUDBAYGItoiL0lK8N0+51txzD1u7Ji8njTGpk6bg/iUhSiU4GT5YOtPL940AOfiDyHod9/dMsYEzmLS5bBoKE/ES8ECCyACSF4IFledAdhd2SIFUdtmAp7i92QM+uKqVg6RJXDKakCcjyjSwcldMUDgG7I0h8WKdI0ewM2kFuTpmlb1bp2UMYBJyjBjm/FYh57MjA/1+1wuESNZOfjoLPwe516zUSdLIgi6l+sl3CIW5leD7/v7HPNTE+cOtr8tDXhWy+zWAcvnDx/XoiEPiirPBomgXxd32KAFEWp3FR0YdP60pop4sfHI5cmr+MfMRl2tXKnqzS5pyFuaHRusu2A5EyeoAEAQS2Q94VDg4pY/YUOf9ZgxnBaJJSeOdny6AgB/AYEpKtpaTusRAAAAAElFTkSuQmCC)"></span> on the module page :]<br/><br/>
						<b>Module page :</b> <a target="new" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=16487">PDF Invoice Lite</a><br/>
						<b>Other modules :</b> <a target="new" href="http://www.opencart.com/index.php?route=extension/extension&filter_username=woodruff">My modules on opencart</a><br/>
					</td>
				</tr>
			</table>
		</div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input.switch').iToggle({easing: 'swing',speed: 200});

$('select[name=pdf_invoice_template]').change(function(){
	$('#template img').attr('src', '<?php echo HTTP_CATALOG; ?>catalog/view/theme/default/template/pdf/'+$(this).val()+'.png');
});
$('select[name=pdf_invoice_sliptemplate]').change(function(){
	$('#sliptemplate img').attr('src', '<?php echo HTTP_CATALOG; ?>catalog/view/theme/default/template/pdf/packingslip/'+$(this).val()+'.png');
});
$('#template img, #sliptemplate img').click(function(){$(this).toggleClass('full');});
$('#language-msg a').tabs();
$('#tabs a').tabs();
$('#pdfbrowser').fileTree({script:'index.php?route=module/pdf_invoice/tree&token=<?php echo $token; ?>'});
--></script>
<script type="text/javascript"><!--
$('#language-msg a').tabs();
$('#tabs a').tabs();
$('.inlineEdit .switchBtn').click(function(){
	$(this).toggle();
	$(this).next().toggle();
});
$(".colorpicker").spectrum({
	preferredFormat: "hex",
    showInput: true,
    allowEmpty:true,
	clickoutFiresChange: true,
	showInitial: true,
	showButtons: false
	//showPalette: true
});
--></script>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<!-- custom blocks -->
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($pdf_invoice_blocks as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 

<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($pdf_invoice_blocks as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<!-- /custom blocks -->
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
if(parseInt(CKEDITOR.version) < 4){
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
}).addCss('p{margin:0;}');
}
else{
	CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});
	CKEDITOR.addCss('p{margin:0;}');
}
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $this->language->get('text_image_manager'); ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<?php echo $footer; ?>