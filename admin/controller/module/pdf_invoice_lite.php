<?php
class ControllerModulePdfInvoiceLite extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/pdf_invoice_lite');
		$this->document->addScript('view/pdf_invoice_pro/jqueryFileTree.js');
		$this->document->addScript('view/pdf_invoice_pro/spectrum.js');
		$this->document->addScript('view/pdf_invoice_pro/itoggle.js');
		$this->document->addStyle('view/pdf_invoice_pro/jqueryFileTree.css');
		$this->document->addStyle('view/pdf_invoice_pro/spectrum.css');
		$this->document->addStyle('view/pdf_invoice_pro/style.css');
		
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			if(isset($_POST['customer_groups'])){
				foreach ($_POST['customer_groups'] as $groupid => $group) { 
					$this->db->query("UPDATE " . DB_PREFIX . "customer_group SET company_id_display = '" . isset($group['company_id_display']) . "', company_id_required = '" . isset($group['company_id_required']) . "', tax_id_display = '" . isset($group['tax_id_display']) . "', tax_id_required = '" . isset($group['tax_id_required']) . "' WHERE customer_group_id = '" . (int)$groupid . "'");
				}
			}
			
			$this->model_setting_setting->editSetting('pdf_invoice', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('module/pdf_invoice_lite', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['module_version'] = simplexml_load_file(DIR_SYSTEM.'../vqmod/xml/pdf_invoice_lite.xml')->version;
		
			
		
		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;
		
		// module checks
		if(!is_file(DIR_SYSTEM . 'library/mpdf/mpdf.php'))
			$this->error['warning'] = 'Mpdf library not detected, please download the libraries package and upload it';
		foreach ($languages as $language) {
			if(!is_file(DIR_SYSTEM . '../catalog/language/' . $language['directory'] . '/module/pdf_invoice.php'))
				$this->error['warning'] = 'Language file missing for '.$language['name'] .' language, please follow this procedure : <br />- Check if this language is included in the module package, in <b>extra languages/</b> folder<br />- If it doesn\'t exist, just copy the english file and open it to translate it.<br />- Copy <b>pdf_invoice.php</b> language file into <b>/catalog/language/'.$language['directory'].'/module/</b>';
		}
		// end module checks
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];
		
			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => strip_tags($this->language->get('heading_title')),
			'href'      => $this->url->link('module/pdf_invoice_lite', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/pdf_invoice_lite', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['modules'] = array();
		
		// customer groups
		$this->load->model('sale/customer_group');
		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		
		$this->data['group_settings'] = false;
		if($this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "customer_group` LIKE 'tax_id_display'")->row) {
			$this->data['group_settings'] = true;
		}
		
		/* gestion des variables */
		
		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		$this->data['icons'] = array_diff(scandir(DIR_IMAGE . 'invoice'), array('..', '.'));
		
		// Tab 1 - main settings
		if (isset($this->request->post['pdf_invoice_mail'])) {
			$this->data['pdf_invoice_mail'] = $this->request->post['pdf_invoice_mail'] ? true : false;
		} else {
			$this->data['pdf_invoice_mail'] = $this->config->get('pdf_invoice_mail');
		}
		
		if (isset($this->request->post['pdf_invoice_adminalertcopy'])) {
			$this->data['pdf_invoice_adminalertcopy'] = $this->request->post['pdf_invoice_adminalertcopy'] ? true : false;
		} else {
			$this->data['pdf_invoice_adminalertcopy'] = $this->config->get('pdf_invoice_adminalertcopy');
		}
		
		if (isset($this->request->post['pdf_invoice_admincopy'])) {
			$this->data['pdf_invoice_admincopy'] = $this->request->post['pdf_invoice_admincopy'] ? true : false;
		} else {
			$this->data['pdf_invoice_admincopy'] = $this->config->get('pdf_invoice_admincopy');
		}
		
		if (isset($this->request->post['pdf_invoice_invoiced'])) {
			$this->data['pdf_invoice_invoiced'] = $this->request->post['pdf_invoice_invoiced'] ? true : false;
		} else {
			$this->data['pdf_invoice_invoiced'] = $this->config->get('pdf_invoice_invoiced');
		}
		
		if (isset($this->request->post['pdf_invoice_vat_number'])) {
			$this->data['pdf_invoice_vat_number'] = $this->request->post['pdf_invoice_vat_number'];
		} else {
			$this->data['pdf_invoice_vat_number'] = $this->config->get('pdf_invoice_vat_number');
		}
		
		if (isset($this->request->post['pdf_invoice_company_id'])) {
			$this->data['pdf_invoice_company_id'] = $this->request->post['pdf_invoice_company_id'];
		} else {
			$this->data['pdf_invoice_company_id'] = $this->config->get('pdf_invoice_company_id');
		}
		
		if (isset($this->request->post['pdf_invoice_tax'])) {
			$this->data['pdf_invoice_tax'] = $this->request->post['pdf_invoice_tax'] ? true : false;
		} else {
			$this->data['pdf_invoice_tax'] = $this->config->get('pdf_invoice_tax');
		}
		
		if (isset($this->request->post['pdf_invoice_customerid'])) {
			$this->data['pdf_invoice_customerid'] = $this->request->post['pdf_invoice_customerid'] ? true : false;
		} else {
			$this->data['pdf_invoice_customerid'] = $this->config->get('pdf_invoice_customerid');
		}
		
		if (isset($this->request->post['pdf_invoice_customerprefix'])) {
      		$this->data['pdf_invoice_customerprefix'] = $this->request->post['pdf_invoice_customerprefix'];
    	} else { 
			$this->data['pdf_invoice_customerprefix'] = $this->config->get('pdf_invoice_customerprefix');
		}
		
		if (isset($this->request->post['pdf_invoice_customersize'])) {
      		$this->data['pdf_invoice_customersize'] = $this->request->post['pdf_invoice_customersize'];
    	} else { 
			$this->data['pdf_invoice_customersize'] = $this->config->get('pdf_invoice_customersize');
		}
		
		if (isset($this->request->post['pdf_invoice_auto_notify'])) {
      		$this->data['pdf_invoice_auto_notify'] = $this->request->post['pdf_invoice_auto_notify'];
    	} else { 
			$this->data['pdf_invoice_auto_notify'] = $this->config->get('pdf_invoice_auto_notify');
		}
		
		if (isset($this->request->post['pdf_invoice_duedate'])) {
			$this->data['pdf_invoice_duedate'] = $this->request->post['pdf_invoice_duedate'];
		} else {
			$this->data['pdf_invoice_duedate'] = $this->config->get('pdf_invoice_duedate');
		}
		
		if (isset($this->request->post['pdf_invoice_adminlang'])) {
			$this->data['pdf_invoice_adminlang'] = $this->request->post['pdf_invoice_adminlang'];
		} else {
			$this->data['pdf_invoice_adminlang'] = $this->config->get('pdf_invoice_adminlang');
		}
		
		if (isset($this->request->post['pdf_invoice_icon'])) {
			$this->data['pdf_invoice_icon'] = $this->request->post['pdf_invoice_icon'];
		} else {
			$this->data['pdf_invoice_icon'] = $this->config->get('pdf_invoice_icon');
		}
		
		// Tab 2 - invoice settings
		$this->load->model('tool/image');
		
		if (isset($this->request->post['pdf_invoice_logo'])) {
			$this->data['pdf_invoice_logo'] = $this->request->post['pdf_invoice_logo'];
		} else {
			$this->data['pdf_invoice_logo'] = $this->config->get('pdf_invoice_logo');
		}
		
		if (isset($this->request->post['pdf_invoice_logo']) && file_exists(DIR_IMAGE . $this->request->post['pdf_invoice_logo'])) {
			$this->data['thumb_header'] = $this->model_tool_image->resize($this->request->post['pdf_invoice_logo'], 200, 60);
		} elseif ($this->config->get('pdf_invoice_logo') && file_exists(DIR_IMAGE . $this->config->get('pdf_invoice_logo'))) {
			$this->data['thumb_header'] = $this->model_tool_image->resize($this->config->get('pdf_invoice_logo'), 200, 60);
		} else {
			$this->data['thumb_header'] = $this->model_tool_image->resize('no_image.jpg', 200, 60);
		}
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 200, 60);
		
		if (isset($this->request->post['pdf_invoice_filename_prefix'])) {
			$this->data['pdf_invoice_filename_prefix'] = $this->request->post['pdf_invoice_filename_prefix'] ? true : false;
		} else {
			$this->data['pdf_invoice_filename_prefix'] = $this->config->get('pdf_invoice_filename_prefix');
		}
		
		if (isset($this->request->post['pdf_invoice_filename_invnum'])) {
			$this->data['pdf_invoice_filename_invnum'] = $this->request->post['pdf_invoice_filename_invnum'] ? true : false;
		} else {
			$this->data['pdf_invoice_filename_invnum'] = $this->config->get('pdf_invoice_filename_invnum');
		}
		
		if (isset($this->request->post['pdf_invoice_filename_ordnum'])) {
			$this->data['pdf_invoice_filename_ordnum'] = $this->request->post['pdf_invoice_filename_ordnum'] ? true : false;
		} else {
			$this->data['pdf_invoice_filename_ordnum'] = $this->config->get('pdf_invoice_filename_ordnum');
		}
		
		// columns
		if (isset($this->request->post['pdf_invoice_col_image'])) {
			$this->data['pdf_invoice_col_image'] = $this->request->post['pdf_invoice_col_image'] ? true : false;
		} else {
			$this->data['pdf_invoice_col_image'] = $this->config->get('pdf_invoice_col_image');
		}
		
		if (isset($this->request->post['pdf_invoice_col_product'])) {
			$this->data['pdf_invoice_col_product'] = $this->request->post['pdf_invoice_col_product'] ? true : false;
		} else {
			$this->data['pdf_invoice_col_product'] = $this->config->get('pdf_invoice_col_product');
		}
		
		if (isset($this->request->post['pdf_invoice_col_model'])) {
			$this->data['pdf_invoice_col_model'] = $this->request->post['pdf_invoice_col_model'] ? true : false;
		} else {
			$this->data['pdf_invoice_col_model'] = $this->config->get('pdf_invoice_col_model');
		}
		
		if (isset($this->request->post['pdf_invoice_col_quantity'])) {
			$this->data['pdf_invoice_col_quantity'] = $this->request->post['pdf_invoice_col_quantity'] ? true : false;
		} else {
			$this->data['pdf_invoice_col_quantity'] = $this->config->get('pdf_invoice_col_quantity');
		}
		
		if (isset($this->request->post['pdf_invoice_col_unitprice'])) {
			$this->data['pdf_invoice_col_unitprice'] = $this->request->post['pdf_invoice_col_unitprice'] ? true : false;
		} else {
			$this->data['pdf_invoice_col_unitprice'] = $this->config->get('pdf_invoice_col_unitprice');
		}
		
		if (isset($this->request->post['pdf_invoice_inlineqty'])) {
			$this->data['pdf_invoice_inlineqty'] = $this->request->post['pdf_invoice_inlineqty'] ? true : false;
		} else {
			$this->data['pdf_invoice_inlineqty'] = $this->config->get('pdf_invoice_inlineqty');
		}
		
		if (isset($this->request->post['pdf_invoice_thumbwidth'])) {
			$this->data['pdf_invoice_thumbwidth'] = $this->request->post['pdf_invoice_thumbwidth'];
		} else {
			$this->data['pdf_invoice_thumbwidth'] = $this->config->get('pdf_invoice_thumbwidth');
		}
		
		if (isset($this->request->post['pdf_invoice_thumbheight'])) {
			$this->data['pdf_invoice_thumbheight'] = $this->request->post['pdf_invoice_thumbheight'];
		} else {
			$this->data['pdf_invoice_thumbheight'] = $this->config->get('pdf_invoice_thumbheight');
		}
		
		foreach ($languages as $language) {
			if (isset( $this->request->post[ 'pdf_invoice_filename_'.$language['code'] ])) {
				$this->data[ 'pdf_invoice_filename_'.$language['code'] ] = str_replace('/', '-', trim($this->request->post[ 'pdf_invoice_filename_'.$language['code'] ]));
			} else {
				$this->data[ 'pdf_invoice_filename_'.$language['code'] ] = $this->config->get('pdf_invoice_filename_'.$language['code']);
			}
			
			if (isset( $this->request->post[ 'pdf_invoice_size_'.$language['code'] ])) {
				$this->data[ 'pdf_invoice_size_'.$language['code'] ] = trim($this->request->post[ 'pdf_invoice_size_'.$language['code'] ]);
			} else {
				$this->data[ 'pdf_invoice_size_'.$language['code'] ] = $this->config->get('pdf_invoice_size_'.$language['code']);
			}
			
			if (isset( $this->request->post[ 'pdf_invoice_footer_'.$language['code'] ])) {
				$this->data[ 'pdf_invoice_footer_'.$language['code'] ] = $this->request->post[ 'pdf_invoice_footer_'.$language['code'] ];
			} else {
				$this->data[ 'pdf_invoice_footer_'.$language['code'] ] = $this->config->get('pdf_invoice_footer_'.$language['code']);
			}
		}
		
		// Tab 4 - custom blocks
		$this->data['payment_methods'] = array();
		$payment_methods = glob(DIR_APPLICATION . 'controller/payment/*.php');
		if ($payment_methods) {
			
			if(defined('_JEXEC')) {
				$language = $this->language;
			} else if(isset($languages[$this->config->get('config_admin_language')])) { // 1.5.1 language bug
				$language = new Language($languages[$this->config->get('config_admin_language')]['directory']);
			} else {
				$language = new Language($languages[$this->config->get('config_language_id')]['directory']);
			}
			
			
			foreach ($payment_methods as $payment) {
				$language->load('payment/' . basename($payment, '.php'));
				$this->data['payment_methods'][] = array(
					'code'        => basename($payment, '.php'),
					'name'       => $language->get('heading_title'),
				);
			}
		}
		
		$this->data['block_positions'] = array(
			'top' => $this->language->get('text_top'),
			'middle' => $this->language->get('text_middle'),
			'bottom' => $this->language->get('text_bottom'),
			'newpage' => $this->language->get('text_newpage'),
		);
		
		$this->data['block_displays'] = array();
		$this->data['block_displays'][] = array(
			'value' => 'show',
			'name' => 'Always enabled',
			'section' => 0,
		);
		
		$this->data['pdf_invoice_blocks'] = array();

		if (isset($this->request->post['pdf_invoice_blocks'])) {
			$this->data['pdf_invoice_blocks'] = $this->request->post['pdf_invoice_blocks'];
		} elseif ($this->config->get('pdf_invoice_blocks')) { 
			$this->data['pdf_invoice_blocks'] = $this->config->get('pdf_invoice_blocks');
		}
		
		/* gestion des variables */

		$this->template = 'module/pdf_invoice_lite.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function tree() {
		$_POST['dir'] = urldecode($_POST['dir']);
		$root = DIR_SYSTEM . '../'.$this->config->get('pdf_invoice_backup_folder');

		if( file_exists($root . $_POST['dir']) ) {
			$files = scandir($root . $_POST['dir']);
			natcasesort($files);
			if( count($files) > 2 ) { /* . and .. */
				echo "<ul class=\"jqueryFileTree\" style=\"display: none;\">";
				// All dirs
				foreach( $files as $file ) {
					if( file_exists($root . $_POST['dir'] . $file) && $file != '.' && $file != '..' && is_dir($root . $_POST['dir'] . $file) ) {
						echo '<li class="directory collapsed"><a href="#" rel="' . htmlentities($_POST['dir'] . $file) . '/">' . htmlentities($file) . '</a></li>';
					}
				}
				// All files
				foreach( $files as $file ) {
					if( file_exists($root . $_POST['dir'] . $file) && $file != '.' && $file != '..' && !is_dir($root . $_POST['dir'] . $file) && substr($file, -3) == 'pdf' ) {
						$ext = preg_replace('/^.*\./', '', $file);
						echo '<li class="file ext_'.$ext.'"><a target="new" href="'.$this->url->link('module/pdf_invoice_lite/getfile', 'dir=' . htmlentities($_POST['dir'])  . '&file=' . htmlentities($file) . '&token=' . $this->session->data['token'], 'SSL').'" rel="' . htmlentities($_POST['dir'] . $file) . '">' . htmlentities($file) . '</a></li>';
					}
				}
				echo "</ul>";	
			}
		}
		die;
	}

	public function getfile() {
		$fld = DIR_SYSTEM . '../'.$this->config->get('pdf_invoice_backup_folder') . $_GET['dir'] . '/';
		$filename =  $_GET['file'];
		
		if(!file_exists($fld.'/'.$filename))
			return 'File not found';
		
		//@ob_end_clean();
		header('Pragma: public');
		header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
		header('Cache-Control: must-revalidate, pre-check=0, post-check=0, max-age=0');
		header("Content-Transfer-Encoding: binary");
		header("Content-Type: application/octet-stream");
		header("Content-Disposition: attachment; filename=\"".$filename."\"");
		header("Content-Length: ".(string)(filesize($fld.$filename)));
		if ($file = fopen($fld.$filename, 'rb')) {
			while (!feof($file) && (connection_status()==0)) {
				print(fread($file, 1024*8));
				flush();
			}
			fclose($file);
		}
		die;
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pdf_invoice_lite')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function install() {
		$this->load->model('setting/setting');
		
		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		
		$ml_settings = array();
		foreach($languages as $language)
		{
			$ml_settings['pdf_invoice_filename_'.$language['code']] = 'Invoice';
		}
		
		$this->model_setting_setting->editSetting('pdf_invoice', array(
			'pdf_invoice_template' => 'default',
			'pdf_invoice_mail' => true,
			'pdf_invoice_tax' => $this->config->get('config_tax'),
			'pdf_invoice_invoiced' => false,
			'pdf_invoice_logo' => $this->config->get('config_logo'),
			'pdf_invoice_icon' => 'invoice-pdf1.png',
			'pdf_invoice_filename_prefix' => true,
			'pdf_invoice_filename_ordnum' => true,
			'pdf_invoice_thumbwidth' => 60,
			'pdf_invoice_thumbheight' => 60,
			'pdf_invoice_col_product' => true,
			'pdf_invoice_col_model' => true,
			'pdf_invoice_col_unitprice' => true,
			'pdf_invoice_inlineqty' => true,
			'pdf_invoice_sliptemplate' => 'default',
		) + $ml_settings);
		
		// generate bug on 1.5.1
		//$this->redirect($this->url->link('module/pdf_invoice_lite', 'token=' . $this->session->data['token'], 'SSL'));
	}
}
?>