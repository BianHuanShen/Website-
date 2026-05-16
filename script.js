/* =========================================
   DARK CLOUD STORAGE APP
========================================= */

// Elementos principales
const fileInput = document.getElementById('fileInput');
const dropZone = document.getElementById('dropZone');
const fileGrid = document.getElementById('fileGrid');
const uploadTrigger = document.getElementById('uploadTrigger');
const selectBtn = document.getElementById('selectBtn');
const uploadProgress = document.getElementById('uploadProgress');
const uploadFill = document.getElementById('uploadFill');
const progressPercent = document.getElementById('progressPercent');
const notificationContainer = document.getElementById('notificationContainer');
const searchInput = document.getElementById('searchInput');
const activityList = document.getElementById('activityList');

// Estadísticas
const totalFilesEl = document.getElementById('totalFiles');
const usedSpaceEl = document.getElementById('usedSpace');
const mediaFilesEl = document.getElementById('mediaFiles');
const fileTypesEl = document.getElementById('fileTypes');
const storageFill = document.getElementById('storageFill');
const storagePercent = document.getElementById('storagePercent');
const storageText = document.getElementById('storageText');

// Capacidad simulada
const STORAGE_LIMIT = 500 * 1024 * 1024;

// Archivos almacenados
let files = JSON.parse(localStorage.getItem('darkCloudFiles')) || [];

// =========================================
// LOADER
// =========================================

window.addEventListener('load', () => {
  setTimeout(() => {
    document.getElementById('loaderWrapper').classList.add('hidden');
  }, 1800);

  renderFiles();
  updateStats();
});

// =========================================
// BOTONES DE SUBIDA
// =========================================

uploadTrigger.addEventListener('click', () => fileInput.click());
selectBtn.addEventListener('click', () => fileInput.click());

dropZone.addEventListener('click', () => fileInput.click());

fileInput.addEventListener('change', (e) => {
  handleFiles(e.target.files);
});

// =========================================
// DRAG & DROP
// =========================================

['dragenter', 'dragover'].forEach(eventName => {
  dropZone.addEventListener(eventName, (e) => {
    e.preventDefault();
    dropZone.classList.add('dragover');
  });
});

['dragleave', 'drop'].forEach(eventName => {
  dropZone.addEventListener(eventName, () => {
    dropZone.classList.remove('dragover');
  });
});

dropZone.addEventListener('drop', (e) => {
  e.preventDefault();

  const droppedFiles = e.dataTransfer.files;
  handleFiles(droppedFiles);
});

// =========================================
// MANEJO DE ARCHIVOS
// =========================================

function handleFiles(selectedFiles) {

  if (!selectedFiles.length) return;

  uploadProgress.classList.remove('hidden');

  let progress = 0;

  const interval = setInterval(() => {

    progress += 10;

    uploadFill.style.width = `${progress}%`;
    progressPercent.textContent = `${progress}%`;

    if (progress >= 100) {

      clearInterval(interval);

      Array.from(selectedFiles).forEach(file => {

        const reader = new FileReader();

        reader.onload = function(event) {

          const fileData = {
            id: Date.now() + Math.random(),
            name: file.name,
            size: file.size,
            type: file.type,
            date: new Date().toLocaleString(),
            data: event.target.result
          };

          files.unshift(fileData);

          saveFiles();
          renderFiles();
          updateStats();

          addActivity(`Archivo subido: ${file.name}`);

          showNotification(`${file.name} subido correctamente`, 'success');
        };

        reader.readAsDataURL(file);
      });

      setTimeout(() => {
        uploadProgress.classList.add('hidden');
        uploadFill.style.width = '0%';
        progressPercent.textContent = '0%';
      }, 600);
    }

  }, 150);
}

// =========================================
// RENDER DE ARCHIVOS
// =========================================

function renderFiles(filter = 'all', search = '') {

  fileGrid.innerHTML = '';

  let filteredFiles = files.filter(file => {

    const matchesSearch = file.name.toLowerCase().includes(search.toLowerCase());

    if (filter === 'all') return matchesSearch;

    return getCategory(file.type) === filter && matchesSearch;
  });

  if (!filteredFiles.length) {
    fileGrid.innerHTML = `
      <div class="empty-message">
        No hay archivos disponibles.
      </div>
    `;

    return;
  }

  filteredFiles.forEach(file => {

    const card = document.createElement('div');
    card.className = 'file-card';

    card.innerHTML = `
      <div class="preview">
        ${generatePreview(file)}
      </div>

      <div class="file-info">
        <div class="file-name">${file.name}</div>

        <div class="file-meta">
          <span>${formatFileSize(file.size)}</span>
          <span>${getFileExtension(file.name)}</span>
        </div>

        <div class="file-actions">
          <button class="action-btn download-btn" onclick="downloadFile('${file.id}')">
            <i class="fa-solid fa-download"></i>
          </button>

          <button class="action-btn delete-btn" onclick="deleteFile('${file.id}')">
            <i class="fa-solid fa-trash"></i>
          </button>
        </div>
      </div>
    `;

    fileGrid.appendChild(card);
  });
}

// =========================================
// GENERAR PREVIEW
// =========================================

function generatePreview(file) {

  if (file.type.startsWith('image/')) {
    return `<img src="${file.data}" alt="preview">`;
  }

  if (file.type.startsWith('video/')) {
    return `
      <video controls>
        <source src="${file.data}" type="${file.type}">
      </video>
    `;
  }

  if (file.type.startsWith('audio/')) {
    return `
      <audio controls>
        <source src="${file.data}" type="${file.type}">
      </audio>
    `;
  }

  if (file.type === 'application/pdf') {
    return `<iframe src="${file.data}"></iframe>`;
  }

  return `
    <div class="file-placeholder">
      <i class="fa-solid fa-file"></i>
    </div>
  `;
}

// =========================================
// DESCARGAR ARCHIVO
// =========================================

function downloadFile(id) {

  const file = files.find(f => f.id == id);

  if (!file) return;

  const link = document.createElement('a');

  link.href = file.data;
  link.download = file.name;

  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);

  addActivity(`Archivo descargado: ${file.name}`);

  showNotification(`${file.name} descargado`, 'success');
}

// =========================================
// ELIMINAR ARCHIVO
// =========================================

function deleteFile(id) {

  const file = files.find(f => f.id == id);

  files = files.filter(f => f.id != id);

  saveFiles();
  renderFiles();
  updateStats();

  addActivity(`Archivo eliminado: ${file.name}`);

  showNotification(`${file.name} eliminado`, 'error');
}

// =========================================
// GUARDAR EN LOCAL STORAGE
// =========================================

function saveFiles() {
  localStorage.setItem('darkCloudFiles', JSON.stringify(files));
}

// =========================================
// ESTADÍSTICAS
// =========================================

function updateStats() {

  totalFilesEl.textContent = files.length;

  const totalSize = files.reduce((sum, file) => sum + file.size, 0);

  usedSpaceEl.textContent = formatFileSize(totalSize);

  const mediaFiles = files.filter(file =>
    file.type.startsWith('image/') ||
    file.type.startsWith('video/') ||
    file.type.startsWith('audio/')
  ).length;

  mediaFilesEl.textContent = mediaFiles;

  const uniqueTypes = new Set(files.map(file => getFileExtension(file.name)));

  fileTypesEl.textContent = uniqueTypes.size;

  const percentage = Math.min((totalSize / STORAGE_LIMIT) * 100, 100);

  storageFill.style.width = `${percentage}%`;
  storagePercent.textContent = `${percentage.toFixed(0)}%`;

  storageText.textContent = `${formatFileSize(totalSize)} de 500 MB`;
}

// =========================================
// FILTROS
// =========================================

const filterButtons = document.querySelectorAll('.filter-btn');

filterButtons.forEach(button => {

  button.addEventListener('click', () => {

    document.querySelector('.filter-btn.active').classList.remove('active');

    button.classList.add('active');

    renderFiles(button.dataset.filter, searchInput.value);
  });
});

// =========================================
// BÚSQUEDA
// =========================================

searchInput.addEventListener('input', () => {

  const activeFilter = document.querySelector('.filter-btn.active').dataset.filter;

  renderFiles(activeFilter, searchInput.value);
});

// =========================================
// ACTIVIDAD RECIENTE
// =========================================

function addActivity(text) {

  if (activityList.querySelector('.empty-message')) {
    activityList.innerHTML = '';
  }

  const activity = document.createElement('div');
  activity.className = 'activity-item';

  activity.innerHTML = `
    <div class="activity-icon">
      <i class="fa-solid fa-clock-rotate-left"></i>
    </div>

    <div>
      <strong>${text}</strong>
      <p>${new Date().toLocaleString()}</p>
    </div>
  `;

  activityList.prepend(activity);
}

// =========================================
// NOTIFICACIONES
// =========================================

function showNotification(message, type = 'success') {

  const notification = document.createElement('div');

  notification.className = 'notification';

  notification.innerHTML = `
    <strong>${type === 'success' ? 'Éxito' : 'Acción'}</strong>
    <p>${message}</p>
  `;

  notificationContainer.appendChild(notification);

  setTimeout(() => {
    notification.remove();
  }, 4000);
}

// =========================================
// UTILIDADES
// =========================================

function formatFileSize(bytes) {

  if (bytes < 1024) return bytes + ' B';

  if (bytes < 1024 * 1024) {
    return (bytes / 1024).toFixed(1) + ' KB';
  }

  return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
}

function getFileExtension(filename) {
  return filename.split('.').pop().toUpperCase();
}

function getCategory(type) {

  if (type.startsWith('image/')) return 'image';

  if (type.startsWith('video/')) return 'video';

  if (type.startsWith('audio/')) return 'audio';

  if (
    type.includes('pdf') ||
    type.includes('word') ||
    type.includes('excel') ||
    type.includes('text') ||
    type.includes('javascript') ||
    type.includes('html') ||
    type.includes('css')
  ) {
    return 'document';
  }

  return 'other';
  }
