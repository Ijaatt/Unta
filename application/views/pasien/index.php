<div class="patient-table-wrap">
  <!-- ? -->
  <div class="patient-search-wrap">
    <div class="patient-search-box">
      <i class="bi bi-search patient-search-icon"></i>
      <input type="text" id="patientSearch" class="patient-search-input" placeholder="Nama / No. Rekam Medis..." autocomplete="off">
    </div>
    <div class="patient-limit-wrap">
      <span class="patient-limit-label">Jumlah Data Dalam Tabel : </span>
      <select id="patientLimit" class="patient-limit-select">
        <option value="5" selected>5</option>
        <option value="10">10</option>
        <option value="25">25</option>
        <option value="50">50</option>
        <option value="100">100</option>
      </select>
    </div>
  </div>
  <!-- ? -->
  <div class="table-responsive">
    <table class="patient-table">
      <thead>
        <tr>
          <th>#</th>
          <th>Nomor Rekam Medis</th>
          <th>Nama Pasien</th>
          <th>Jenis Kelamin</th>
          <th>Aksi</th>
        </tr>
      </thead>
      <tbody id="patientBody">
      </tbody>
    </table>
  </div>
  <!-- ? -->
  <div class="patient-pagination">
    <span class="patient-count" id="patientCount"></span>
    <div class="patient-page-btns" id="patientPages"></div>
  </div>
</div>

<script>
const dataUrl = "<?= base_url('pasien/tables') ?>";
let allData = [];
let currentPage = 1;
const BASE_URL = "<?php base_url(); ?>";

function getFilteredData() {
  // Control Filter
  const query = document.getElementById('patientSearch').value.toLowerCase().trim();
  // Hasil Filter
  return allData.filter(p => (p.fullname || '').toLowerCase().includes(query) || (p.mrn || '').toLowerCase().includes(query));
}

function renderPatients() {
  // ?
  const limit = parseInt(document.getElementById('patientLimit').value, 10) || 5;
  const data = getFilteredData();
  const total = data.length;
  const pages = Math.max(1, Math.ceil(total / limit));
  const start = (currentPage > pages ? (currentPage = 1) : currentPage - 1) * limit;
  const pageData = data.slice(start, start + limit);
  // ?
  renderTableBody(pageData, start);
  renderCount(total, start, limit);
  renderPagination(pages);
}

function renderTableBody(pageData, start) {
  // ?
  const tbody = document.getElementById('patientBody');
  // ?
  if (!pageData.length) {
    tbody.innerHTML = `<tr><td colspan="5" class="empty-state">Tidak Ada Data Pasien</td></tr>`;
    return;
  }
  // ?
  tbody.innerHTML = pageData.map((p, i) => `
    <tr>
      <td class="row-num">${start + i + 1}</td>
      <td class="mrn-cell">${p.mrn ?? '<span class="badge-unassigned">Belum Assign</span>'}</td>
      <td>${p.fullname}</td>
      <td>${p.gender}</td>
      <td>
        <a href="${BASE_URL}pasien/detail/${p.id}" class="btn-action-view">
          <i class="bi bi-eye"></i>
        </a>
      </td>
    </tr>
  `).join('');
}

function renderCount(total, start, limit) {
  // ?
  const text = total
    ? `${start + 1}–${Math.min(start + limit, total)} dari ${total} pasien`
    : '0 pasien';
  document.getElementById('patientCount').textContent = text;
}

function renderPagination(pages) {
  // ?
  const wrap = document.getElementById('patientPages');
  wrap.innerHTML = pages <= 1 ? '' : Array.from({ length: pages }, (_, i) => `
    <button type="button" class="page-btn ${currentPage === i + 1 ? 'active' : ''}" onclick="goPage(${i + 1})">
      ${i + 1}
    </button>
  `).join('');
}

function goPage(page) {
  // ?
  currentPage = page;
  // ?
  renderPatients();
}

function updateHandlers() {
  // ?
  document.getElementById('patientSearch').addEventListener('input', () => {
    currentPage = 1;
    renderPatients();
  });
  // ?
  document.getElementById('patientLimit').addEventListener('change', () => {
    currentPage = 1;
    renderPatients();
  });
}

fetch(dataUrl)
  .then(response => response.json())
  .then(data => {
    console.log(data);
    allData = Array.isArray(data) ? data : (data && Array.isArray(data.data) ? data.data : []);
    renderPatients();
    updateHandlers();
  })
  .catch(error => {
    console.error('Error Fetching Data :', error);
    document.getElementById('patientBody').innerHTML = `<tr><td colspan="5" class="empty-state">Gagal Memuat Data Pasien !</td></tr>`;
    document.getElementById('patientCount').textContent = '0 Dari 0 Pasien';
  });

window.goPage = goPage;
</script>