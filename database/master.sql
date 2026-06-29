USE djamil_siti;

-- Table Roles
CREATE TABLE `roles` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  `status` BOOLEAN DEFAULT TRUE,
  -- Kunci Sistem (Cegah Penghapusan Role Inti)
  `system` BOOLEAN NOT NULL DEFAULT FALSE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL
);

-- Table Module
CREATE TABLE `modules` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  -- Urutan Tampil di Menu
  `sorted` TINYINT NOT NULL DEFAULT 0,
  `status` BOOLEAN DEFAULT TRUE,
  -- Kunci Sistem (Cegah Penghapusan Role Inti)
  `system` BOOLEAN NOT NULL DEFAULT FALSE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL
);

-- Table Staff (Perawat)
CREATE TABLE `staff` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kode` VARCHAR(7) NOT NULL,
  `roleKey` INT NOT NULL,
  `nik` VARCHAR(16) NOT NULL,
  `nip` VARCHAR(20) NOT NULL,
  `fullname` VARCHAR(150) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `dob` DATE NOT NULL,
  `gender` ENUM('Pria', 'Wanita') NOT NULL,
  `alamat` TEXT NOT NULL,
  `urlfiles` TEXT DEFAULT NULL,
  -- Jabatan Keperawatan
  `jabatan` VARCHAR(100) NOT NULL,
  -- Tingkat Pendidikan
  `pendidikan` ENUM('D3','D4','S1','Ners','S2','S3') NOT NULL,
  -- Tanggal Bergabung
  `tgl_bergabung` DATE NOT NULL,
  -- Surat Tanda Registrasi
  `no_str` VARCHAR(50) NOT NULL,
  -- Tanggal Kadaluarsa STR
  `tgl_str_exp` DATE NOT NULL,
  -- Surat Izin Praktik
  `no_sip` VARCHAR(50) NOT NULL,
  -- Tanggal Kadaluarsa SIP
  `tgl_sip_exp` DATE NOT NULL,
  `isactive` BOOLEAN DEFAULT TRUE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE KEY `kode` (`kode`),
  UNIQUE KEY `nik` (`nik`),
  UNIQUE KEY `nip` (`nip`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `no_str` (`no_str`),
  UNIQUE KEY `no_sip` (`no_sip`),
  -- Role Key in Staff
  KEY `idx_staff_roleKey` (`roleKey`),
  -- Hubungan Tabel
  CONSTRAINT `fk_staff_role`
  FOREIGN KEY (`roleKey`)
  REFERENCES `roles` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

-- Table Pasien
CREATE TABLE `patients` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `kode` VARCHAR(7) NOT NULL,
  `roleKey` INT NOT NULL,
  -- Nomor Rekam Medis
  `mrn` VARCHAR(8) NOT NULL DEFAULT '00000000',
  `nik` VARCHAR(16) NOT NULL,
  `fullname` VARCHAR(150) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `dob` DATE NOT NULL,
  `gender` ENUM('Pria', 'Wanita') NOT NULL,
  `alamat` TEXT NOT NULL,
  `urlfiles` TEXT DEFAULT NULL,
  -- Riwayat Alergi
  `alergi` TEXT DEFAULT NULL,
  `isactive` BOOLEAN DEFAULT TRUE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE KEY `kode` (`kode`),
  UNIQUE KEY `mrn` (`mrn`),
  UNIQUE KEY `nik` (`nik`),
  UNIQUE KEY `email` (`email`),
  -- Role Key in Pasien
  KEY `idx_patients_roleKey` (`roleKey`),
  -- Hubungan Tabel
  CONSTRAINT `fk_patients_role`
  FOREIGN KEY (`roleKey`)
  REFERENCES `roles` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

-- Table Bagian Perijinan Aplikasi
CREATE TABLE `permissions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `moduleKey` INT NOT NULL,
  `nama` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  -- Global Flag (0 = fitur dimatikan untuk semua role)
  `readable` BOOLEAN NOT NULL DEFAULT TRUE,
  `creatable` BOOLEAN NOT NULL DEFAULT TRUE,
  `editable` BOOLEAN NOT NULL DEFAULT TRUE,
  `deletable` BOOLEAN NOT NULL DEFAULT TRUE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL,
  -- Mencegah duplikasi nama permission dalam satu modul
  UNIQUE KEY `unique_module_nama` (`moduleKey`, `nama`),
  KEY `idx_permissions_moduleKey` (`moduleKey`),
  -- Foreign Key
  CONSTRAINT `fk_permissions_module`
  FOREIGN KEY (`moduleKey`)
  REFERENCES `modules` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

-- Tabel Privileges
CREATE TABLE `privileges` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `roleKey` INT NOT NULL,
  `permissionKey` INT NOT NULL,
  `readable` BOOLEAN NOT NULL DEFAULT FALSE,
  `creatable` BOOLEAN NOT NULL DEFAULT FALSE,
  `editable` BOOLEAN NOT NULL DEFAULT FALSE,
  `deletable` BOOLEAN NOT NULL DEFAULT FALSE,
  -- Status Aktif Privilege
  `status` BOOLEAN NOT NULL DEFAULT TRUE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE KEY `unique_role_permission` (`roleKey`, `permissionKey`),
  KEY `fk_privileges_permission` (`permissionKey`),
  -- Foreign Key I
  CONSTRAINT `fk_privileges_role`
  FOREIGN KEY (`roleKey`)
  REFERENCES `roles` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  -- Foreign Key II
  CONSTRAINT `fk_privileges_permission`
  FOREIGN KEY (`permissionKey`)
  REFERENCES `permissions` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

-- Table Kontak Darurat Pasien
CREATE TABLE `emergencies` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `patientKey` INT NOT NULL,
  `fullname` VARCHAR(150) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  -- Hubungan dengan Pasien
  `relation` VARCHAR(50) NOT NULL,
  -- Urutan Kontak (1 = Utama, 2 = Cadangan)
  `priority` ENUM('1','2') NOT NULL,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL,
  -- Satu pasien hanya boleh punya satu kontak per prioritas
  UNIQUE KEY `unique_patient_priority` (`patientKey`, `priority`),
  KEY `idx_patient_emergency_patientKey` (`patientKey`),
  -- Hubungan Tabel
  CONSTRAINT `fk_patient_emergency_patient`
  FOREIGN KEY (`patientKey`)
  REFERENCES `patients` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

-- Table Code Igniter 3 Sessions
CREATE TABLE `sessions` (
  `id` VARCHAR(128) NOT NULL PRIMARY KEY,
  `ip_address` VARCHAR(45) NOT NULL,
  `timestamp` INT UNSIGNED DEFAULT 0 NOT NULL,
  `data` BLOB NOT NULL,
  KEY `ci_sessions_timestamp` (`timestamp`)
);

-- Table Login History
CREATE TABLE `login_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `patientKey` INT NOT NULL,
  -- Tanggal Sign In
  `login_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Sign Out
  `logout_at` TIMESTAMP NULL DEFAULT NULL,
  `ip_address` VARCHAR(45) DEFAULT NULL,
  -- Index Pasien
  KEY `idx_patient_login_history_patientKey` (`patientKey`),
  -- Index u Query Sesi Aktif (WHERE logout_at IS NULL)
  KEY `idx_patient_login_history_logout_at` (`logout_at`),
  -- Hubungan Tabel
  CONSTRAINT `fk_patient_login_history_patient`
    FOREIGN KEY (`patientKey`)
    REFERENCES `patients` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- Table Blog
CREATE TABLE `blogs` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  -- Blog
  `url` VARCHAR(255) NOT NULL,
  `desc` TEXT NOT NULL,
  `status` BOOLEAN DEFAULT TRUE,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- Tanggal Hapus
  `deleted` TIMESTAMP NULL DEFAULT NULL
);

-- Table Login Credential
CREATE TABLE `login_credential` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  -- Referensi ke Staff atau Pasien (via kode)
  `userKey` VARCHAR(7) NOT NULL,
  `nik` VARCHAR(16) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `roleKey` INT NOT NULL,
  `isactive` BOOLEAN DEFAULT TRUE,
  -- Tanggal Terakhir Login
  `last_login` TIMESTAMP NULL DEFAULT NULL,
  -- Tanggal Init
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `nik` (`nik`),
  UNIQUE KEY `userKey` (`userKey`),
  -- Role Key in Credential
  KEY `idx_login_credential_roleKey` (`roleKey`),
  -- Hubungan Tabel
  CONSTRAINT `fk_login_credential_role`
  FOREIGN KEY (`roleKey`)
  REFERENCES `roles` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

-- Table Master (Konfigurasi Aplikasi)
CREATE TABLE `master` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `telephone` VARCHAR(15) NOT NULL,
  -- Tanggal Perubahan
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);