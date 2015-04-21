<?php
define('PDF_INVOICE_ADMIN', true);
if(isset($vqmod))
	require_once($vqmod->modCheck(DIR_SYSTEM.'../catalog/model/tool/pdf_invoice.php'));
else
	require_once(VQMod::modCheck(DIR_SYSTEM.'../catalog/model/tool/pdf_invoice.php'));