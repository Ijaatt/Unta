<?php
// Auth Model to Auth Controller
defined('BASEPATH') or exit('No direct script access allowed');

class Auth_model extends CI_Model {
  // Auth Model Melakukan Handling Data In & Data Out Database Tentang Ijin User
  public function __construct(){
    // Construct Parent
    parent::__construct();
  }

  public function login($nik, $pwd){
    $resultset = false;
    $filter = array('nik' => $nik, 'isactive' => 1);
    $this->db->where($filter);
    $reroles = $this->db->get('login_credential')->row_array();
    if ($reroles && password_verify($pwd, $reroles['password'])) {
      $this->db->where('nik', $nik);
      $lastlogin = array('last_login' => date('Y-m-d H:i:s'));
      $this->db->update('login_credential', $lastlogin);
      // Role Key 2
      if ($reroles['roleKey'] == 2) {
        $this->db->where($filter);
        $resultset = $this->db->get('staff')->row_array();
      // Role Key 3
      } else if ($reroles['roleKey'] == 3) {
        $this->db->where($filter);
        $resultset = $this->db->get('patients')->row_array();
        if ($resultset){
          // Sign In History
          $history = array('patientKey' => $resultset['id']);
          $history['ip_address'] = $this->input->ip_address();
          $history['login_at'] = date('Y-m-d H:i:s');
          $this->db->insert('login_history', $history);
          $this->session->set_userdata('historyKey', $this->db->insert_id());
        }
      }
    }
    return $resultset;
  }

  public function register($data){
    // Tabel 0
    $this->db->trans_start();
    // Tabel I
    $incredentials = array('roleKey' => $data['roleKey'], 'nik' => $data['nik']);
    $incredentials['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
    $incredentials['userKey'] = substr(hashslinging(), 1, 7);
    $this->db->insert('login_credential', $incredentials);
    // Del
    unset($data['password']);
    // Tabel II
    $data['kode'] = $incredentials['userKey'];
    $this->db->insert('patients', $data);
    $this->db->trans_complete();
    return $this->db->trans_status();
  }

  public function logout(){
    // Final Sign Out
    $historyKey = $this->session->userdata('historyKey');
    $this->db->where('id', $historyKey);
    $logtime = array('logout_at' => date('Y-m-d H:i:s'));
    return $this->db->update('login_history', $logtime);
  }
}
?>