<div class="profile-page">
  <!-- Publish Input -->
  <form method="post" action="<?= base_url('pasien/publish') ?>" enctype="multipart/form-data" id="insertForm">
    <section class="profile-section">
      <!-- Title Panel -->
      <div class="section-title">
        <i class="bi bi-person-plus-fill section-icon"></i>
        <p class="lead">Tambah Pasien Baru</p>
      </div>
      <!-- First Panel -->
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <!-- Nomor Induk Kependudukan -->
          <div class="form-floating-soft">
            <label>Nomor Induk Kependudukan</label>
            <input type="text" name="nik" class="form-control custom-input" placeholder="1234..." maxlength="16" required>
          </div>
        </div>
        <div class="col-12 col-md-6">
          <!-- Nama Lengkap -->
          <div class="form-floating-soft">
            <label>Nama Lengkap</label>
            <input type="text" name="fullname" class="form-control custom-input" placeholder="Nama Lengkap Pasien" maxlength="150" required>
          </div>
        </div>
      </div>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <!-- Kode Rekam Medis Pasien -->
          <div class="form-floating-soft">
            <label>Kode Rekam Medis Pasien</label>
            <input type="text" name="mrn" class="form-control custom-input" placeholder="0000000" maxlength="9" required>
          </div>
        </div>
        <div class="col-12 col-md-6">
          <!-- Jenis Kelamin -->
          <div class="form-floating-soft">
            <label>Jenis Kelamin</label>
            <select name="gender" class="form-control custom-input" style="-webkit-appearance:none;appearance:none;" required>
              <option value="Pria">Pria</option>
              <option value="Wanita">Wanita</option>
            </select>
          </div>
        </div>
      </div>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <!-- ? -->
          <div class="form-floating-soft">
            <label>Email</label>
            <input type="email" name="email" class="form-control custom-input" placeholder="nama@email.com" maxlength="150" required>
          </div>
        </div>
        <div class="col-12 col-md-6">
          <!-- ? -->
          <div class="form-floating-soft">
            <label>Telefon</label>
            <input type="text" name="phone" class="form-control custom-input" placeholder="08..." maxlength="20" required>
          </div>
        </div>
      </div>
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <!-- ? -->
          <div class="form-floating-soft">
            <label>Tanggal Lahir</label>
            <input type="date" name="dob" class="form-control custom-input" required>
          </div>
        </div>
        <div class="col-12 col-md-6">
          <!-- ? -->
          <div class="form-floating-soft">
            <label>Tempat Tinggal</label>
            <input type="text" name="alamat" class="form-control custom-input" placeholder="Jalan..." required>
          </div>
        </div>
      </div>
      <div class="row g-3">
        <div class="col-12">
          <!-- ? -->
          <div class="form-floating-soft">
            <label>Foto Profil</label>
            <input type="file" name="urlfiles" class="form-control custom-input" accept="image/*">
          </div>
        </div>
      </div>
      <div class="profile-actions mt-2">
        <a href="<?= base_url('pasien') ?>" class="btn btn-soft">Batal</a>
        <button type="submit" class="btn btn-care">Simpan Pasien</button>
      </div>
    </section>
  </form>
</div>