<?php
function log_err( $num, $str, $file, $line, $context = null){
file_put_contents( DIR_SYSTEM . "logs/pdf_error.log", $str .' - file:'.$file .' - line:'.$line . PHP_EOL, FILE_APPEND );
}

class PdfLanguage {
	private $default = 'english';
	private $directory;
	private $data = array();

	public function __construct($directory) {
		$this->directory = $directory;
		$this->load($directory);
		$this->load('module/pdf_invoice');
	}

	public function get($key) {
		return (isset($this->data[$key]) ? $this->data[$key] : $key);
	}

	public function load($filename) {
		$file = DIR_SYSTEM . '../catalog/language/' . $this->directory . '/' . $filename . '.php';
		
		if (file_exists($file)) {
			$_ = array();
			require($file);
			$this->data = array_merge($this->data, $_);
			return $this->data;
		}

		$file = DIR_SYSTEM . '../catalog/language/' . $this->default . '/' . $filename . '.php';

		if (file_exists($file)) {
			$_ = array();
			require($file);
			$this->data = array_merge($this->data, $_);
			return $this->data;
		} else {
			return $this->data;
			//trigger_error('Error: Could not load language ' . $filename . '!');
		}
	}
}

class ModelToolPdfInvoice extends Model {

	/**************************
	*
	* @orders: order numbers
	* @mode: display, file, backup
	* @type: invoice, packingslip
	*
	***************************/
	public function generate($orders, $mode = 'display', $type = 'invoice', $lang = '') {
		$orders = is_array($orders) ? $orders : array($orders);
		$template = new Template();
		
		$template->config = $this->config;
		
		/*
		$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', 'account/order');
		include_once(VQMod::modCheck(DIR_SYSTEM . '../catalog/model/account/order.php'));	
		$this->registry->set('model_' . str_replace('/', '_', 'account/order'), new $class($this->registry));
		*/
		
		if(defined('PDF_INVOICE_ADMIN')){
			$basepath = (!isset($this->request->server['HTTPS']) || ($this->request->server['HTTPS'] != 'on')) ? HTTP_CATALOG : HTTPS_CATALOG;
			$this->load->model('sale/order');
			$order_model = 'model_sale_order';
			$order_model2 = 'model_sale_order';
			$this->load->model('sale/order');
			$template_path = '../../../catalog/view/theme/';
		}
		else{
			$basepath = (!isset($this->request->server['HTTPS']) || ($this->request->server['HTTPS'] != 'on')) ? HTTP_SERVER : HTTPS_SERVER;
			$this->load->model('account/order');
			$order_model = 'model_checkout_order';
			$order_model2 = 'model_account_order';
			$this->load->model('checkout/order');
			$this->load->model('account/order');
			$template_path = '';
		}
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$http_image = defined('_JEXEC') ? HTTPS_IMAGE : $basepath . 'image/';
		} else {
			$http_image = defined('_JEXEC') ? HTTP_IMAGE : $basepath . 'image/';
		}
		
		$this->load->model('setting/setting');

		$pdf_html = '';
		
		foreach ($orders as $order_id) {
		$order_info = $this->{$order_model}->getOrder($order_id);

		if ($order_info) {
			$template->data['order'] = $order_info;
			
				if(isset($_newpage))
					$template->data['_newpage'] = true;
				$_newpage = true;
				
			//language
			$this->load->model('localisation/language');
				if($lang) {
					$user_lang = $this->model_localisation_language->getLanguage($lang);
				} else {
				$user_lang = $this->model_localisation_language->getLanguage($order_info['language_id']);
			}

			//$lang_dir = $user_lang['directory'];
			$lang_code = $user_lang['code'];
			$lang_id = $user_lang['language_id'];
			
			if (defined('_JEXEC')) {
				$language = new PdfLanguage($user_lang['locale']);
			} else {
				$language = new PdfLanguage($user_lang['directory']);
			}
			$template->language = $language;
			
			//data
				$template->data['title'] = $language->get('heading_title');
				$template->data['direction'] = $language->get('direction');
			$template->data['language'] = $lang_code;

				$template->data['text_invoice'] = $language->get('text_invoice');

				$template->data['text_order_id'] = $language->get('text_order_id');
				$template->data['text_invoice_no'] = $language->get('text_invoice_no');
				$template->data['text_invoice_date'] = $language->get('text_invoice_date');
				$template->data['text_date_added'] = $language->get('text_date_added');
				$template->data['text_date_due'] = $language->get('text_date_due');
				$template->data['text_telephone'] = $language->get('text_telephone');
				$template->data['text_email'] = $language->get('text_email');
				$template->data['text_fax'] = $language->get('text_fax');
				$template->data['text_url'] = $language->get('text_url');
				$template->data['text_company_id'] = $language->get('text_company_id');
				$template->data['text_tax_id'] = $language->get('text_tax_id');		
				$template->data['text_payment_method'] = $language->get('text_payment_method');
				$template->data['text_shipping_method'] = $language->get('text_shipping_method');

				$template->data['text_product'] = $language->get('column_product');
				$template->data['text_model'] = $language->get('column_model');
				$template->data['text_quantity'] = $language->get('column_quantity');
				$template->data['text_price'] = $language->get('column_price');
				$template->data['text_total'] = $language->get('column_total');
			
			//missing values
				$template->data['text_customer_id'] = $language->get('text_customer_id');
				$template->data['text_order_detail'] = $language->get('text_order_detail');
				$template->data['text_payment_address'] = $language->get('text_payment_address');
				$template->data['text_shipping_address'] = $language->get('text_shipping_address');
				$template->data['text_email'] = $language->get('text_email');
			$template->data['base'] = $basepath;
			$template->data['logo'] = DIR_IMAGE . $this->config->get('pdf_invoice_logo');
			$template->data['column_count'] =  (int)$this->config->get('pdf_invoice_col_image') + (int)$this->config->get('pdf_invoice_col_product') + (int)$this->config->get('pdf_invoice_col_model') + (int)$this->config->get('pdf_invoice_col_quantity') + (int)$this->config->get('pdf_invoice_col_unitprice');;
				if($this->config->get('pdf_invoice_customerid'))
				$template->data['customer_id'] = sprintf('%1$s%2$0'.$this->config->get('pdf_invoice_customersize').'d', $this->config->get('pdf_invoice_customerprefix'),  $order_info['customer_id']);
				else $template->data['customer_id'] = false;
			
			//comment
				$template->data['text_instruction'] =  $language->get('text_instruction');
			$template->data['comment'] = nl2br($order_info['comment']);
			
				$template->data['custom_title'] = $this->config->get('pdf_invoice_title_'.$lang_code) ? $this->config->get('pdf_invoice_title_'.$lang_code) : $language->get('text_instruction');
			$template->data['custom_comment'] = html_entity_decode($this->config->get('pdf_invoice_message_'.$lang_code), ENT_QUOTES, 'UTF-8');
			
			// custom blocks
			$template->data['blocks_top'] =
			$template->data['blocks_middle'] = 
			$template->data['blocks_bottom'] = 
			$template->data['blocks_newpage'] = array();
			
			$blocks = $this->config->get('pdf_invoice_blocks');
			
			if ($blocks) {
				foreach ($blocks as $block) {
					list($display, $value) = explode('|', $block['display']);
					if($display == 'always' && $value == 0) continue;
					elseif($display == 'customer_group_id' && $value != $order_info['customer_group_id']) continue;
					elseif($display == 'order_status_id' && $value != $order_info['order_status_id']) continue;
					elseif($display == 'payment_code' && $value != $order_info['payment_code']) continue;
						elseif($type == 'packingslip' && $display != 'packing_slip') continue;
					
					if ($block['display']) {
						$template->data['blocks_'.$block['position']][] = array(
							'title' => $block['title'][$lang_id],
							'description' =>  html_entity_decode($block['description'][$lang_id], ENT_QUOTES, 'UTF-8'),
							'sort_order' => $block['sort_order']
						);
					}
				}
			}
			
			foreach (array('top', 'middle', 'bottom', 'newpage') as $pos) {
				if($template->data['blocks_'.$pos]) {
					usort($template->data['blocks_'.$pos], array($this, 'cmp'));
				}
			}
			
			$store_info = $this->model_setting_setting->getSetting('config', $order_info['store_id']);
			
			if ($store_info) {
				$store_address = $store_info['config_address'];
				$store_email = $store_info['config_email'];
				$store_telephone = $store_info['config_telephone'];
				$store_fax = $store_info['config_fax'];
			} else {
				$store_address = $this->config->get('config_address');
				$store_email = $this->config->get('config_email');
				$store_telephone = $this->config->get('config_telephone');
				$store_fax = $this->config->get('config_fax');
			}
			
			if ($order_info['shipping_address_format']) {
				$format = $order_info['shipping_address_format'];
			} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}

			$find = array(
				'{firstname}',
				'{lastname}',
				'{company}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);

			$replace = array(
				'firstname' => $order_info['shipping_firstname'],
				'lastname'  => $order_info['shipping_lastname'],
				'company'   => $order_info['shipping_company'],
				'address_1' => $order_info['shipping_address_1'],
				'address_2' => $order_info['shipping_address_2'],
				'city'      => $order_info['shipping_city'],
				'postcode'  => $order_info['shipping_postcode'],
				'zone'      => $order_info['shipping_zone'],
				'zone_code' => $order_info['shipping_zone_code'],
				'country'   => $order_info['shipping_country']
			);

			$shipping_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

			if ($order_info['payment_address_format']) {
				$format = $order_info['payment_address_format'];
			} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}

			$find = array(
				'{firstname}',
				'{lastname}',
				'{company}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);

			$replace = array(
				'firstname' => $order_info['payment_firstname'],
				'lastname'  => $order_info['payment_lastname'],
				'company'   => $order_info['payment_company'],
				'address_1' => $order_info['payment_address_1'],
				'address_2' => $order_info['payment_address_2'],
				'city'      => $order_info['payment_city'],
				'postcode'  => $order_info['payment_postcode'],
				'zone'      => $order_info['payment_zone'],
				'zone_code' => $order_info['payment_zone_code'],
				'country'   => $order_info['payment_country']
			);

			$payment_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

			$product_data = array();
			
				$products = $this->{$order_model2}->getOrderProducts($order_id);

			foreach ($products as $product) {
				$option_data = array();

					$options = $this->{$order_model2}->getOrderOptions($order_id, $product['order_product_id']);

				foreach ($options as $option) {
					if ($option['type'] != "file") {
						$value = $option['value'];
					} else {
						$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
					}
					
					$option_data[] = array(
						'name'  => $option['name'],
						'value' => $value
					);								
				}
				
				
					$full_product = array(
					'image' => null,
						'mpn' => null,
						'location' => null,
						'sku' => null,
					'weight' => null,
					'weight_class_id' => null,
					);
				
				$get_full_product = false;
				//if(($type == 'invoice' && $this->config->get('pdf_invoice_col_image')) || ($type == 'packingslip' && $this->config->get('pdf_invoice_slip_col_image')))
				if($type == 'invoice' && $this->config->get('pdf_invoice_col_image'))
					$get_full_product = true;
				if($type == 'invoice' && $this->config->get('pdf_invoice_col_weight'))
					$get_full_product = true;
				if($type == 'packingslip')
					$get_full_product = true;
				
				if($get_full_product) {
						$this->load->model('catalog/product');
						$full_product = $this->model_catalog_product->getProduct($product['product_id']);
					}
					
				if($full_product['image']) {
					$this->load->model('tool/image');
					$full_product['image'] = $this->model_tool_image->resize($this->getProductImage($product['product_id']), $this->config->get('pdf_invoice_thumbwidth'), $this->config->get('pdf_invoice_thumbheight'));
					//$full_product['image'] = str_replace($http_image, DIR_IMAGE, $full_product['image']);
				}
				
					
				$product_data[] = array(
					'image'		=> $full_product['image'],
					'name'     => $product['name'],
					'model'    => $product['model'],
					'option'   => $option_data,
					'quantity' => $product['quantity'],
					'price'    => $this->currency->format($product['price'] + ($this->config->get('pdf_invoice_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
						'total'    => $this->currency->format($product['total'] + ($this->config->get('pdf_invoice_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']),
						'mpn'     => $full_product['mpn'],
						'location'     => $full_product['location'],
						'sku'     => $full_product['sku'],
				);
			}
			
			$voucher_data = $vouchers = array();
			
			// 1.5.0 - 1.5.1 compatibility
			if(method_exists($this->model_sale_order, 'getOrderVouchers'))
			$vouchers = $this->model_sale_order->getOrderVouchers($order_id);

			foreach ($vouchers as $voucher) {
				$voucher_data[] = array(
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value'])			
				);
			}
				
				$total_data = $this->{$order_model2}->getOrderTotals($order_id);
			
			$template->data = array_merge($template->data, array(
				'order_id'	         => $order_id,
				'invoice_no'         => $order_info['invoice_no'],
				'invoice_prefix'         => $order_info['invoice_prefix'],
					'date_added'         => date($language->get('pdf_date_format'), strtotime($order_info['date_added'])),
					'date_due'         	=> ($this->config->get('pdf_invoice_duedate') != '') ? date($language->get('pdf_date_format'), strtotime($order_info['date_added'].' + '.$this->config->get('pdf_invoice_duedate').' day')) : '',
				'store_name'         => $order_info['store_name'],
				'store_url'          => rtrim($order_info['store_url'], '/'),
				'store_address'      => nl2br($store_address),
				'store_email'        => $store_email,
				'store_telephone'    => $store_telephone,
				'store_fax'          => $store_fax,
				'email'              => $order_info['email'],
				'telephone'          => $order_info['telephone'],
				'shipping_address'   => $shipping_address,
				'shipping_method'    => $order_info['shipping_method'],
				'payment_address'    => $payment_address,
				'payment_company_id' => isset($order_info['payment_company_id']) ? $order_info['payment_company_id'] : '',
				'payment_tax_id'     => isset($order_info['payment_tax_id']) ? $order_info['payment_tax_id'] : '',
				'payment_method'     => $order_info['payment_method'],
				'products'            => $product_data,
				'vouchers'            => $voucher_data,
				'totals'              => $total_data,
				//'comment'            => nl2br($order_info['comment'])
			));
		}
		
			if($type == 'packingslip') {
				if (file_exists(DIR_TEMPLATE . $template_path . '/default/template/pdf/packingslip/' . $this->config->get('pdf_invoice_template') . '.tpl')) {
					$pdf_html .= $template->fetch($template_path . '/default/template/pdf/packingslip/' . $this->config->get('pdf_invoice_template') . '.tpl');
				}else{
					$pdf_html .= $template->fetch($template_path . '/default/template/pdf/packingslip/default.tpl');
				}
			}else{
			if (file_exists(DIR_TEMPLATE . $template_path . '/default/template/pdf/' . $this->config->get('pdf_invoice_template') . '.tpl')) {
				$pdf_html .= $template->fetch($template_path . '/default/template/pdf/' . $this->config->get('pdf_invoice_template') . '.tpl');
			}else{
				$pdf_html .= $template->fetch($template_path . '/default/template/pdf/default.tpl');
			}
		}
			
			// fix image urls
			$pdf_html = str_replace($http_image, DIR_IMAGE, $pdf_html);
		}
		
		require_once(DIR_SYSTEM . 'library/mpdf/mpdf.php');
		
		if($mode == 'backup'){
			// filename
			$pdfFilename = array();
			if($this->config->get('pdf_invoice_backup_prefix'))
				$pdfFilename[] = trim($this->config->get('pdf_invoice_backup_prefix'));
			if($this->config->get('pdf_invoice_backup_invnum') && $order_info['invoice_no'])
				$pdfFilename[] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
			if($this->config->get('pdf_invoice_backup_ordnum') || (!$this->config->get('pdf_invoice_backup_ordnum') && !$order_info['invoice_no']) || (!$this->config->get('pdf_invoice_backup_ordnum') && !$this->config->get('pdf_invoice_backup_invnum')))
				$pdfFilename[] = $order_id;
			$pdfFilename = implode('-', $pdfFilename) . '.pdf';
			
			$backup_path = DIR_SYSTEM . '../' . $this->config->get('pdf_invoice_backup_folder') . '/';
			
			$structure = $this->config->get('pdf_invoice_backup_structure');
			if($structure)
				$structure = date($structure) . '/';
			
			if(!file_exists($backup_path . $structure))
				mkdir($backup_path . $structure, 0777, true);
				
			if(is_writable($backup_path . $structure))
			{
				$backup_pdf = $backup_path . $structure . '/' . $pdfFilename;
				
				// @perf: check if backup format = source format, if yes just use copy instead of regenerate
				$pageFormat = $this->config->get('pdf_invoice_backup_size') ? $this->config->get('pdf_invoice_backup_size') : 'A4';
				set_error_handler('var_dump', 0);
				$mpdf = new mPDF('', $pageFormat);
				$mpdf->ignore_invalid_utf8 = true;
				$mpdf->autoScriptToLang = true;
				$mpdf->autoLangToFont = true;
				$mpdf->img_dpi = 150;
				$mpdf->setBasePath($basepath);
				$mpdf->WriteHTML($pdf_html);
				$mpdf->Output($backup_pdf, 'F');
				restore_error_handler();
				//copy($temp_pdf, $backup_pdf);
			}
			return;
		}
		
		$pageFormat = $this->config->get('pdf_invoice_backup_size') ? $this->config->get('pdf_invoice_backup_size') : 'A4';
		
		set_error_handler('var_dump', 0);
		//set_error_handler('log_err');
		$mpdf = new mPDF('', $pageFormat);
		$mpdf->ignore_invalid_utf8 = true;
		$mpdf->autoScriptToLang = true;
		$mpdf->autoLangToFont = true;
		$mpdf->img_dpi = 150;
		$mpdf->setBasePath($basepath);
		//$mpdf->SetHtmlFooter('<p>Test footer</p>');
		$mpdf->WriteHTML($pdf_html);
		

		$pdfFilename = array();
		
		if($mode == 'file')
		{
			if($type == 'packingslip')
				$pdfFilename[] = 'Packing-slip';
			elseif($this->config->get('pdf_invoice_filename_prefix') && $this->config->get('pdf_invoice_filename_'.$lang_code))
				$pdfFilename[] = trim($this->config->get('pdf_invoice_filename_'.$lang_code));
			if($this->config->get('pdf_invoice_filename_invnum') && $order_info['invoice_no'])
				$pdfFilename[] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
			if($this->config->get('pdf_invoice_filename_ordnum'))
				$pdfFilename[] = $order_id;
			$pdfFilename = implode('-', $pdfFilename) ? implode('-', $pdfFilename).'.pdf' : 'invoice.pdf';
				$temp_pdf = DIR_CACHE . $pdfFilename;

			$mpdf->Output($temp_pdf, 'F');
			return($temp_pdf);
		}
		else
		{
			if(defined('PDF_INVOICE_ADMIN'))
			{
				if($type == 'packingslip')
					$pdfFilename[] = 'Packing-slip';
				elseif($this->config->get('pdf_invoice_backup_prefix'))
					$pdfFilename[] = trim($this->config->get('pdf_invoice_backup_prefix'));
				if($this->config->get('pdf_invoice_backup_invnum') && $order_info['invoice_no'])
					$pdfFilename[] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
				if($this->config->get('pdf_invoice_backup_ordnum') || (!$this->config->get('pdf_invoice_backup_ordnum') && !$order_info['invoice_no']) || (!$this->config->get('pdf_invoice_backup_ordnum') && !$this->config->get('pdf_invoice_backup_invnum')))
					$pdfFilename[] = $order_id;
				$pdfFilename = implode('-', $pdfFilename) . '.pdf';
			}
			else
			{
				if($this->config->get('pdf_invoice_filename_prefix') && $this->config->get('pdf_invoice_filename_'.$lang_code))
					$pdfFilename[] = trim($this->config->get('pdf_invoice_filename_'.$lang_code));
				if($this->config->get('pdf_invoice_filename_invnum') && $order_info['invoice_no'])
					$pdfFilename[] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
				if($this->config->get('pdf_invoice_filename_ordnum'))
					$pdfFilename[] = $order_id;
				$pdfFilename = implode('-', $pdfFilename) ? implode('-', $pdfFilename).'.pdf' : 'invoice.pdf';
			}
		
			if(1){
				$mpdf->Output($pdfFilename, 'D'); // I:inline, D:download, F:save, S:string
				exit;
			}else{
				echo $pdf_html; exit;
			}
		}
	}
	
	private function getProductImage($product_id) {
		$query = $this->db->query("SELECT image FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "' LIMIT 1");
		return isset($query->row['image']) ? $query->row['image'] : '';
	}
	
	private function cmp($a, $b) {
		if ($a['sort_order'] == $b['sort_order']) return 0;
		return ($a['sort_order'] < $b['sort_order']) ? -1 : 1;
	}
}
?>