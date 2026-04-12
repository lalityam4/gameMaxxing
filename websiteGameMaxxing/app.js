/* ============================================================
   GameMaxxing Web — Main App (SPA)
   ============================================================ */

// ── State ─────────────────────────────────────────────────

const state = {
  view: 'home',          // 'home' | 'category' | 'game' | 'add' | 'edit'
  catId: null,
  gameId: null,
  searchQuery: '',
  catTab: 'library',     // 'library' | 'custom'
  catFilter: 'all',      // 'all' | 'drinking' | 'noDrinking'
  editGameId: null,
};

// ── Storage ───────────────────────────────────────────────

const STORAGE_KEY = 'gamemaxxing_custom_games';

function loadCustomGames() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
  } catch { return []; }
}

function saveCustomGames(games) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(games));
}

// ── Theme ─────────────────────────────────────────────────

const THEMES = [
  { id: 'retro',  label: 'Retro',  swatch: '#C04B1A', bg: '#FAF4EA' },
  { id: 'dark',   label: 'Dark',   swatch: '#F78166', bg: '#0D1117' },
  { id: 'neon',   label: 'Neon',   swatch: '#00FF9D', bg: '#08080F' },
  { id: 'forest', label: 'Forest', swatch: '#2E7D32', bg: '#F0F4EE' },
  { id: 'ocean',  label: 'Ocean',  swatch: '#0066CC', bg: '#E8F4FD' },
];

function getTheme() {
  return localStorage.getItem('gamemaxxing_theme') || 'retro';
}

function setTheme(id) {
  document.documentElement.setAttribute('data-theme', id);
  localStorage.setItem('gamemaxxing_theme', id);
  renderThemeOptions();
}

// ── Helpers ───────────────────────────────────────────────

function getCategoryById(id) {
  return CATEGORIES.find(c => c.id === id);
}

function getGameById(id) {
  const lib = LIBRARY_GAMES.find(g => g.id === id);
  if (lib) return lib;
  return loadCustomGames().find(g => g.id === id);
}

function getGamesForCategory(catId) {
  const custom = loadCustomGames().filter(g => g.categoryId === catId);
  const library = LIBRARY_GAMES.filter(g => g.categoryId === catId);
  return { library, custom };
}

function playersDisplay(min, max) {
  if (max >= 99) return `${min}+`;
  if (min === max) return `${min}`;
  return `${min}–${max}`;
}

function generateId() {
  return 'custom_' + Date.now() + '_' + Math.random().toString(36).slice(2, 7);
}

// ── Navigation ────────────────────────────────────────────

function navigate(view, params = {}) {
  state.view = view;
  Object.assign(state, params);
  render();
  window.scrollTo(0, 0);
}

// ── Rendering root ────────────────────────────────────────

function render() {
  const main = document.getElementById('main');
  const headerBack = document.getElementById('headerBack');
  const headerTitle = document.getElementById('headerTitle');
  const addBtn = document.getElementById('addGameBtn');

  // Header back button
  headerBack.classList.remove('visible');
  addBtn.style.display = 'flex';

  switch (state.view) {
    case 'home':
      headerTitle.textContent = 'GameMaxxing';
      addBtn.style.display = 'flex';
      main.innerHTML = renderHome();
      attachHomeEvents();
      break;
    case 'category':
      const cat = getCategoryById(state.catId);
      headerTitle.textContent = cat ? `${cat.emoji} ${cat.name}` : 'Category';
      headerBack.classList.add('visible');
      addBtn.style.display = 'flex';
      main.innerHTML = renderCategory(state.catId);
      attachCategoryEvents();
      break;
    case 'game':
      const game = getGameById(state.gameId);
      headerTitle.textContent = game ? game.name : 'Game';
      headerBack.classList.add('visible');
      addBtn.style.display = 'none';
      main.innerHTML = renderGameDetail(state.gameId);
      attachGameDetailEvents();
      break;
    case 'add':
      headerTitle.textContent = 'Add Game';
      headerBack.classList.add('visible');
      addBtn.style.display = 'none';
      main.innerHTML = renderGameForm(null);
      attachFormEvents();
      break;
    case 'edit':
      headerTitle.textContent = 'Edit Game';
      headerBack.classList.add('visible');
      addBtn.style.display = 'none';
      main.innerHTML = renderGameForm(state.editGameId);
      attachFormEvents();
      break;
    case 'search':
      headerTitle.textContent = 'Search';
      headerBack.classList.add('visible');
      addBtn.style.display = 'none';
      main.innerHTML = renderSearchResults(state.searchQuery);
      attachSearchResultsEvents();
      break;
  }
}

// ── Home view ─────────────────────────────────────────────

function renderHome() {
  const custom = loadCustomGames();
  const recent = [...LIBRARY_GAMES, ...custom].slice(-5).reverse();

  let html = `<div class="app-shell pt-4">`;

  // Search bar
  html += `
    <div class="search-wrap">
      <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
      </svg>
      <input type="search" id="searchInput" class="search-input" placeholder="Search games..." autocomplete="off"
        value="${escHtml(state.searchQuery)}">
      <button id="searchClear" class="search-clear ${state.searchQuery ? 'visible' : ''}">✕</button>
    </div>
  `;

  // Categories
  html += `<div class="section-header"><span class="section-header-text">Categories</span><div class="section-divider"></div></div>`;
  html += `<div class="category-grid">`;
  for (const cat of CATEGORIES) {
    const { library, custom: cust } = getGamesForCategory(cat.id);
    const count = library.length + cust.length;
    html += `
      <div class="category-card" data-cat-id="${cat.id}">
        <span class="category-emoji">${cat.emoji}</span>
        <div class="category-info">
          <div class="category-name">${escHtml(cat.name)}</div>
          <div class="category-count">${count} game${count !== 1 ? 's' : ''}</div>
        </div>
      </div>
    `;
  }
  html += `</div>`;

  // Recent custom games
  if (custom.length > 0) {
    const recentCustom = [...custom].reverse().slice(0, 5);
    html += `<div class="section-header"><span class="section-header-text">My Games</span><div class="section-divider"></div></div>`;
    html += `<div class="recent-list">`;
    for (const game of recentCustom) {
      html += renderGameRowHtml(game);
    }
    html += `</div>`;
  }

  html += `<div style="height: 32px;"></div></div>`;
  return html;
}

function attachHomeEvents() {
  // Search
  const searchInput = document.getElementById('searchInput');
  const searchClear = document.getElementById('searchClear');

  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      const q = e.target.value.trim();
      state.searchQuery = q;
      if (searchClear) searchClear.classList.toggle('visible', q.length > 0);
      if (q.length >= 1) {
        state.view = 'search';
        render();
      }
    });
    if (state.searchQuery) {
      setTimeout(() => { searchInput.focus(); searchInput.setSelectionRange(99, 99); }, 0);
    }
  }

  if (searchClear) {
    searchClear.addEventListener('click', () => {
      state.searchQuery = '';
      navigate('home');
    });
  }

  // Category cards
  document.querySelectorAll('.category-card').forEach(el => {
    el.addEventListener('click', () => {
      navigate('category', { catId: el.dataset.catId, catTab: 'library', catFilter: 'all' });
    });
  });

  // Game rows
  attachGameRowEvents();
}

// ── Category view ─────────────────────────────────────────

function renderCategory(catId) {
  const cat = getCategoryById(catId);
  if (!cat) return '<p>Category not found.</p>';

  const { library, custom } = getGamesForCategory(catId);
  const allGames = [...library, ...custom];
  const hasAnyDrinking = allGames.some(g => g.isDrinking);

  let html = `<div class="app-shell">`;

  // Hero
  html += `
    <div class="cat-hero">
      <span class="cat-hero-emoji">${cat.emoji}</span>
      <div>
        <div class="cat-hero-name">${escHtml(cat.name)}</div>
        <div class="cat-hero-count">${allGames.length} game${allGames.length !== 1 ? 's' : ''}</div>
      </div>
    </div>
  `;

  // Tabs
  html += `
    <div class="tab-bar">
      <button class="tab-btn ${state.catTab === 'library' ? 'active' : ''}" data-tab="library">
        Library (${library.length})
      </button>
      <button class="tab-btn ${state.catTab === 'custom' ? 'active' : ''}" data-tab="custom">
        My Games (${custom.length})
      </button>
    </div>
  `;

  // Drink filter (only if applicable)
  let gamesToShow = state.catTab === 'library' ? library : custom;

  if (hasAnyDrinking && state.catTab === 'library') {
    html += `
      <div class="filter-chips">
        <button class="filter-chip ${state.catFilter === 'all' ? 'active' : ''}" data-filter="all">All</button>
        <button class="filter-chip ${state.catFilter === 'drinking' ? 'active' : ''}" data-filter="drinking">🍺 Drinking</button>
        <button class="filter-chip ${state.catFilter === 'noDrinking' ? 'active' : ''}" data-filter="noDrinking">Non-Drinking</button>
      </div>
    `;
    if (state.catFilter === 'drinking') gamesToShow = gamesToShow.filter(g => g.isDrinking);
    if (state.catFilter === 'noDrinking') gamesToShow = gamesToShow.filter(g => !g.isDrinking);
  }

  // Games list
  if (gamesToShow.length === 0) {
    html += `
      <div class="empty-state">
        <div class="empty-state-emoji">${state.catTab === 'custom' ? '✏️' : cat.emoji}</div>
        <div class="empty-state-title">${state.catTab === 'custom' ? 'No custom games yet' : 'No games found'}</div>
        <div class="empty-state-text">${state.catTab === 'custom' ? 'Tap + Add Game to create your own.' : 'Try a different filter.'}</div>
      </div>
    `;
  } else {
    html += `<div class="cat-games-list">`;
    for (const game of gamesToShow) {
      html += renderGameRowHtml(game);
    }
    html += `</div>`;
  }

  html += `<div style="height: 32px;"></div></div>`;
  return html;
}

function attachCategoryEvents() {
  // Tabs
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      state.catTab = btn.dataset.tab;
      state.catFilter = 'all';
      render();
    });
  });

  // Filters
  document.querySelectorAll('.filter-chip').forEach(chip => {
    chip.addEventListener('click', () => {
      state.catFilter = chip.dataset.filter;
      render();
    });
  });

  attachGameRowEvents();
}

// ── Game row HTML helper ──────────────────────────────────

function renderGameRowHtml(game) {
  const badges = [];
  if (game.isDrinking) badges.push(`<span class="badge badge-drink">🍺 Drinking</span>`);
  if (!game.isLibrary) badges.push(`<span class="badge badge-custom">Custom</span>`);
  badges.push(`<span class="badge badge-difficulty">${escHtml(game.difficulty)}</span>`);

  return `
    <div class="game-row" data-game-id="${game.id}" style="margin-bottom: 8px;">
      <div class="game-row-info">
        <div class="game-row-name">${escHtml(game.name)}</div>
        <div class="game-row-meta">${playersDisplay(game.minPlayers, game.maxPlayers)} players · ${escHtml(game.duration)}</div>
      </div>
      <div class="game-row-badges">${badges.join('')}</div>
      <svg class="chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
        <path d="m9 18 6-6-6-6"/>
      </svg>
    </div>
  `;
}

function attachGameRowEvents() {
  document.querySelectorAll('.game-row').forEach(el => {
    el.addEventListener('click', () => {
      navigate('game', { gameId: el.dataset.gameId });
    });
  });
}

// ── Game detail view ──────────────────────────────────────

function renderGameDetail(gameId) {
  const game = getGameById(gameId);
  if (!game) return '<p>Game not found.</p>';

  const cat = getCategoryById(game.categoryId);

  let html = `<div class="app-shell game-detail">`;

  html += `<div class="game-detail-header">`;
  html += `<div class="game-detail-cat">${cat ? `${cat.emoji} ${cat.name}` : ''}</div>`;
  html += `<div class="game-detail-name">${escHtml(game.name)}</div>`;
  html += `<div class="game-detail-name-underline"></div>`;
  if (game.isDrinking) html += `<span class="badge badge-drink" style="display:inline-flex;margin-bottom:10px;">🍺 Drinking Game</span>`;
  html += `<div class="game-detail-desc">${escHtml(game.description)}</div>`;
  html += `</div>`;

  // Info chips
  html += `<div class="info-chips">`;
  html += infoChip('👥', 'Players', playersDisplay(game.minPlayers, game.maxPlayers));
  html += infoChip('⏱', 'Duration', game.duration);
  html += infoChip('⚡', 'Difficulty', game.difficulty);
  html += `</div>`;

  // Actions (edit/delete for custom games)
  if (!game.isLibrary) {
    html += `
      <div class="game-actions">
        <button class="btn btn-outline" id="editGameBtn">✏️ Edit</button>
        <button class="btn btn-danger" id="deleteGameBtn">🗑 Delete</button>
      </div>
    `;
  }

  // What You Need
  html += sectionHeader('What You Need');
  html += `<ul class="needs-list">`;
  for (const item of game.whatYouNeed) {
    html += `<li class="needs-item"><span class="needs-bullet">—</span><span>${escHtml(item)}</span></li>`;
  }
  html += `</ul>`;

  // How to Play
  html += sectionHeader('How to Play');
  html += `<div class="steps-list">`;
  for (const step of game.steps) {
    html += `
      <div class="step-card">
        <div class="step-num">${step.num}</div>
        <div class="step-content">
          <div class="step-title">${escHtml(step.title)}</div>
          <div class="step-desc">${escHtml(step.desc)}</div>
        </div>
      </div>
    `;
  }
  html += `</div>`;

  html += `<div style="height: 32px;"></div></div>`;
  return html;
}

function attachGameDetailEvents() {
  const editBtn = document.getElementById('editGameBtn');
  const deleteBtn = document.getElementById('deleteGameBtn');
  if (editBtn) {
    editBtn.addEventListener('click', () => {
      navigate('edit', { editGameId: state.gameId });
    });
  }
  if (deleteBtn) {
    deleteBtn.addEventListener('click', () => {
      showConfirmModal(
        'Delete Game',
        'Are you sure you want to delete this game? This cannot be undone.',
        () => {
          const games = loadCustomGames().filter(g => g.id !== state.gameId);
          saveCustomGames(games);
          showToast('Game deleted');
          navigate('home');
        }
      );
    });
  }
}

function infoChip(icon, label, value) {
  return `
    <div class="info-chip">
      <span class="info-chip-label">${label}</span>
      <span class="info-chip-value"><span class="info-chip-icon">${icon}</span> ${escHtml(value)}</span>
    </div>
  `;
}

function sectionHeader(text) {
  return `
    <div class="section-header">
      <span class="section-header-text">${text}</span>
      <div class="section-divider"></div>
    </div>
  `;
}

// ── Add / Edit form ───────────────────────────────────────

let formSteps = [];
let formNeeds = [];

function renderGameForm(editId) {
  const existing = editId ? getGameById(editId) : null;

  // Initialize form state
  if (existing) {
    formSteps = existing.steps.map(s => ({ ...s }));
    formNeeds = [...existing.whatYouNeed];
  } else {
    formSteps = [{ num: 1, title: '', desc: '' }];
    formNeeds = [''];
  }

  const name = existing ? existing.name : '';
  const desc = existing ? existing.description : '';
  const dur  = existing ? existing.duration : '';
  const diff = existing ? existing.difficulty : 'Easy';
  const minP = existing ? existing.minPlayers : 2;
  const maxP = existing ? existing.maxPlayers : 6;
  const isDrink = existing ? existing.isDrinking : false;
  const catId = existing ? existing.categoryId : CATEGORIES[0].id;

  let html = `<div class="app-shell form-view">`;

  html += `<div class="section-header" style="padding-top:16px;"><span class="section-header-text">Basic Info</span><div class="section-divider"></div></div>`;

  // Name
  html += `<div class="form-field">
    <label class="form-label" for="fName">Game Name *</label>
    <input type="text" id="fName" placeholder="e.g. My Awesome Game" value="${escHtml(name)}">
  </div>`;

  // Category
  html += `<div class="form-field">
    <label class="form-label" for="fCat">Category</label>
    <select id="fCat">`;
  for (const c of CATEGORIES) {
    html += `<option value="${c.id}" ${c.id === catId ? 'selected' : ''}>${c.emoji} ${escHtml(c.name)}</option>`;
  }
  html += `</select></div>`;

  // Description
  html += `<div class="form-field">
    <label class="form-label" for="fDesc">Description</label>
    <textarea id="fDesc" class="form-textarea" placeholder="What is this game about?">${escHtml(desc)}</textarea>
  </div>`;

  // Duration
  html += `<div class="form-field">
    <label class="form-label" for="fDur">Duration</label>
    <input type="text" id="fDur" placeholder='e.g. "15–30 min"' value="${escHtml(dur)}">
  </div>`;

  // Difficulty
  html += `<div class="form-field">
    <label class="form-label">Difficulty</label>
    <div class="seg-control">
      <button class="seg-btn ${diff === 'Easy' ? 'active' : ''}" data-diff="Easy">Easy</button>
      <button class="seg-btn ${diff === 'Medium' ? 'active' : ''}" data-diff="Medium">Medium</button>
      <button class="seg-btn ${diff === 'Hard' ? 'active' : ''}" data-diff="Hard">Hard</button>
    </div>
  </div>`;

  // Players
  html += `<div class="section-header"><span class="section-header-text">Players</span><div class="section-divider"></div></div>`;
  html += `<div class="form-row">
    <div class="form-field">
      <label class="form-label" for="fMinP">Min Players</label>
      <input type="number" id="fMinP" min="1" max="50" value="${minP}">
    </div>
    <div class="form-field">
      <label class="form-label" for="fMaxP">Max Players</label>
      <input type="number" id="fMaxP" min="1" max="99" value="${maxP}">
      <div style="margin-top:6px;display:flex;align-items:center;gap:8px;">
        <input type="checkbox" id="fUnlimited" ${maxP >= 99 ? 'checked' : ''} style="width:auto;">
        <label class="form-label" for="fUnlimited" style="margin:0;cursor:pointer;">No upper limit</label>
      </div>
    </div>
  </div>`;

  // Drinking game
  html += `<div class="form-field" style="display:flex;align-items:center;gap:10px;">
    <input type="checkbox" id="fDrink" ${isDrink ? 'checked' : ''} style="width:auto;">
    <label class="form-label" for="fDrink" style="margin:0;cursor:pointer;">🍺 Drinking game</label>
  </div>`;

  // What You Need
  html += `<div class="section-header"><span class="section-header-text">What You Need</span><div class="section-divider"></div></div>`;
  html += `<div id="needsList" class="dynamic-list">`;
  for (let i = 0; i < formNeeds.length; i++) {
    html += renderNeedItem(i, formNeeds[i]);
  }
  html += `</div>`;
  html += `<button class="btn-add-item" id="addNeedBtn">+ Add item</button>`;

  // Steps
  html += `<div class="section-header"><span class="section-header-text">How to Play</span><div class="section-divider"></div></div>`;
  html += `<div id="stepsList">`;
  for (let i = 0; i < formSteps.length; i++) {
    html += renderStepFormCard(i, formSteps[i]);
  }
  html += `</div>`;
  html += `<button class="btn-add-item" id="addStepBtn">+ Add step</button>`;

  html += `<div style="height: 100px;"></div></div>`;

  // Sticky submit
  html += `
    <div class="form-submit-bar">
      <button class="btn btn-outline" id="formCancelBtn">Cancel</button>
      <button class="btn-submit" id="formSaveBtn">${existing ? 'Save Changes' : 'Add Game'}</button>
    </div>
  `;

  return html;
}

function renderNeedItem(i, value) {
  return `
    <div class="dynamic-item" data-need-idx="${i}">
      <input type="text" class="need-input" placeholder="e.g. Standard 52-card deck" value="${escHtml(value)}">
      <button class="dynamic-item-remove need-remove" data-idx="${i}">✕</button>
    </div>
  `;
}

function renderStepFormCard(i, step) {
  return `
    <div class="step-form-card" data-step-idx="${i}">
      <div class="step-form-header">
        <span class="step-form-num">Step ${i + 1}</span>
        <button class="step-form-remove step-remove" data-idx="${i}">Remove</button>
      </div>
      <div class="form-field">
        <label class="form-label">Title</label>
        <input type="text" class="step-title-input" placeholder='e.g. "Set up"' value="${escHtml(step.title)}">
      </div>
      <div class="form-field">
        <label class="form-label">Description</label>
        <textarea class="step-desc-input form-textarea" placeholder="Describe this step...">${escHtml(step.desc)}</textarea>
      </div>
    </div>
  `;
}

function attachFormEvents() {
  let selectedDiff = document.querySelector('.seg-btn.active')?.dataset.diff || 'Easy';

  // Difficulty seg control
  document.querySelectorAll('.seg-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.seg-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      selectedDiff = btn.dataset.diff;
    });
  });

  // Unlimited toggle
  const unlimitedCheck = document.getElementById('fUnlimited');
  const maxPInput = document.getElementById('fMaxP');
  if (unlimitedCheck && maxPInput) {
    unlimitedCheck.addEventListener('change', () => {
      maxPInput.disabled = unlimitedCheck.checked;
      if (unlimitedCheck.checked) maxPInput.value = 99;
    });
    if (unlimitedCheck.checked) maxPInput.disabled = true;
  }

  // Add need item
  document.getElementById('addNeedBtn')?.addEventListener('click', () => {
    formNeeds.push('');
    const list = document.getElementById('needsList');
    const div = document.createElement('div');
    div.innerHTML = renderNeedItem(formNeeds.length - 1, '');
    list.appendChild(div.firstElementChild);
    attachNeedEvents();
    attachStepEvents();
  });

  // Add step
  document.getElementById('addStepBtn')?.addEventListener('click', () => {
    formSteps.push({ num: formSteps.length + 1, title: '', desc: '' });
    const list = document.getElementById('stepsList');
    const div = document.createElement('div');
    div.innerHTML = renderStepFormCard(formSteps.length - 1, formSteps[formSteps.length - 1]);
    list.appendChild(div.firstElementChild);
    attachNeedEvents();
    attachStepEvents();
  });

  attachNeedEvents();
  attachStepEvents();

  // Cancel
  document.getElementById('formCancelBtn')?.addEventListener('click', () => {
    history.back();
    setTimeout(() => {
      if (state.view === 'add' || state.view === 'edit') navigate('home');
    }, 50);
  });

  // Save
  document.getElementById('formSaveBtn')?.addEventListener('click', () => {
    saveForm(selectedDiff);
  });
}

function attachNeedEvents() {
  document.querySelectorAll('.need-remove').forEach(btn => {
    btn.replaceWith(btn.cloneNode(true)); // remove old listener
  });
  document.querySelectorAll('.need-remove').forEach(btn => {
    btn.addEventListener('click', () => {
      const idx = parseInt(btn.dataset.idx);
      formNeeds.splice(idx, 1);
      if (formNeeds.length === 0) formNeeds.push('');
      rebuildNeedsList();
    });
  });
}

function attachStepEvents() {
  document.querySelectorAll('.step-remove').forEach(btn => {
    btn.replaceWith(btn.cloneNode(true));
  });
  document.querySelectorAll('.step-remove').forEach(btn => {
    btn.addEventListener('click', () => {
      const idx = parseInt(btn.dataset.idx);
      if (formSteps.length === 1) return;
      formSteps.splice(idx, 1);
      rebuildStepsList();
    });
  });
}

function rebuildNeedsList() {
  const list = document.getElementById('needsList');
  list.innerHTML = formNeeds.map((v, i) => renderNeedItem(i, v)).join('');
  attachNeedEvents();
}

function rebuildStepsList() {
  const list = document.getElementById('stepsList');
  list.innerHTML = formSteps.map((s, i) => renderStepFormCard(i, s)).join('');
  attachNeedEvents();
  attachStepEvents();
}

function saveForm(diff) {
  const name = document.getElementById('fName')?.value.trim();
  if (!name) { showToast('Please enter a game name'); return; }

  // Collect needs
  const needs = [];
  document.querySelectorAll('.need-input').forEach(inp => {
    const v = inp.value.trim();
    if (v) needs.push(v);
  });

  // Collect steps
  const steps = [];
  document.querySelectorAll('.step-form-card').forEach((card, i) => {
    const title = card.querySelector('.step-title-input')?.value.trim() || '';
    const desc = card.querySelector('.step-desc-input')?.value.trim() || '';
    if (title || desc) steps.push({ num: i + 1, title, desc });
  });
  if (steps.length === 0) { showToast('Add at least one step'); return; }

  const maxPVal = document.getElementById('fUnlimited')?.checked ? 99 :
    parseInt(document.getElementById('fMaxP')?.value) || 6;

  const game = {
    id: state.view === 'edit' ? state.editGameId : generateId(),
    name,
    categoryId: document.getElementById('fCat')?.value || CATEGORIES[0].id,
    description: document.getElementById('fDesc')?.value.trim() || '',
    duration: document.getElementById('fDur')?.value.trim() || 'Varies',
    difficulty: diff,
    minPlayers: parseInt(document.getElementById('fMinP')?.value) || 2,
    maxPlayers: maxPVal,
    isDrinking: document.getElementById('fDrink')?.checked || false,
    whatYouNeed: needs.length ? needs : ['Nothing required'],
    steps,
    isLibrary: false,
  };

  const allGames = loadCustomGames().filter(g => g.id !== game.id);
  allGames.push(game);
  saveCustomGames(allGames);

  showToast(state.view === 'edit' ? 'Game updated!' : 'Game added!');
  navigate('game', { gameId: game.id });
}

// ── Search results view ───────────────────────────────────

function renderSearchResults(query) {
  const q = query.toLowerCase();
  const allGames = [...LIBRARY_GAMES, ...loadCustomGames()];
  const results = allGames.filter(g =>
    g.name.toLowerCase().includes(q) ||
    g.description.toLowerCase().includes(q) ||
    g.steps.some(s => s.title.toLowerCase().includes(q) || s.desc.toLowerCase().includes(q))
  );

  let html = `<div class="app-shell pt-4">`;

  // Search input (retained at top)
  html += `
    <div class="search-wrap">
      <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
      </svg>
      <input type="search" id="searchInput" class="search-input" placeholder="Search games..." autocomplete="off"
        value="${escHtml(query)}" autofocus>
      <button id="searchClear" class="search-clear visible">✕</button>
    </div>
  `;

  html += `<div class="search-results-count" style="margin-top:12px;">${results.length} result${results.length !== 1 ? 's' : ''} for "${escHtml(query)}"</div>`;

  if (results.length === 0) {
    html += `
      <div class="empty-state">
        <div class="empty-state-emoji">🔍</div>
        <div class="empty-state-title">No games found</div>
        <div class="empty-state-text">Try a different search term.</div>
      </div>
    `;
  } else {
    for (const game of results) {
      html += renderGameRowHtml(game);
    }
  }

  html += `<div style="height:32px;"></div></div>`;
  return html;
}

function attachSearchResultsEvents() {
  const searchInput = document.getElementById('searchInput');
  const searchClear = document.getElementById('searchClear');

  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      const q = e.target.value.trim();
      state.searchQuery = q;
      if (q.length === 0) {
        navigate('home');
        return;
      }
      const main = document.getElementById('main');
      main.innerHTML = renderSearchResults(q);
      attachSearchResultsEvents();
    });
    setTimeout(() => {
      searchInput.focus();
      searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
    }, 50);
  }

  if (searchClear) {
    searchClear.addEventListener('click', () => {
      state.searchQuery = '';
      navigate('home');
    });
  }

  attachGameRowEvents();
}

// ── Toast ─────────────────────────────────────────────────

let toastTimer;
function showToast(msg) {
  const toast = document.getElementById('toast');
  if (!toast) return;
  toast.textContent = msg;
  toast.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove('show'), 2500);
}

// ── Confirm modal ─────────────────────────────────────────

let confirmCallback = null;

function showConfirmModal(title, body, onConfirm) {
  const overlay = document.getElementById('confirmOverlay');
  document.getElementById('confirmTitle').textContent = title;
  document.getElementById('confirmBody').textContent = body;
  overlay.classList.add('open');
  confirmCallback = onConfirm;
}

function hideConfirmModal() {
  document.getElementById('confirmOverlay').classList.remove('open');
  confirmCallback = null;
}

// ── Theme dropdown ────────────────────────────────────────

function renderThemeOptions() {
  const current = getTheme();
  const container = document.getElementById('themeDropdown');
  if (!container) return;
  container.innerHTML = THEMES.map(t => `
    <button class="theme-option ${t.id === current ? 'active' : ''}" data-theme-id="${t.id}">
      <span class="theme-swatch" style="background:${t.swatch};border-color:${t.swatch}44;"></span>
      ${t.label}
    </button>
  `).join('');
  container.querySelectorAll('.theme-option').forEach(btn => {
    btn.addEventListener('click', () => {
      setTheme(btn.dataset.themeId);
      document.getElementById('themeDropdown').classList.remove('open');
    });
  });
}

// ── Back navigation ───────────────────────────────────────

function goBack() {
  switch (state.view) {
    case 'category': navigate('home'); break;
    case 'game':
      if (state.catId) navigate('category', { catId: state.catId });
      else navigate('home');
      break;
    case 'add':
    case 'edit':
      navigate('game', { gameId: state.editGameId || state.gameId });
      break;
    case 'search': navigate('home'); break;
    default: navigate('home'); break;
  }
}

// ── Utility ───────────────────────────────────────────────

function escHtml(str) {
  if (str == null) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

// ── Init ──────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', () => {
  // Apply saved theme
  setTheme(getTheme());

  // Header back button
  document.getElementById('headerBack')?.addEventListener('click', goBack);

  // Add game button
  document.getElementById('addGameBtn')?.addEventListener('click', () => {
    navigate('add');
  });

  // Theme toggle
  const themeBtn = document.getElementById('themeToggle');
  const themeDropdown = document.getElementById('themeDropdown');
  themeBtn?.addEventListener('click', (e) => {
    e.stopPropagation();
    themeDropdown?.classList.toggle('open');
    if (themeDropdown?.classList.contains('open')) renderThemeOptions();
  });
  document.addEventListener('click', () => {
    themeDropdown?.classList.remove('open');
  });
  themeDropdown?.addEventListener('click', e => e.stopPropagation());

  // Confirm modal
  document.getElementById('confirmCancel')?.addEventListener('click', hideConfirmModal);
  document.getElementById('confirmOk')?.addEventListener('click', () => {
    if (confirmCallback) confirmCallback();
    hideConfirmModal();
  });
  document.getElementById('confirmOverlay')?.addEventListener('click', (e) => {
    if (e.target === e.currentTarget) hideConfirmModal();
  });

  // Initial render
  render();
});
