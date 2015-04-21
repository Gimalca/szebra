<?php
		function pdf($data, $name) {
			if (count($name) > 1) {
				$name = "Orders";
			}else{
				$name = 'Orden'.$name[0]['order_id'].'-'.$name[0]['date_added'];
			}
			$pdf = new DOMPDF;
			$pdf->load_html($data);
			$pdf->render();
			$pdf->stream($name.".pdf");
		}
			
?>