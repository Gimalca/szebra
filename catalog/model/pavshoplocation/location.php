<?php
/**
 * class ModelPavnewsletterSubscribe
 */
class ModelPavshoplocationLocation extends Model {

	/**
	 * [buildQuery Locations]
	 * @param  array   $data
	 * @param  boolean $get_total
	 */
	public function buildQuery($data = array()){

		$store_id = isset($data['store_id'])?$data['store_id']:0;

		$sql = "SELECT g.store_id, l.*, ld.title, ld.content FROM `".DB_PREFIX."pavshoplocation_location` l 
				LEFT JOIN `".DB_PREFIX."pavshoplocation_location_description` ld ON l.location_id = ld.location_id
				LEFT JOIN `".DB_PREFIX."pavshoplocation_group_location` g ON g.group_location_id = l.group_location_id 
				WHERE ld.language_id = '" . (int)$this->config->get('config_language_id') . "' AND
						l.status = 1 AND g.status = 1 AND g.store_id = " .(int)$store_id;

		$sort = "location_id";
		$order = "DESC";
		$ordering = " ORDER BY `".$sort."` ".$order;

		$limit_start = 0;
		$limit_end = isset($data['limit'])?$data['limit']:20;
		$limit = " LIMIT ".$limit_start.",".$limit_end;

		$sql .= $ordering.$limit;

		return $sql;
	}

	/**
	 * [getLocations]
	 * @param  array  $data
	 * @return array  $rows
	 */
	public function getLocations($data = array()) {
		$sql = $this->buildQuery($data);
		$query = $this->db->query($sql);
		return $query->rows;
	}

}