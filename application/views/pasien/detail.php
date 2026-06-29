<div class="profile-page">

  <form method="post" action="<?= base_url('pasien/publish/') ?>" enctype="multipart/form-data" id="detailForm">
    <section class="profile-section">
      <div class="section-title" style="justify-content: space-between;">
        <div style="display: flex; align-items: center; gap: 12px;">
          <i class="bi bi-person-lines-fill section-icon"></i>
          <p class="lead">Informasi Dasar</p>
        </div>
        <button type="button" class="btn-edit-icon" id="btnToggleEdit" onclick="toggleEdit()">
          <i class="bi bi-pencil"></i>
        </button>
      </div>
      <!-- ? -->
      <div class="form-floating-soft" style="display: none">
        <input type="text" name="alamat" class="form-control custom-input editable" value="<?= $results['kode'] ?>" readonly>
      </div>
      <!-- ? -->
      <div class="row g-3">
        <div class="col-12 col-md-6">
          <div class="form-floating-soft">
            <label>Nomor Induk Kependudukan</label>
            <input type="text" name="nik" class="form-control custom-input editable" value="<?= $results['nik'] ?>" maxlength="16" readonly>
          </div>
          <div class="form-floating-soft">
            <label>Nama Lengkap</label>
            <input type="text" name="fullname" class="form-control custom-input editable" value="<?= $results['fullname'] ?>" maxlength="150" readonly>
          </div>
          <div class="form-floating-soft">
            <label>Tanggal Lahir</label>
            <input type="date" name="dob" class="form-control custom-input editable" value="<?= $results['dob'] ?>" readonly>
          </div>
        </div>
        <div class="col-12 col-md-6">
          <div class="form-floating-soft">
            <label>Jenis Kelamin</label>
            <select name="gender" id="gender" class="form-control custom-input editable" disabled>
              <option value="Pria" <?= $results['gender'] == 'Pria' ? 'selected' : ''; ?>>Pria</option>
              <option value="Wanita" <?= $results['gender'] == 'Wanita' ? 'selected' : ''; ?>>Wanita</option>
            </select>
          </div>
          <div class="form-floating-soft">
            <label>Email</label>
            <input type="email" name="email" class="form-control custom-input editable" value="<?= $results['email'] ?>" maxlength="150" readonly>
          </div>
          <div class="form-floating-soft">
            <label>Telefon</label>
            <input type="text" name="phone" class="form-control custom-input editable" value="<?= $results['phone'] ?>" maxlength="20" readonly>
          </div>
        </div>
      </div>

      <div class="form-floating-soft">
        <label>Tempat Tinggal</label>
        <input type="text" name="alamat" class="form-control custom-input editable" value="<?= $results['alamat'] ?>" readonly>
      </div>

      <div class="form-floating-soft" id="wrapFoto" style="display: none;">
        <label>Foto Profil</label>
        <input type="file" name="urlfiles" class="form-control custom-input" accept="image/*">
      </div>

      <div class="profile-actions" id="profileActions" style="display: none;">
        <button type="reset" class="btn btn-soft" onclick="toggleEdit()">Batal</button>
        <button type="submit" class="btn btn-care">Perbarui</button>
      </div>

    </section>
  </form>

</div>

<script>
function toggleEdit() {
  const inputs = document.querySelectorAll('.editable');
  const actions = document.getElementById('profileActions');
  const btn = document.getElementById('btnToggleEdit');
  const wrapFoto = document.getElementById('wrapFoto');
  const isEditing = btn.dataset.editing === 'true';
  if (isEditing) {
    inputs.forEach(i => i.setAttribute('readonly', true));
    inputs.forEach(i => i.setAttribute('disabled', true));
    actions.style.display = 'none';
    wrapFoto.style.display = 'none';
    btn.innerHTML = '<i class="bi bi-pencil"></i>';
    btn.dataset.editing = 'false';
  } else {
    inputs.forEach(i => i.removeAttribute('readonly'));
    inputs.forEach(i => i.removeAttribute('disabled'));
    actions.style.display = 'flex';
    wrapFoto.style.display = 'block';
    btn.innerHTML = '<i class="bi bi-eye"></i>';
    btn.dataset.editing = 'true';
  }
}
</script>