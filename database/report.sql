USE djamil_siti;

CREATE OR REPLACE VIEW `rolelimit` AS
  SELECT
    priv.id as privilegeKey,
    priv.roleKey,
    priv.readable,
    priv.creatable,
    priv.editable,
    priv.deletable,
    perm.id AS permissionKey,
    perm.nama,
    perm.label,
    perm.moduleKey
  FROM
    privileges priv
  JOIN
    permissions perm ON perm.id = priv.permissionKey
  WHERE
    priv.deleted IS NULL AND perm.deleted IS NULL;

CREATE OR REPLACE VIEW `riwayatlogin` AS
  SELECT
    p.id,
    p.kode as patientKey,
    p.fullname,
    COUNT(lh.id) AS total_login,
    -- Tanggal Pertama Login
    MIN(lh.login_at) AS first_login,
    -- Tanggal Terakhir Login
    MAX(lh.login_at) AS last_login
  FROM
    patients p
  LEFT JOIN
    login_history lh ON lh.patientKey = p.id
  WHERE
    p.deleted IS NULL
  GROUP BY
    p.id, p.kode, p.fullname;