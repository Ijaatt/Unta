<?php
// Pasien Model to Pasien Controller
defined('BASEPATH') or exit('No direct script access allowed');

class Pasien_model extends CI_Model {
  // Pasien Model Melakukan Handling Data In & Data Out Pasien
  public function __construct(){
    // Construct Parent
    parent::__construct();
  }

  public function getAllData(){
    $column = "id, mrn, fullname, gender";
    $this->db->select($column);
    $this->db->from("patients");
    return $this->db->get()->result_array();
  }

  public function detailByPID($id){
    $column = "id, kode, nik, dob, phone, alamat, fullname, gender, email";
    $this->db->select($column);
    $this->db->from("patients");
    $this->db->where('id', $id);
    return $this->db->get()->row_array();
  }

  public function publishPatient($inputs) {
    $kode = substr(hashslinging(), 1, 7);
    $roleKey = 3;
    $inputs['kode'] = $kode;
    $inputs['roleKey'] = $roleKey;
    $credentials = array('roleKey' => $roleKey, 'userKey' => $kode);
    $credentials['nik'] = $inputs['nik'];
    $credentials['password'] = password_hash('123', PASSWORD_DEFAULT);
    $this->db->trans_start();
    $this->db->insert('patients', $inputs);
    $this->db->insert('login_credential', $credentials);
    $this->db->trans_complete();
    return $this->db->trans_status();
  }
}