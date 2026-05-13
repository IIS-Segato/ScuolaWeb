<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduManager — Pannello Amministratore</title>
    <!-- Font e Icone -->
    <link rel="preconnect" href="[fonts.googleapis.com](https://fonts.googleapis.com)">
    <link rel="preconnect" href="[fonts.gstatic.com](https://fonts.gstatic.com)" crossorigin>
    <link href="[fonts.googleapis.com](https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap)" rel="stylesheet">
    <link rel="stylesheet" href="[cdnjs.cloudflare.com](https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css)">
    <style >/* ===== CSS VARIABLES ===== */
:root {
    /* Colors */
    --primary: #6366f1;
    --primary-light: #818cf8;
    --primary-dark: #4f46e5;
    --secondary: #10b981;
    --accent: #f59e0b;
    --danger: #ef4444;
    --warning: #f59e0b;
    
    /* Backgrounds */
    --bg-primary: #0f0f23;
    --bg-secondary: #1a1a2e;
    --bg-tertiary: #16213e;
    --bg-card: rgba(26, 26, 46, 0.8);
    --bg-card-hover: rgba(26, 26, 46, 0.95);
    
    /* Text */
    --text-primary: #f8fafc;
    --text-secondary: #94a3b8;
    --text-muted: #64748b;
    
    /* Borders */
    --border-color: rgba(148, 163, 184, 0.1);
    --border-color-hover: rgba(148, 163, 184, 0.2);
    
    /* Shadows */
    --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.3);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.4);
    --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.5);
    --shadow-glow: 0 0 40px rgba(99, 102, 241, 0.15);
    
    /* Sizing */
    --sidebar-width: 280px;
    --sidebar-collapsed: 80px;
    --header-height: 70px;
    --radius-sm: 8px;
    --radius-md: 12px;
    --radius-lg: 16px;
    --radius-xl: 24px;
    
    /* Transitions */
    --transition-fast: 0.15s ease;
    --transition-base: 0.3s ease;
    --transition-slow: 0.5s ease;
}

/* Light theme variables */
[data-theme="light"] {
    --bg-primary: #f1f5f9;
    --bg-secondary: #ffffff;
    --bg-tertiary: #f8fafc;
    --bg-card: rgba(255, 255, 255, 0.9);
    --bg-card-hover: rgba(255, 255, 255, 1);
    --text-primary: #1e293b;
    --text-secondary: #475569;
    --text-muted: #94a3b8;
    --border-color: rgba(0, 0, 0, 0.08);
    --border-color-hover: rgba(0, 0, 0, 0.15);
    --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

/* ===== RESET & BASE ===== */
*, *::before, *::after {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    font-size: 16px;
    scroll-behavior: smooth;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    background: var(--bg-primary);
    color: var(--text-primary);
    line-height: 1.6;
    overflow-x: hidden;
    min-height: 100vh;
}

/* ===== ANIMATED BACKGROUND ===== */
.background-animation {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
    background: var(--bg-primary);
}

.gradient-sphere {
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
    opacity: 0.5;
    animation: float 20s ease-in-out infinite;
}

.sphere-1 {
    width: 600px;
    height: 600px;
    background: linear-gradient(135deg, var(--primary) 0%, #8b5cf6 100%);
    top: -200px;
    left: -200px;
    animation-delay: 0s;
}

.sphere-2 {
    width: 500px;
    height: 500px;
    background: linear-gradient(135deg, var(--secondary) 0%, #06b6d4 100%);
    bottom: -150px;
    right: -150px;
    animation-delay: -7s;
}

.sphere-3 {
    width: 400px;
    height: 400px;
    background: linear-gradient(135deg, var(--accent) 0%, #f97316 100%);
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation-delay: -14s;
}

@keyframes float {
    0%, 100% { transform: translate(0, 0) scale(1); }
    25% { transform: translate(50px, -50px) scale(1.1); }
    50% { transform: translate(-30px, 30px) scale(0.95); }
    75% { transform: translate(-50px, -30px) scale(1.05); }
}

/* ===== APP CONTAINER ===== */
.app-container {
    display: flex;
    min-height: 100vh;
}

/* ===== SIDEBAR ===== */
.sidebar {
    width: var(--sidebar-width);
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    background: var(--bg-card);
    backdrop-filter: blur(20px);
    border-right: 1px solid var(--border-color);
    display: flex;
    flex-direction: column;
    z-index: 100;
    transition: width var(--transition-base), transform var(--transition-base);
}

.sidebar.collapsed {
    width: var(--sidebar-collapsed);
}

.sidebar.collapsed .logo-text,
.sidebar.collapsed .nav-section-title,
.sidebar.collapsed .nav-item span,
.sidebar.collapsed .badge,
.sidebar.collapsed .user-info,
.sidebar.collapsed .logout-btn {
    opacity: 0;
    visibility: hidden;
}

.sidebar.collapsed .nav-item {
    justify-content: center;
    padding: 14px;
}

.sidebar.collapsed .nav-item i {
    margin-right: 0;
}

.sidebar-header {
    padding: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid var(--border-color);
}

.logo {
    display: flex;
    align-items: center;
    gap: 12px;
}

.logo-icon {
    width: 44px;
    height: 44px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
    border-radius: var(--radius-md);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.25rem;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
}

.logo-text {
    font-size: 1.5rem;
    font-weight: 700;
    background: linear-gradient(135deg, var(--text-primary) 0%, var(--primary-light) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    transition: opacity var(--transition-base);
}

.sidebar-toggle {
    width: 32px;
    height: 32px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all var(--transition-fast);
}

.sidebar-toggle:hover {
    background: var(--primary);
    color: white;
}

.sidebar.collapsed .sidebar-toggle i {
    transform: rotate(180deg);
}

/* Sidebar Navigation */
.sidebar-nav {
    flex: 1;
    padding: 20px 16px;
    overflow-y: auto;
}

.nav-section {
    margin-bottom: 24px;
}

.nav-section-title {
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--text-muted);
    padding: 0 12px;
    margin-bottom: 8px;
    transition: opacity var(--transition-base);
}

.nav-item {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    color: var(--text-secondary);
    text-decoration: none;
    border-radius: var(--radius-md);
    margin-bottom: 4px;
    transition: all var(--transition-fast);
    position: relative;
}

.nav-item i {
    width: 20px;
    margin-right: 12px;
    font-size: 1rem;
    transition: margin var(--transition-base);
}

.nav-item span {
    flex: 1;
    font-weight: 500;
    transition: opacity var(--transition-base);
}

.nav-item:hover {
    background: var(--bg-tertiary);
    color: var(--text-primary);
}

.nav-item.active {
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.badge {
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    font-size: 0.75rem;
    font-weight: 600;
    padding: 2px 8px;
    border-radius: 20px;
    transition: opacity var(--transition-base);
}

.nav-item.active .badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
}

.badge.pulse {
    animation: pulse 2s infinite;
    background: var(--danger);
    color: white;
}

@keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
}

/* Sidebar Footer */
.sidebar-footer {
    padding: 16px;
    border-top: 1px solid var(--border-color);
}

.user-card {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px;
    background: var(--bg-tertiary);
    border-radius: var(--radius-md);
}

.user-avatar {
    position: relative;
    flex-shrink: 0;
}

.user-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
}

.status-indicator {
    position: absolute;
    bottom: 0;
    right: 0;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    border: 2px solid var(--bg-tertiary);
}

.status-indicator.online { background: var(--secondary); }
.status-indicator.away { background: var(--warning); }
.status-indicator.offline { background: var(--text-muted); }

.user-info {
    flex: 1;
    min-width: 0;
    transition: opacity var(--transition-base);
}

.user-name {
    display: block;
    font-weight: 600;
    font-size: 0.875rem;
    color: var(--text-primary);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.user-role {
    display: block;
    font-size: 0.75rem;
    color: var(--text-muted);
}

.logout-btn {
    width: 36px;
    height: 36px;
    border: none;
    background: transparent;
    color: var(--text-muted);
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.logout-btn:hover {
    background: var(--danger);
    color: white;
}

/* ===== MAIN CONTENT ===== */
.main-content {
    flex: 1;
    margin-left: var(--sidebar-width);
    transition: margin-left var(--transition-base);
}

.sidebar.collapsed ~ .main-content {
    margin-left: var(--sidebar-collapsed);
}

/* ===== HEADER ===== */
.main-header {
    height: var(--header-height);
    padding: 0 32px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: var(--bg-card);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--border-color);
    position: sticky;
    top: 0;
    z-index: 50;
}

.header-left {
    display: flex;
    align-items: center;
    gap: 20px;
}

.mobile-menu-btn {
    display: none;
    width: 40px;
    height: 40px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    border-radius: var(--radius-sm);
    cursor: pointer;
}

.breadcrumb {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.875rem;
    color: var(--text-muted);
}

.breadcrumb .current {
    color: var(--text-primary);
    font-weight: 500;
}

.breadcrumb i {
    font-size: 0.625rem;
}

.header-center {
    flex: 1;
    max-width: 500px;
    margin: 0 32px;
}

.search-container {
    position: relative;
    display: flex;
    align-items: center;
}

.search-container i {
    position: absolute;
    left: 16px;
    color: var(--text-muted);
}

.search-input {
    width: 100%;
    padding: 12px 16px 12px 44px;
    background: var(--bg-tertiary);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-lg);
    color: var(--text-primary);
    font-size: 0.875rem;
    transition: all var(--transition-fast);
}

.search-input::placeholder {
    color: var(--text-muted);
}

.search-input:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.search-shortcut {
    position: absolute;
    right: 12px;
    padding: 4px 8px;
    background: var(--bg-card);
    border: 1px solid var(--border-color);
    border-radius: 6px;
    font-size: 0.75rem;
    color: var(--text-muted);
}

.header-right {
    display: flex;
    align-items: center;
    gap: 8px;
}

.header-btn {
    width: 40px;
    height: 40px;
    border: none;
    background: transparent;
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    position: relative;
    transition: all var(--transition-fast);
}

.header-btn:hover {
    background: var(--bg-tertiary);
    color: var(--text-primary);
}

.notification-dot {
    position: absolute;
    top: 8px;
    right: 8px;
    width: 8px;
    height: 8px;
    background: var(--danger);
    border-radius: 50%;
    animation: pulse 2s infinite;
}

/* ===== DASHBOARD CONTENT ===== */
.dashboard-content {
    padding: 32px;
}

/* Welcome Section */
.welcome-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 32px;
    flex-wrap: wrap;
    gap: 20px;
}

.welcome-text h1 {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 4px;
    background: linear-gradient(135deg, var(--text-primary) 0%, var(--primary-light) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.welcome-text p {
    color: var(--text-secondary);
}

.welcome-actions {
    display: flex;
    gap: 12px;
}

/* Buttons */
.btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 20px;
    border: none;
    border-radius: var(--radius-md);
    font-size: 0.875rem;
    font-weight: 600;
    cursor: pointer;
    transition: all var(--transition-fast);
}

.btn-primary {
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
}

.btn-secondary {
    background: var(--bg-tertiary);
    color: var(--text-primary);
    border: 1px solid var(--border-color);
}

.btn-secondary:hover {
    background: var(--bg-card-hover);
    border-color: var(--border-color-hover);
}

.btn-ghost {
    background: transparent;
    color: var(--text-secondary);
    padding: 8px;
}

.btn-ghost:hover {
    background: var(--bg-tertiary);
    color: var(--text-primary);
}

.btn-icon {
    width: 36px;
    height: 36px;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-sm);
}

.btn-icon:hover {
    background: var(--primary);
    color: white;
    border-color: var(--primary);
}

/* Stats Grid */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
    margin-bottom: 32px;
}

.stat-card {
    background: var(--bg-card);
    backdrop-filter: blur(20px);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-lg);
    padding: 24px;
    position: relative;
    overflow: hidden;
    transition: all var(--transition-base);
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: linear-gradient(90deg, var(--accent) 0%, transparent 100%);
}

.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-lg), var(--shadow-glow);
    border-color: var(--border-color-hover);
}

.stat-icon {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, var(--accent) 0%, color-mix(in srgb, var(--accent) 70%, white) 100%);
    border-radius: var(--radius-md);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.25rem;
    margin-bottom: 16px;
    box-shadow: 0 4px 15px color-mix(in srgb, var(--accent) 30%, transparent);
}

.stat-content {
    margin-bottom: 8px;
}

.stat-value {
    display: block;
    font-size: 2rem;
    font-weight: 700;
    color: var(--text-primary);
    line-height: 1.2;
}

.stat-label {
    font-size: 0.875rem;
    color: var(--text-muted);
}

.stat-trend {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

.stat-trend.up {
    background: rgba(16, 185, 129, 0.1);
    color: var(--secondary);
}

.stat-trend.down {
    background: rgba(239, 68, 68, 0.1);
    color: var(--danger);
}

.stat-trend.neutral {
    background: rgba(148, 163, 184, 0.1);
    color: var(--text-muted);
}

.stat-chart {
    position: absolute;
    bottom: 0;
    right: 0;
    width: 100px;
    height: 40px;
    opacity: 0.3;
    color: var(--accent);
}

/* Main Grid */
.main-grid {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 24px;
    margin-bottom: 32px;
}

/* Cards */
.card {
    background: var(--bg-card);
    backdrop-filter: blur(20px);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-lg);
    overflow: hidden;
}

.card-header {
    padding: 20px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid var(--border-color);
}

.card-title {
    display: flex;
    align-items: center;
    gap: 12px;
}

.card-title i {
    color: var(--primary);
}

.card-title h2,
.card-header h3 {
    font-size: 1.125rem;
    font-weight: 600;
    color: var(--text-primary);
}

.card-header h3 {
    display: flex;
    align-items: center;
    gap: 10px;
}

.card-header h3 i {
    color: var(--primary);
    font-size: 1rem;
}

.card-actions {
    display: flex;
    align-items: center;
    gap: 12px;
}

.filter-group {
    display: flex;
    background: var(--bg-tertiary);
    border-radius: var(--radius-sm);
    padding: 4px;
}

.filter-btn {
    padding: 6px 12px;
    border: none;
    background: transparent;
    color: var(--text-muted);
    font-size: 0.8rem;
    font-weight: 500;
    border-radius: 6px;
    cursor: pointer;
    transition: all var(--transition-fast);
}

.filter-btn:hover {
    color: var(--text-primary);
}

.filter-btn.active {
    background: var(--primary);
    color: white;
}

.card-body {
    padding: 24px;
}

/* Data Table */
.table-container {
    overflow-x: auto;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table th,
.data-table td {
    padding: 16px;
    text-align: left;
}

.data-table th {
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: var(--text-muted);
    border-bottom: 1px solid var(--border-color);
}

.data-table tbody tr {
    transition: background var(--transition-fast);
}

.data-table tbody tr:hover {
    background: var(--bg-tertiary);
}

.data-table td {
    border-bottom: 1px solid var(--border-color);
    vertical-align: middle;
}

/* Checkbox */
.checkbox-container {
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

.checkbox-container input {
    display: none;
}

.checkmark {
    width: 18px;
    height: 18px;
    border: 2px solid var(--border-color-hover);
    border-radius: 4px;
    position: relative;
    transition: all var(--transition-fast);
}

.checkbox-container:hover .checkmark {
    border-color: var(--primary);
}

.checkbox-container input:checked + .checkmark {
    background: var(--primary);
    border-color: var(--primary);
}

.checkbox-container input:checked + .checkmark::after {
    content: '\f00c';
    font-family: 'Font Awesome 6 Free';
    font-weight: 900;
    font-size: 10px;
    color: white;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* User Cell */
.user-cell {
    display: flex;
    align-items: center;
    gap: 12px;
}

.user-cell img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
}

.user-cell .name {
    display: block;
    font-weight: 600;
    color: var(--text-primary);
    font-size: 0.875rem;
}

.user-cell .email {
    display: block;
    font-size: 0.75rem;
    color: var(--text-muted);
}

/* Class Badge */
.class-badge {
    display: inline-block;
    padding: 4px 12px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

/* Grade Display */
.grade-display {
    display: flex;
    align-items: center;
    gap: 12px;
}

.grade-display span {
    font-weight: 700;
    font-size: 1rem;
}

.grade-display.excellent span { color: var(--secondary); }
.grade-display.good span { color: var(--primary); }
.grade-display.average span { color: var(--warning); }
.grade-display.poor span { color: var(--danger); }

.grade-bar {
    width: 60px;
    height: 6px;
    background: var(--bg-tertiary);
    border-radius: 3px;
    overflow: hidden;
}

.grade-bar div {
    height: 100%;
    border-radius: 3px;
    transition: width 1s ease;
}

.grade-display.excellent .grade-bar div { background: var(--secondary); }
.grade-display.good .grade-bar div { background: var(--primary); }
.grade-display.average .grade-bar div { background: var(--warning); }
.grade-display.poor .grade-bar div { background: var(--danger); }

/* Attendance Display */
.attendance-display {
    display: flex;
    align-items: center;
    gap: 12px;
}

.attendance-display span:first-child {
    font-weight: 600;
    color: var(--text-primary);
}

.mini-chart {
    display: flex;
    align-items: flex-end;
    gap: 2px;
    height: 24px;
}

.mini-chart span {
    width: 4px;
    background: var(--primary);
    border-radius: 2px;
    opacity: 0.6;
}

/* Status Badge */
.status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

.status-badge.active {
    background: rgba(16, 185, 129, 0.1);
    color: var(--secondary);
}

.status-badge.warning {
    background: rgba(245, 158, 11, 0.1);
    color: var(--warning);
}

.status-badge.inactive {
    background: rgba(239, 68, 68, 0.1);
    color: var(--danger);
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
}

.action-btn {
    width: 32px;
    height: 32px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all var(--transition-fast);
}

.action-btn:hover {
    background: var(--primary);
    color: white;
}

.action-btn.danger:hover {
    background: var(--danger);
}

/* Table Footer */
.table-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 20px;
    border-top: 1px solid var(--border-color);
    margin-top: 16px;
}

.showing-info {
    font-size: 0.875rem;
    color: var(--text-muted);
}

.pagination {
    display: flex;
    align-items: center;
    gap: 8px;
}

.page-btn {
    min-width: 36px;
    height: 36px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    font-size: 0.875rem;
    font-weight: 500;
    transition: all var(--transition-fast);
}

.page-btn:hover:not(:disabled) {
    background: var(--primary);
    color: white;
}

.page-btn.active {
    background: var(--primary);
    color: white;
}

.page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.page-dots {
    color: var(--text-muted);
}

/* Right Sidebar Cards */
.right-sidebar {
    display: flex;
    flex-direction: column;
    gap: 24px;
}

/* Activity Card */
.activity-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.activity-item {
    display: flex;
    gap: 12px;
    padding-bottom: 16px;
    border-bottom: 1px solid var(--border-color);
}

.activity-item:last-child {
    padding-bottom: 0;
    border-bottom: none;
}

.activity-icon {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.875rem;
}

.activity-icon.add {
    background: rgba(16, 185, 129, 0.1);
    color: var(--secondary);
}

.activity-icon.edit {
    background: rgba(99, 102, 241, 0.1);
    color: var(--primary);
}

.activity-icon.alert {
    background: rgba(245, 158, 11, 0.1);
    color: var(--warning);
}

.activity-icon.success {
    background: rgba(16, 185, 129, 0.1);
    color: var(--secondary);
}

.activity-content p {
    font-size: 0.875rem;
    color: var(--text-primary);
    margin-bottom: 2px;
}

.activity-name {
    display: block;
    font-size: 0.8rem;
    color: var(--text-muted);
}

.activity-time {
    display: block;
    font-size: 0.7rem;
    color: var(--text-muted);
    margin-top: 4px;
}

/* Calendar Card */
.calendar-nav {
    display: flex;
    gap: 4px;
}

.calendar-nav button {
    width: 28px;
    height: 28px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.calendar-nav button:hover {
    background: var(--primary);
    color: white;
}

.mini-calendar {
    margin-bottom: 20px;
}

.calendar-header {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 4px;
    margin-bottom: 8px;
}

.calendar-header span {
    text-align: center;
    font-size: 0.7rem;
    font-weight: 600;
    color: var(--text-muted);
    padding: 8px 0;
}

.calendar-days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 4px;
}

.calendar-days span {
    aspect-ratio: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all var(--transition-fast);
    position: relative;
}

.calendar-days span:hover {
    background: var(--bg-tertiary);
}

.calendar-days span.other-month {
    color: var(--text-muted);
    opacity: 0.5;
}

.calendar-days span.weekend {
    color: var(--text-muted);
}

.calendar-days span.today {
    background: var(--primary);
    color: white;
    font-weight: 600;
}

.calendar-days span.has-event::after {
    content: '';
    position: absolute;
    bottom: 4px;
    width: 4px;
    height: 4px;
    background: var(--secondary);
    border-radius: 50%;
}

.upcoming-events h4 {
    font-size: 0.8rem;
    font-weight: 600;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 12px;
}

.event-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px;
    background: var(--bg-tertiary);
    border-radius: var(--radius-sm);
    margin-bottom: 8px;
}

.event-color {
    width: 4px;
    height: 100%;
    min-height: 36px;
    border-radius: 2px;
}

.event-info {
    flex: 1;
}

.event-title {
    display: block;
    font-size: 0.875rem;
    font-weight: 500;
    color: var(--text-primary);
}

.event-time {
    display: block;
    font-size: 0.75rem;
    color: var(--text-muted);
}

/* Quick Actions */
.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}

.quick-action {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    padding: 20px 12px;
    background: var(--bg-tertiary);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.quick-action:hover {
    background: var(--bg-card-hover);
    border-color: var(--primary);
    transform: translateY(-2px);
}

.quick-action i {
    font-size: 1.5rem;
    color: var(--primary);
}

.quick-action span {
    font-size: 0.8rem;
    font-weight: 500;
    color: var(--text-secondary);
    text-align: center;
}

/* Teachers Section */
.teachers-section {
    margin-top: 0;
}

.teachers-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

.teacher-card {
    background: var(--bg-tertiary);
    border-radius: var(--radius-lg);
    padding: 24px;
    text-align: center;
    transition: all var(--transition-base);
    border: 1px solid transparent;
}

.teacher-card:hover {
    border-color: var(--primary);
    transform: translateY(-4px);
    box-shadow: var(--shadow-lg);
}

.teacher-header {
    position: relative;
    display: inline-block;
    margin-bottom: 16px;
}

.teacher-header img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 3px solid var(--bg-card);
}

.teacher-status {
    position: absolute;
    bottom: 4px;
    right: 4px;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 3px solid var(--bg-tertiary);
}

.teacher-status.online { background: var(--secondary); }
.teacher-status.away { background: var(--warning); }
.teacher-status.offline { background: var(--text-muted); }

.teacher-info h4 {
    font-size: 1rem;
    font-weight: 600;
    color: var(--text-primary);
    margin-bottom: 4px;
}

.teacher-subject {
    display: inline-block;
    padding: 4px 12px;
    background: var(--bg-card);
    color: var(--primary);
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    margin-bottom: 16px;
}

.teacher-stats {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-bottom: 16px;
}

.teacher-stat {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 0.8rem;
    color: var(--text-muted);
}

.teacher-stat i {
    color: var(--primary);
}

.teacher-actions {
    display: flex;
    justify-content: center;
    gap: 8px;
}

/* Modal */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(4px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 200;
    opacity: 0;
    visibility: hidden;
    transition: all var(--transition-base);
}

.modal-overlay.active {
    opacity: 1;
    visibility: visible;
}

.modal {
    width: 100%;
    max-width: 560px;
    background: var(--bg-secondary);
    border-radius: var(--radius-xl);
    box-shadow: var(--shadow-xl);
    transform: scale(0.9) translateY(20px);
    transition: transform var(--transition-base);
}

.modal-overlay.active .modal {
    transform: scale(1) translateY(0);
}

.modal-header {
    padding: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid var(--border-color);
}

.modal-header h3 {
    font-size: 1.25rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.modal-header h3 i {
    color: var(--primary);
}

.modal-close {
    width: 36px;
    height: 36px;
    border: none;
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all var(--transition-fast);
}

.modal-close:hover {
    background: var(--danger);
    color: white;
}

.modal-body {
    padding: 24px;
}

.modal-form {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-group label {
    font-size: 0.875rem;
    font-weight: 500;
    color: var(--text-primary);
}

.form-group input,
.form-group select,
.form-group textarea {
    padding: 12px 16px;
    background: var(--bg-tertiary);
    border: 1px solid var(--border-color);
    border-radius: var(--radius-md);
    color: var(--text-primary);
    font-size: 0.875rem;
    transition: all var(--transition-fast);
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-group textarea {
    min-height: 100px;
    resize: vertical;
}

.modal-footer {
    padding: 20px 24px;
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    border-top: 1px solid var(--border-color);
}

/* ===== RESPONSIVE ===== */
@media (max-width: 1400px) {
    .stats-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .teachers-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 1200px) {
    .main-grid {
        grid-template-columns: 1fr;
    }
    
    .right-sidebar {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (max-width: 992px) {
    .sidebar {
        transform: translateX(-100%);
    }
    
    .sidebar.mobile-open {
        transform: translateX(0);
    }
    
    .main-content {
        margin-left: 0;
    }
    
    .mobile-menu-btn {
        display: flex;
    }
    
    .header-center {
        display: none;
    }
    
    .right-sidebar {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .dashboard-content {
        padding: 20px;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
    
    .right-sidebar {
        grid-template-columns: 1fr;
    }
    
    .teachers-grid {
        grid-template-columns: 1fr;
    }
    
    .welcome-section {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .welcome-actions {
        width: 100%;
        flex-direction: column;
    }
    
    .welcome-actions .btn {
        width: 100%;
        justify-content: center;
    }
    
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .table-footer {
        flex-direction: column;
        gap: 16px;
    }
}

/* ===== ANIMATIONS ===== */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideUp {
    from { transform: translateY(20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

.card {
    animation: slideUp 0.5s ease forwards;
}

.stat-card:nth-child(1) { animation-delay: 0.1s; }
.stat-card:nth-child(2) { animation-delay: 0.2s; }
.stat-card:nth-child(3) { animation-delay: 0.3s; }
.stat-card:nth-child(4) { animation-delay: 0.4s; }

/* Scrollbar Styling */
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-track {
    background: var(--bg-tertiary);
}

::-webkit-scrollbar-thumb {
    background: var(--text-muted);
    border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
    background: var(--text-secondary);
}

/* Selection */
::selection {
    background: var(--primary);
    color: white;
}
    </style>
</head>
<body>
    <!-- Sfondo animato -->
    <div class="background-animation">
        <div class="gradient-sphere sphere-1"></div>
        <div class="gradient-sphere sphere-2"></div>
        <div class="gradient-sphere sphere-3"></div>
    </div>
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <span class="logo-text">EduManager</span>
                </div>
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-angles-left"></i>
                </button>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-section">
                    <span class="nav-section-title">Principale</span>
                    <a href="#" class="nav-item active" data-section="dashboard">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="#" class="nav-item" data-section="analytics">
                        <i class="fas fa-chart-pie"></i>
                        <span>Analisi</span>
                    </a>
                </div>
                <div class="nav-section">
                    <span class="nav-section-title">Gestione</span>
                    <a href="#" class="nav-item" data-section="docenti">
                        <i class="fas fa-chalkboard-teacher"></i>
                        <span>Docenti</span>
                        <span class="badge">24</span>
                    </a>
                    <a href="#" class="nav-item" data-section="studenti">
                        <i class="fas fa-user-graduate"></i>
                        <span>Studenti</span>
                        <span class="badge">342</span>
                    </a>
                    <a href="#" class="nav-item" data-section="corsi">
                        <i class="fas fa-book-open"></i>
                        <span>Corsi</span>
                    </a>
                    <a href="#" class="nav-item" data-section="classi">
                        <i class="fas fa-door-open"></i>
                        <span>Classi</span>
                    </a>
                </div>
                <div class="nav-section">
                    <span class="nav-section-title">Sistema</span>
                    <a href="#" class="nav-item" data-section="calendario">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Calendario</span>
                    </a>
                    <a href="#" class="nav-item" data-section="messaggi">
                        <i class="fas fa-envelope"></i>
                        <span>Messaggi</span>
                        <span class="badge pulse">5</span>
                    </a>
                    <a href="#" class="nav-item" data-section="impostazioni">
                        <i class="fas fa-cog"></i>
                        <span>Impostazioni</span>
                    </a>
                </div>
            </nav>
            <div class="sidebar-footer">
                <div class="user-card">
                    <div class="user-avatar">
                        <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Admin+User&background=6366f1&color=fff)" alt="Admin">
                        <span class="status-indicator online"></span>
                    </div>
                    <div class="user-info">
                        <span class="user-name">Marco Rossi</span>
                        <span class="user-role">Amministratore</span>
                    </div>
                    <button class="logout-btn" title="Esci">
                        <i class="fas fa-sign-out-alt"></i>
                    </button>
                </div>
            </div>
        </aside>

        <!-- Contenuto principale -->
        <main class="main-content">
            <!-- Header -->
            <header class="main-header">
                <div class="header-left">
                    <button class="mobile-menu-btn" id="mobileMenuBtn">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="breadcrumb">
                        <span>Home</span>
                        <i class="fas fa-chevron-right"></i>
                        <span class="current">Dashboard</span>
                    </div>
                </div>

                <div class="header-center">
                    <div class="search-container">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Cerca studenti, docenti, corsi..." class="search-input">
                        <kbd class="search-shortcut">⌘K</kbd>
                    </div>
                </div>

                <div class="header-right">
                    <button class="header-btn" title="Notifiche">
                        <i class="fas fa-bell"></i>
                        <span class="notification-dot"></span>
                    </button>
                    <button class="header-btn" title="Tema">
                        <i class="fas fa-moon" id="themeIcon"></i>
                    </button>
                    <button class="header-btn" title="Aiuto">
                        <i class="fas fa-question-circle"></i>
                    </button>
                </div>
            </header>

            <!-- Dashboard Content -->
            <div class="dashboard-content">
                <!-- Welcome Section -->
                <section class="welcome-section">
                    <div class="welcome-text">
                        <h1>Buongiorno, Marco! 👋</h1>
                        <p>Ecco un riepilogo della situazione odierna del tuo istituto.</p>
                    </div>
                    <div class="welcome-actions">
                        <button class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Nuovo Studente
                        </button>
                        <button class="btn btn-secondary">
                            <i class="fas fa-download"></i>
                            Esporta Report
                        </button>
                    </div>
                </section>

                <!-- Stats Cards -->
                <section class="stats-grid">
                    <div class="stat-card" style="--accent: #6366f1">
                        <div class="stat-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="stat-content">
                            <span class="stat-value" data-count="342">0</span>
                            <span class="stat-label">Studenti Totali</span>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>+12%</span>
                        </div>
                        <div class="stat-chart">
                            <svg viewBox="0 0 100 40">
                                <polyline fill="none" stroke="currentColor" stroke-width="2" points="0,35 20,28 40,32 60,20 80,24 100,10"/>
                            </svg>
                        </div>
                    </div>

                    <div class="stat-card" style="--accent: #10b981">
                        <div class="stat-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div class="stat-content">
                            <span class="stat-value" data-count="24">0</span>
                            <span class="stat-label">Docenti Attivi</span>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>+3</span>
                        </div>
                        <div class="stat-chart">
                            <svg viewBox="0 0 100 40">
                                <polyline fill="none" stroke="currentColor" stroke-width="2" points="0,30 25,25 50,28 75,15 100,18"/>
                            </svg>
                        </div>
                    </div>

                    <div class="stat-card" style="--accent: #f59e0b">
                        <div class="stat-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div class="stat-content">
                            <span class="stat-value" data-count="18">0</span>
                            <span class="stat-label">Corsi Attivi</span>
                        </div>
                        <div class="stat-trend neutral">
                            <i class="fas fa-minus"></i>
                            <span>0%</span>
                        </div>
                        <div class="stat-chart">
                            <svg viewBox="0 0 100 40">
                                <polyline fill="none" stroke="currentColor" stroke-width="2" points="0,20 30,22 50,18 70,22 100,20"/>
                            </svg>
                        </div>
                    </div>

                    <div class="stat-card" style="--accent: #ec4899">
                        <div class="stat-icon">
                            <i class="fas fa-percentage"></i>
                        </div>
                        <div class="stat-content">
                            <span class="stat-value" data-count="94">0</span>
                            <span class="stat-label">% Frequenza Media</span>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            <span>+2.5%</span>
                        </div>
                        <div class="stat-chart">
                            <svg viewBox="0 0 100 40">
                                <polyline fill="none" stroke="currentColor" stroke-width="2" points="0,38 20,30 40,35 60,25 80,20 100,12"/>
                            </svg>
                        </div>
                    </div>
                </section>

                <!-- Main Grid -->
                <div class="main-grid">
                    <!-- Tabella Studenti -->
                    <section class="card table-card">
                        <div class="card-header">
                            <div class="card-title">
                                <i class="fas fa-user-graduate"></i>
                                <h2>Studenti Recenti</h2>
                            </div>
                            <div class="card-actions">
                                <div class="filter-group">
                                    <button class="filter-btn active">Tutti</button>
                                    <button class="filter-btn">Attivi</button>
                                    <button class="filter-btn">In Sospeso</button>
                                </div>
                                <button class="btn btn-icon" title="Aggiungi">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>
                                                <label class="checkbox-container">
                                                    <input type="checkbox" id="selectAll">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </th>
                                            <th>Studente</th>
                                            <th>Classe</th>
                                            <th>Media Voti</th>
                                            <th>Frequenza</th>
                                            <th>Stato</th>
                                            <th>Azioni</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <label class="checkbox-container">
                                                    <input type="checkbox">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </td>
                                            <td>
                                                <div class="user-cell">
                                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Giulia+Bianchi&background=random)" alt="">
                                                    <div>
                                                        <span class="name">Giulia Bianchi</span>
                                                        <span class="email">g.bianchi@scuola.it</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="class-badge">3A</span></td>
                                            <td>
                                                <div class="grade-display excellent">
                                                    <span>9.2</span>
                                                    <div class="grade-bar"><div style="width: 92%"></div></div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendance-display">
                                                    <span>98%</span>
                                                    <div class="mini-chart">
                                                        <span style="height: 80%"></span>
                                                        <span style="height: 100%"></span>
                                                        <span style="height: 90%"></span>
                                                        <span style="height: 100%"></span>
                                                        <span style="height: 95%"></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="status-badge active">Attivo</span></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="action-btn" title="Visualizza"><i class="fas fa-eye"></i></button>
                                                    <button class="action-btn" title="Modifica"><i class="fas fa-edit"></i></button>
                                                    <button class="action-btn danger" title="Elimina"><i class="fas fa-trash"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label class="checkbox-container">
                                                    <input type="checkbox">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </td>
                                            <td>
                                                <div class="user-cell">
                                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Luca+Verdi&background=random)" alt="">
                                                    <div>
                                                        <span class="name">Luca Verdi</span>
                                                        <span class="email">l.verdi@scuola.it</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="class-badge">2B</span></td>
                                            <td>
                                                <div class="grade-display good">
                                                    <span>7.8</span>
                                                    <div class="grade-bar"><div style="width: 78%"></div></div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendance-display">
                                                    <span>92%</span>
                                                    <div class="mini-chart">
                                                        <span style="height: 90%"></span>
                                                        <span style="height: 85%"></span>
                                                        <span style="height: 95%"></span>
                                                        <span style="height: 88%"></span>
                                                        <span style="height: 92%"></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="status-badge active">Attivo</span></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="action-btn" title="Visualizza"><i class="fas fa-eye"></i></button>
                                                    <button class="action-btn" title="Modifica"><i class="fas fa-edit"></i></button>
                                                    <button class="action-btn danger" title="Elimina"><i class="fas fa-trash"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label class="checkbox-container">
                                                    <input type="checkbox">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </td>
                                            <td>
                                                <div class="user-cell">
                                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Sofia+Romano&background=random)" alt="">
                                                    <div>
                                                        <span class="name">Sofia Romano</span>
                                                        <span class="email">s.romano@scuola.it</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="class-badge">4C</span></td>
                                            <td>
                                                <div class="grade-display average">
                                                    <span>6.5</span>
                                                    <div class="grade-bar"><div style="width: 65%"></div></div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendance-display">
                                                    <span>85%</span>
                                                    <div class="mini-chart">
                                                        <span style="height: 75%"></span>
                                                        <span style="height: 80%"></span>
                                                        <span style="height: 90%"></span>
                                                        <span style="height: 85%"></span>
                                                        <span style="height: 82%"></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="status-badge warning">Attenzione</span></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="action-btn" title="Visualizza"><i class="fas fa-eye"></i></button>
                                                    <button class="action-btn" title="Modifica"><i class="fas fa-edit"></i></button>
                                                    <button class="action-btn danger" title="Elimina"><i class="fas fa-trash"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label class="checkbox-container">
                                                    <input type="checkbox">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </td>
                                            <td>
                                                <div class="user-cell">
                                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Marco+Ferrari&background=random)" alt="">
                                                    <div>
                                                        <span class="name">Marco Ferrari</span>
                                                        <span class="email">m.ferrari@scuola.it</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="class-badge">5A</span></td>
                                            <td>
                                                <div class="grade-display excellent">
                                                    <span>8.9</span>
                                                    <div class="grade-bar"><div style="width: 89%"></div></div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="attendance-display">
                                                    <span>96%</span>
                                                    <div class="mini-chart">
                                                        <span style="height: 95%"></span>
                                                        <span style="height: 98%"></span>
                                                        <span style="height: 92%"></span>
                                                        <span style="height: 100%"></span>
                                                        <span style="height: 96%"></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><span class="status-badge active">Attivo</span></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="action-btn" title="Visualizza"><i class="fas fa-eye"></i></button>
                                                    <button class="action-btn" title="Modifica"><i class="fas fa-edit"></i></button>
                                                    <button class="action-btn danger" title="Elimina"><i class="fas fa-trash"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table-footer">
                                <span class="showing-info">Mostrando 1-4 di 342 studenti</span>
                                <div class="pagination">
                                    <button class="page-btn" disabled><i class="fas fa-chevron-left"></i></button>
                                    <button class="page-btn active">1</button>
                                    <button class="page-btn">2</button>
                                    <button class="page-btn">3</button>
                                    <span class="page-dots">...</span>
                                    <button class="page-btn">86</button>
                                    <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Sidebar destra -->
                    <aside class="right-sidebar">
                        <!-- Attività Recenti -->
                        <div class="card activity-card">
                            <div class="card-header">
                                <h3><i class="fas fa-clock"></i> Attività Recenti</h3>
                            </div>
                            <div class="card-body">
                                <div class="activity-list">
                                    <div class="activity-item">
                                        <div class="activity-icon add">
                                            <i class="fas fa-user-plus"></i>
                                        </div>
                                        <div class="activity-content">
                                            <p><strong>Nuovo studente</strong> iscritto</p>
                                            <span class="activity-name">Elena Conti — 3B</span>
                                            <span class="activity-time">2 minuti fa</span>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon edit">
                                            <i class="fas fa-edit"></i>
                                        </div>
                                        <div class="activity-content">
                                            <p><strong>Voti aggiornati</strong> per la classe 4A</p>
                                            <span class="activity-name">Prof. Russo — Matematica</span>
                                            <span class="activity-time">15 minuti fa</span>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon alert">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <div class="activity-content">
                                            <p><strong>Assenza segnalata</strong></p>
                                            <span class="activity-name">3 studenti — Classe 2C</span>
                                            <span class="activity-time">1 ora fa</span>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon success">
                                            <i class="fas fa-check-circle"></i>
                                        </div>
                                        <div class="activity-content">
                                            <p><strong>Corso completato</strong></p>
                                            <span class="activity-name">JavaScript Avanzato</span>
                                            <span class="activity-time">3 ore fa</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Calendario Mini -->
                        <div class="card calendar-card">
                            <div class="card-header">
                                <h3><i class="fas fa-calendar"></i> Maggio 2025</h3>
                                <div class="calendar-nav">
                                    <button><i class="fas fa-chevron-left"></i></button>
                                    <button><i class="fas fa-chevron-right"></i></button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="mini-calendar">
                                    <div class="calendar-header">
                                        <span>Lun</span>
                                        <span>Mar</span>
                                        <span>Mer</span>
                                        <span>Gio</span>
                                        <span>Ven</span>
                                        <span>Sab</span>
                                        <span>Dom</span>
                                    </div>
                                    <div class="calendar-days">
                                        <span class="other-month">28</span>
                                        <span class="other-month">29</span>
                                        <span class="other-month">30</span>
                                        <span>1</span>
                                        <span>2</span>
                                        <span class="weekend">3</span>
                                        <span class="weekend">4</span>
                                        <span>5</span>
                                        <span>6</span>
                                        <span>7</span>
                                        <span class="has-event">8</span>
                                        <span>9</span>
                                        <span class="weekend">10</span>
                                        <span class="weekend today">11</span>
                                        <span class="has-event">12</span>
                                        <span>13</span>
                                        <span>14</span>
                                        <span class="has-event">15</span>
                                        <span>16</span>
                                        <span class="weekend">17</span>
                                        <span class="weekend">18</span>
                                        <span>19</span>
                                        <span>20</span>
                                        <span>21</span>
                                        <span>22</span>
                                        <span>23</span>
                                        <span class="weekend">24</span>
                                        <span class="weekend">25</span>
                                        <span>26</span>
                                        <span>27</span>
                                        <span>28</span>
                                        <span>29</span>
                                        <span>30</span>
                                        <span class="weekend">31</span>
                                        <span class="weekend other-month">1</span>
                                    </div>
                                </div>
                                <div class="upcoming-events">
                                    <h4>Prossimi Eventi</h4>
                                    <div class="event-item">
                                        <div class="event-color" style="background: #6366f1"></div>
                                        <div class="event-info">
                                            <span class="event-title">Consiglio di Classe 3A</span>
                                            <span class="event-time">12 Mag, 15:00</span>
                                        </div>
                                    </div>
                                    <div class="event-item">
                                        <div class="event-color" style="background: #10b981"></div>
                                        <div class="event-info">
                                            <span class="event-title">Esame di Stato — Simulazione</span>
                                            <span class="event-time">15 Mag, 08:30</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="card quick-actions-card">
                            <div class="card-header">
                                <h3><i class="fas fa-bolt"></i> Azioni Rapide</h3>
                            </div>
                            <div class="card-body">
                                <div class="quick-actions-grid">
                                    <button class="quick-action">
                                        <i class="fas fa-user-plus"></i>
                                        <span>Aggiungi Studente</span>
                                    </button>
                                    <button class="quick-action">
                                        <i class="fas fa-chalkboard"></i>
                                        <span>Nuovo Corso</span>
                                    </button>
                                    <button class="quick-action">
                                        <i class="fas fa-file-export"></i>
                                        <span>Esporta Dati</span>
                                    </button>
                                    <button class="quick-action">
                                        <i class="fas fa-paper-plane"></i>
                                        <span>Invia Notifica</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </aside>
                </div>

                <!-- Sezione Docenti -->
                <section class="card teachers-section">
                    <div class="card-header">
                        <div class="card-title">
                            <i class="fas fa-chalkboard-teacher"></i>
                            <h2>Staff Docenti</h2>
                        </div>
                        <button class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Aggiungi Docente
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="teachers-grid">
                            <div class="teacher-card">
                                <div class="teacher-header">
                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Anna+Russo&background=6366f1&color=fff&size=80)" alt="Anna Russo">
                                    <span class="teacher-status online"></span>
                                </div>
                                <div class="teacher-info">
                                    <h4>Prof.ssa Anna Russo</h4>
                                    <span class="teacher-subject">Matematica</span>
                                    <div class="teacher-stats">
                                        <div class="teacher-stat">
                                            <i class="fas fa-users"></i>
                                            <span>86 studenti</span>
                                        </div>
                                        <div class="teacher-stat">
                                            <i class="fas fa-star"></i>
                                            <span>4.9</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="teacher-actions">
                                    <button class="btn btn-ghost"><i class="fas fa-envelope"></i></button>
                                    <button class="btn btn-ghost"><i class="fas fa-eye"></i></button>
                                </div>
                            </div>

                            <div class="teacher-card">
                                <div class="teacher-header">
                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Giovanni+Esposito&background=10b981&color=fff&size=80)" alt="Giovanni Esposito">
                                    <span class="teacher-status online"></span>
                                </div>
                                <div class="teacher-info">
                                    <h4>Prof. Giovanni Esposito</h4>
                                    <span class="teacher-subject">Italiano</span>
                                    <div class="teacher-stats">
                                        <div class="teacher-stat">
                                            <i class="fas fa-users"></i>
                                            <span>72 studenti</span>
                                        </div>
                                        <div class="teacher-stat">
                                            <i class="fas fa-star"></i>
                                            <span>4.8</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="teacher-actions">
                                    <button class="btn btn-ghost"><i class="fas fa-envelope"></i></button>
                                    <button class="btn btn-ghost"><i class="fas fa-eye"></i></button>
                                </div>
                            </div>

                            <div class="teacher-card">
                                <div class="teacher-header">
                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Laura+Colombo&background=f59e0b&color=fff&size=80)" alt="Laura Colombo">
                                    <span class="teacher-status away"></span>
                                </div>
                                <div class="teacher-info">
                                    <h4>Prof.ssa Laura Colombo</h4>
                                    <span class="teacher-subject">Inglese</span>
                                    <div class="teacher-stats">
                                        <div class="teacher-stat">
                                            <i class="fas fa-users"></i>
                                            <span>94 studenti</span>
                                        </div>
                                        <div class="teacher-stat">
                                            <i class="fas fa-star"></i>
                                            <span>4.7</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="teacher-actions">
                                    <button class="btn btn-ghost"><i class="fas fa-envelope"></i></button>
                                    <button class="btn btn-ghost"><i class="fas fa-eye"></i></button>
                                </div>
                            </div>

                            <div class="teacher-card">
                                <div class="teacher-header">
                                    <img src="[ui-avatars.com](https://ui-avatars.com/api/?name=Roberto+Ricci&background=ec4899&color=fff&size=80)" alt="Roberto Ricci">
                                    <span class="teacher-status offline"></span>
                                </div>
                                <div class="teacher-info">
                                    <h4>Prof. Roberto Ricci</h4>
                                    <span class="teacher-subject">Scienze</span>
                                    <div class="teacher-stats">
                                        <div class="teacher-stat">
                                            <i class="fas fa-users"></i>
                                            <span>68 studenti</span>
                                        </div>
                                        <div class="teacher-stat">
                                            <i class="fas fa-star"></i>
                                            <span>4.6</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="teacher-actions">
                                    <button class="btn btn-ghost"><i class="fas fa-envelope"></i></button>
                                    <button class="btn btn-ghost"><i class="fas fa-eye"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>

    <!-- Modal per nuovo studente/docente -->
    <div class="modal-overlay" id="modalOverlay">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-user-plus"></i> Aggiungi Nuovo Studente</h3>
                <button class="modal-close" id="modalClose">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <form class="modal-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Nome</label>
                            <input type="text" placeholder="Inserisci nome">
                        </div>
                        <div class="form-group">
                            <label>Cognome</label>
                            <input type="text" placeholder="Inserisci cognome">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" placeholder="email@scuola.it">
                        </div>
                        <div class="form-group">
                            <label>Classe</label>
                            <select>
                                <option>Seleziona classe</option>
                                <option>1A</option>
                                <option>1B</option>
                                <option>2A</option>
                                <option>2B</option>
                                <option>3A</option>
                                <option>3B</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Note</label>
                        <textarea placeholder="Note aggiuntive..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" id="modalCancel">Annulla</button>
                <button class="btn btn-primary">
                    <i class="fas fa-check"></i>
                    Salva Studente
                </button>
            </div>
        </div>
    </div>

    <script>// ===== DOM Elements =====
    const sidebar = document.getElementById('sidebar');
    const sidebarToggle = document.getElementById('sidebarToggle');
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const themeIcon = document.getElementById('themeIcon');
    const modalOverlay = document.getElementById('modalOverlay');
    const modalClose = document.getElementById('modalClose');
    const modalCancel = document.getElementById('modalCancel');
    const navItems = document.querySelectorAll('.nav-item');
    const statValues = document.querySelectorAll('.stat-value');

    // ===== Sidebar Toggle =====
    sidebarToggle?.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
    });

    // Load sidebar state
    if (localStorage.getItem('sidebarCollapsed') === 'true') {
        sidebar.classList.add('collapsed');
    }

    // Mobile menu
    mobileMenuBtn?.addEventListener('click', () => {
        sidebar.classList.toggle('mobile-open');
    });

    // Close sidebar on outside click (mobile)
    document.addEventListener('click', (e) => {
        if (window.innerWidth <= 992) {
            if (!sidebar.contains(e.target) && !mobileMenuBtn.contains(e.target)) {
                sidebar.classList.remove('mobile-open');
            }
        }
    });

    // ===== Theme Toggle =====
    const toggleTheme = () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        themeIcon.className = newTheme === 'light' ? 'fas fa-sun' : 'fas fa-moon';
    };

    // Initialize theme
    const savedTheme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);
    if (themeIcon) {
        themeIcon.className = savedTheme === 'light' ? 'fas fa-sun' : 'fas fa-moon';
    }

    themeIcon?.parentElement.addEventListener('click', toggleTheme);

    // ===== Navigation =====
    navItems.forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            navItems.forEach(nav => nav.classList.remove('active'));
            item.classList.add('active');
            
            // Update breadcrumb
            const sectionName = item.querySelector('span')?.textContent || 'Dashboard';
            document.querySelector('.breadcrumb .current').textContent = sectionName;
            
            // Close mobile menu
            if (window.innerWidth <= 992) {
                sidebar.classList.remove('mobile-open');
            }
        });
    });

    // ===== Modal =====
    const openModal = () => {
        modalOverlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    };

    const closeModal = () => {
        modalOverlay.classList.remove('active');
        document.body.style.overflow = '';
    };

    // Modal triggers
    document.querySelectorAll('.btn-primary').forEach(btn => {
        if (btn.textContent.includes('Nuovo Studente') || btn.textContent.includes('Aggiungi')) {
            btn.addEventListener('click', openModal);
        }
    });

    modalClose?.addEventListener('click', closeModal);
    modalCancel?.addEventListener('click', closeModal);
    modalOverlay?.addEventListener('click', (e) => {
        if (e.target === modalOverlay) closeModal();
    });

    // Close on Escape
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeModal();
    });

    // ===== Animated Counters =====
    const animateCounter = (element) => {
        const target = parseInt(element.dataset.count);
        const duration = 1500;
        const step = target / (duration / 16);
        let current = 0;
        
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                element.textContent = target;
                clearInterval(timer);
            } else {
                element.textContent = Math.floor(current);
            }
        }, 16);
    };

    // Intersection Observer for counters
    const observerOptions = {
        threshold: 0.5,
        rootMargin: '0px'
    };

    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                counterObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    statValues.forEach(value => counterObserver.observe(value));

    // ===== Search Shortcut =====
    document.addEventListener('keydown', (e) => {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
            e.preventDefault();
            document.querySelector('.search-input')?.focus();
        }
    });

    // ===== Table Select All =====
    const selectAll = document.getElementById('selectAll');
    const rowCheckboxes = document.querySelectorAll('.data-table tbody .checkbox-container input');

    selectAll?.addEventListener('change', () => {
        rowCheckboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
    });

    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', () => {
            const allChecked = [...rowCheckboxes].every(cb => cb.checked);
            const someChecked = [...rowCheckboxes].some(cb => cb.checked);
            selectAll.checked = allChecked;
            selectAll.indeterminate = someChecked && !allChecked;
        });
    });

    // ===== Quick Actions =====
    document.querySelectorAll('.quick-action').forEach(action => {
        action.addEventListener('click', () => {
            const actionName = action.querySelector('span').textContent;
            
            switch(actionName) {
                case 'Aggiungi Studente':
                    openModal();
                    break;
                case 'Esporta Dati':
                    alert('Esportazione dati in corso...');
                    break;
                case 'Invia Notifica':
                    alert('Apertura composizione notifica...');
                    break;
                default:
                    console.log('Azione:', actionName);
            }
        });
    });

    // ===== Filter Buttons =====
    document.querySelectorAll('.filter-group').forEach(group => {
        const buttons = group.querySelectorAll('.filter-btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', () => {
                buttons.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });
    });

    // ===== Tooltips (simple implementation) =====
    document.querySelectorAll('[title]').forEach(el => {
        el.addEventListener('mouseenter', function() {
            this.dataset.title = this.title;
            this.removeAttribute('title');
        });
        
        el.addEventListener('mouseleave', function() {
            if (this.dataset.title) {
                this.title = this.dataset.title;
            }
        });
    });

    // ===== Initialize =====
    console.log('🎓 EduManager Dashboard initialized');
</script>
</body>
</html>

