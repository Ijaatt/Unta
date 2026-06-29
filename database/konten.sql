USE djamil_siti;

INSERT INTO roles (`nama`, `label`, `system`) VALUES ('Super Admin', 'superadmin', 1);
INSERT INTO roles (`nama`, `label`, `system`) VALUES ('Perawat', 'perawat', 1);
INSERT INTO roles (`nama`, `label`, `system`) VALUES ('Patient', 'patient', 1);

INSERT INTO modules (`nama`, `label`, `sorted`, `system`) VALUES ('Hub', 'hub', '1', 1);
INSERT INTO modules (`nama`, `label`, `sorted`, `system`) VALUES ('Blog', 'blog', '2', 1);