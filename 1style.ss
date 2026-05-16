/* =========================================
   VARIABLES GLOBALES
========================================= */

:root {
  --bg-primary: #06070d;
  --bg-secondary: #0d111b;
  --card-bg: rgba(255, 255, 255, 0.05);
  --border-color: rgba(255, 255, 255, 0.08);
  --text-primary: #ffffff;
  --text-secondary: #a7b0c2;
  --blue: #3b82f6;
  --purple: #8b5cf6;
  --green: #22c55e;
  --orange: #f59e0b;
  --danger: #ef4444;
  --shadow: 0 10px 40px rgba(0,0,0,0.45);
  --radius: 20px;
}

/* =========================================
   RESET
========================================= */

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: 'Inter', sans-serif;
  background:
    radial-gradient(circle at top left, rgba(59,130,246,0.12), transparent 30%),
    radial-gradient(circle at bottom right, rgba(139,92,246,0.12), transparent 30%),
    var(--bg-primary);
  color: var(--text-primary);
  overflow-x: hidden;
}

/* =========================================
   GLASS EFFECT
========================================= */

.glass {
  background: var(--card-bg);
  border: 1px solid var(--border-color);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  box-shadow: var(--shadow);
}

/* =========================================
   LOADER
========================================= */

.loader-wrapper {
  position: fixed;
  inset: 0;
  background: #05060a;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  gap: 20px;
  z-index: 9999;
  transition: 0.5s ease;
}

.loader-wrapper.hidden {
  opacity: 0;
  visibility: hidden;
}

.loader {
  width: 80px;
  height: 80px;
  border: 6px solid rgba(255,255,255,0.1);
  border-top-color: var(--blue);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* =========================================
   LAYOUT
========================================= */

.app-container {
  display: flex;
  min-height: 100vh;
}

.sidebar {
  width: 300px;
  background: rgba(10,10,15,0.95);
  border-right: 1px solid rgba(255,255,255,0.06);
  padding: 25px;
  position: sticky;
  top: 0;
  height: 100vh;
}

.main-content {
  flex: 1;
  padding: 30px;
}

/* =========================================
   LOGO
========================================= */

.logo {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 40px;
}

.logo-icon {
  width: 60px;
  height: 60px;
  border-radius: 18px;
  background: linear-gradient(135deg, var(--blue), var(--purple));
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  box-shadow: 0 0 25px rgba(59,130,246,0.4);
}

.logo p {
  color: var(--text-secondary);
  font-size: 13px;
}

/* =========================================
   SIDEBAR NAV
========================================= */

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 40px;
}

.sidebar-nav a {
  color: var(--text-secondary);
  text-decoration: none;
  padding: 14px 18px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  gap: 12px;
  transition: 0.3s ease;
}

.sidebar-nav a:hover,
.sidebar-nav a.active {
  background: rgba(59,130,246,0.12);
  color: white;
  transform: translateX(5px);
}

/* =========================================
   STORAGE CARD
========================================= */

.storage-card {
  padding: 20px;
  border-radius: var(--radius);
}

.storage-top {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.progress-bar {
  width: 100%;
  height: 10px;
  background: rgba(255,255,255,0.06);
  border-radius: 50px;
  overflow: hidden;
}

.progress-bar.large {
  height: 16px;
}

.progress-fill {
  width: 0;
  height: 100%;
  border-radius: 50px;
  background: linear-gradient(90deg, var(--blue), var(--purple));
  transition: 0.4s ease;
}

.storage-card p {
  margin-top: 12px;
  color: var(--text-secondary);
  font-size: 14px;
}

/* =========================================
   TOPBAR
========================================= */

.topbar {
  padding: 25px;
  border-radius: var(--radius);
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.topbar p {
  color: var(--text-secondary);
  margin-top: 5px;
}

.topbar-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.search-box {
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.06);
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 18px;
  border-radius: 14px;
}

.search-box input {
  background: transparent;
  border: none;
  outline: none;
  color: white;
  width: 240px;
}

/* =========================================
   BOTONES
========================================= */

.premium-btn {
  border: none;
  background: linear-gradient(135deg, var(--blue), var(--purple));
  color: white;
  padding: 14px 22px;
  border-radius: 14px;
  cursor: pointer;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 10px;
  transition: 0.3s ease;
}

.premium-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(59,130,246,0.3);
}

.premium-btn.secondary {
  background: rgba(255,255,255,0.08);
}

/* =========================================
   STATS
========================================= */

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.stat-card {
  padding: 25px;
  border-radius: var(--radius);
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-card h3 {
  font-size: 28px;
}

.stat-card p {
  color: var(--text-secondary);
}

.stat-icon {
  width: 65px;
  height: 65px;
  border-radius: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.blue {
  background: rgba(59,130,246,0.18);
  color: var(--blue);
}

.purple {
  background: rgba(139,92,246,0.18);
  color: var(--purple);
}

.green {
  background: rgba(34,197,94,0.18);
  color: var(--green);
}

.orange {
  background: rgba(245,158,11,0.18);
  color: var(--orange);
}

/* =========================================
   SECTIONS
========================================= */

.section-title {
  margin-bottom: 20px;
}

.section-title p {
  color: var(--text-secondary);
  margin-top: 5px;
}

.upload-section,
.recent-activity,
.filters {
  padding: 25px;
  border-radius: var(--radius);
  margin-bottom: 30px;
}

/* =========================================
   DROP ZONE
========================================= */

.drop-zone {
  border: 2px dashed rgba(255,255,255,0.12);
  border-radius: 24px;
  min-height: 320px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: 0.3s ease;
  cursor: pointer;
}

.drop-zone.dragover {
  border-color: var(--blue);
  background: rgba(59,130,246,0.08);
}

.drop-content {
  text-align: center;
}

.upload-icon {
  width: 100px;
  height: 100px;
  border-radius: 30px;
  margin: 0 auto 20px;
  background: linear-gradient(135deg, rgba(59,130,246,0.15), rgba(139,92,246,0.15));
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  color: var(--blue);
}

.drop-content p {
  margin: 10px 0 20px;
  color: var(--text-secondary);
}

/* =========================================
   FILTERS
========================================= */

.filters {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.filter-btn {
  border: none;
  background: rgba(255,255,255,0.05);
  color: var(--text-secondary);
  padding: 12px 18px;
  border-radius: 12px;
  cursor: pointer;
  transition: 0.3s ease;
}

.filter-btn:hover,
.filter-btn.active {
  background: linear-gradient(135deg, var(--blue), var(--purple));
  color: white;
}

/* =========================================
   FILE GRID
========================================= */

.file-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
}

.file-card {
  background: rgba(255,255,255,0.05);
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 24px;
  overflow: hidden;
  transition: 0.3s ease;
  position: relative;
}

.file-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 20px 50px rgba(0,0,0,0.4);
}

.preview {
  height: 180px;
  background: rgba(255,255,255,0.03);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.preview img,
.preview video,
.preview iframe {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.preview audio {
  width: 90%;
}

.file-placeholder {
  font-size: 50px;
  color: var(--blue);
}

.file-info {
  padding: 20px;
}

.file-name {
  font-weight: 600;
  margin-bottom: 8px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.file-meta {
  color: var(--text-secondary);
  font-size: 14px;
  display: flex;
  justify-content: space-between;
}

.file-actions {
  display: flex;
  gap: 10px;
  margin-top: 20px;
}

.action-btn {
  flex: 1;
  border: none;
  padding: 12px;
  border-radius: 12px;
  cursor: pointer;
  color: white;
  transition: 0.3s ease;
}

.download-btn {
  background: linear-gradient(135deg, var(--blue), var(--purple));
}

.delete-btn {
  background: rgba(239,68,68,0.15);
  color: #ff8a8a;
}

.action-btn:hover {
  transform: translateY(-2px);
}

/* =========================================
   ACTIVITY
========================================= */

.activity-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.activity-item {
  background: rgba(255,255,255,0.04);
  padding: 15px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  gap: 15px;
}

.activity-icon {
  width: 45px;
  height: 45px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(59,130,246,0.14);
  color: var(--blue);
}

.empty-message {
  color: var(--text-secondary);
}

/* =========================================
   NOTIFICACIONES
========================================= */

.notification-container {
  position: fixed;
  top: 20px;
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  z-index: 99999;
}

.notification {
  padding: 16px 20px;
  border-radius: 14px;
  background: rgba(20,20,25,0.95);
  border: 1px solid rgba(255,255,255,0.08);
  min-width: 300px;
  animation: slideIn 0.4s ease;
}

@keyframes slideIn {
  from {
    transform: translateX(100px);
    opacity: 0;
  }

  to {
    transform: translateX(0);
    opacity: 1;
  }
}

/* =========================================
   UTILIDADES
========================================= */

.hidden {
  display: none;
}

/* =========================================
   RESPONSIVE
========================================= */

@media(max-width: 1100px) {
  .sidebar {
    display: none;
  }

  .main-content {
    padding: 20px;
  }
}

@media(max-width: 768px) {

  .topbar {
    flex-direction: column;
    align-items: flex-start;
    gap: 20px;
  }

  .topbar-actions {
    width: 100%;
    flex-direction: column;
  }

  .search-box {
    width: 100%;
  }

  .search-box input {
    width: 100%;
  }

  .premium-btn {
    width: 100%;
    justify-content: center;
  }

  .drop-zone {
    min-height: 260px;
    padding: 20px;
  }

  .upload-icon {
    width: 80px;
    height: 80px;
  }

  .file-grid {
    grid-template-columns: 1fr;
  }
}
