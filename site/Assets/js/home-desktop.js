(() => {
    const desktop = document.querySelector('.desktop-page');
    const workspace = desktop.querySelector('.desktop-workspace');
    const clock = desktop.querySelector('#desktop-clock');
    const compact = matchMedia('(max-width: 600px)');
    const windows = new Map();

    // Appearance follows the system. Drop any explicit theme a visitor picked
    // with the toggle this page used to have, so Ignite goes back to auto.
    if (localStorage.getItem('custom-theme')) igniteSwitchTheme('auto');

    // Every .desktop-window is managed here. Launchers (dock items and in-window
    // shortcuts) point at their window through data-desktop-window; launcher
    // links keep their href so the page still works without JavaScript.
    for (const panel of desktop.querySelectorAll('.desktop-window')) {
        const state = {
            panel,
            titleBar: panel.querySelector('.desktop-title-bar'),
            maximize: panel.querySelector('[data-desktop-action="maximize"]'),
            launchers: [...desktop.querySelectorAll(`[data-desktop-action="open"][data-desktop-window="${panel.id}"]`)],
            x: 0, y: 0, drag: null, opener: null,
        };
        windows.set(panel.id, state);
        setLauncherState(state, panel.hidden ? 'closed' : 'open');
        bindTitleBar(state);
    }
    // A page for a window renders it open and in front (is-active); otherwise
    // the first visible window is in front.
    const preset = [...windows.values()].find(state => state.panel.classList.contains('is-active'));
    const front = preset || visibleWindows()[0];
    if (front && front !== visibleWindows()[0]) cascade(front);
    activate(front);

    function visibleWindows() {
        return [...windows.values()].filter(state => !state.panel.hidden);
    }

    function stateFor(control) {
        return windows.get(control.dataset.desktopWindow || control.closest('.desktop-window')?.id);
    }

    function setPosition(state, x, y) {
        state.x = x;
        state.y = y;
        if (x === 0 && y === 0) {
            state.panel.style.removeProperty('--window-x');
            state.panel.style.removeProperty('--window-y');
        } else {
            state.panel.style.setProperty('--window-x', `${x}px`);
            state.panel.style.setProperty('--window-y', `${y}px`);
        }
    }

    function setLauncherState(state, status) {
        for (const launcher of state.launchers) {
            launcher.setAttribute('aria-expanded', String(status === 'open'));
            launcher.classList.toggle('is-closed', status === 'closed');
        }
    }

    function activate(state) {
        if (!state) return;
        for (const other of windows.values()) other.panel.classList.toggle('is-active', other === state);
    }

    // A newly opened window sits slightly offset from the front window, like
    // macOS cascading, then gets nudged back inside the workspace if needed.
    function cascade(state) {
        const others = visibleWindows().filter(other => other !== state);
        const front = others.find(other => other.panel.classList.contains('is-active')) || others[0];
        if (!front || compact.matches || state.panel.classList.contains('is-maximized')) {
            setPosition(state, 0, 0);
            return;
        }
        setPosition(state, front.x + 40, front.y + 32);
        clampIntoWorkspace(state);
    }

    // Nudge a window back inside the workspace, keeping its top-left corner
    // visible when it is larger than the available space.
    function clampIntoWorkspace(state) {
        const area = workspace.getBoundingClientRect();
        const rect = state.panel.getBoundingClientRect();
        const dx = Math.max(area.left + 8 - rect.left, Math.min(0, area.right - 8 - rect.right));
        const dy = Math.max(area.top + 8 - rect.top, Math.min(0, area.bottom - 8 - rect.bottom));
        if (dx || dy) setPosition(state, state.x + dx, state.y + dy);
    }

    function openWindow(state, opener) {
        const wasHidden = state.panel.hidden;
        if (opener) state.opener = opener;
        state.panel.hidden = false;
        if (wasHidden) cascade(state);
        setLauncherState(state, 'open');
        activate(state);
        state.panel.querySelector('[tabindex="-1"]').focus({ preventScroll: true });
    }

    function hideWindow(state, closed) {
        state.panel.hidden = true;
        state.panel.classList.remove('is-active');
        setLauncherState(state, closed ? 'closed' : 'minimized');
        // A page for a window renders it open and in front (is-active); otherwise
    // the first visible window is in front.
    const preset = [...windows.values()].find(state => state.panel.classList.contains('is-active'));
    const front = preset || visibleWindows()[0];
    if (front && front !== visibleWindows()[0]) cascade(front);
    activate(front);
        // Send focus back to whatever opened the window, unless it is inside a
        // window that has since been hidden; the dock item is always visible.
        const visible = element => element && !element.closest('[hidden]');
        const target = visible(state.opener) ? state.opener : state.launchers.find(visible);
        target?.focus({ preventScroll: true });
    }

    function toggleMaximize(state) {
        setPosition(state, 0, 0);
        const expanded = state.panel.classList.toggle('is-maximized');
        const label = expanded ? 'Restaurar tamanho da janela' : 'Ampliar janela';
        state.maximize.setAttribute('aria-label', label);
        state.maximize.setAttribute('title', label);
    }

    function bindTitleBar(state) {
        const { titleBar, panel } = state;
        titleBar.addEventListener('dblclick', event => {
            if (!event.target.closest('button')) toggleMaximize(state);
        });
        titleBar.addEventListener('pointerdown', event => {
            if (event.button !== 0 || event.target.closest('button') || compact.matches || panel.classList.contains('is-maximized')) return;
            const area = workspace.getBoundingClientRect();
            const rect = panel.getBoundingClientRect();
            state.drag = { startX: event.clientX, startY: event.clientY, x: state.x, y: state.y,
                minX: area.left + 8 - rect.left, maxX: area.right - 8 - rect.right,
                minY: area.top + 8 - rect.top, maxY: area.bottom - 8 - rect.bottom };
            titleBar.setPointerCapture(event.pointerId);
        });
        titleBar.addEventListener('pointermove', event => {
            const { drag } = state;
            if (!drag) return;
            setPosition(state,
                drag.x + Math.max(drag.minX, Math.min(drag.maxX, event.clientX - drag.startX)),
                drag.y + Math.max(drag.minY, Math.min(drag.maxY, event.clientY - drag.startY)));
        });
        titleBar.addEventListener('lostpointercapture', () => { state.drag = null; });
    }

    workspace.addEventListener('pointerdown', event => {
        const panel = event.target.closest('.desktop-window');
        if (panel) activate(windows.get(panel.id));
    });

    desktop.addEventListener('click', event => {
        const control = event.target.closest('[data-desktop-action]');
        if (!control) return;
        const action = control.dataset.desktopAction;
        const state = stateFor(control);
        if (!state) return;
        switch (action) {
        case 'open':
            // Modified clicks on a launcher link still open the full page in a new tab.
            if (control.tagName === 'A' && (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey)) return;
            event.preventDefault();
            openWindow(state, control);
            break;
        case 'close':
        case 'minimize':
            hideWindow(state, action === 'close');
            break;
        case 'maximize':
            toggleMaximize(state);
            break;
        }
    });

    // The skip link targets an element inside a window; reopen that window
    // if it has been closed or minimized.
    const skipLink = desktop.querySelector('.desktop-skip-link');
    skipLink.addEventListener('click', () => {
        const panel = document.querySelector(skipLink.hash)?.closest('.desktop-window');
        if (panel) openWindow(windows.get(panel.id));
    });
    // Keep windows where they are on resize, just nudged back on screen;
    // on small screens they always sit at the origin.
    window.addEventListener('resize', () => {
        for (const state of visibleWindows()) {
            if (compact.matches) setPosition(state, 0, 0);
            else clampIntoWorkspace(state);
        }
    });
    desktop.addEventListener('keydown', event => {
        if (event.key !== 'Escape') return;
        const state = visibleWindows().find(other => other.panel.classList.contains('is-maximized'));
        if (state) toggleMaximize(state);
    });

    function updateClock() {
        const now = new Date();
        clock.dateTime = now.toISOString();
        clock.textContent = new Intl.DateTimeFormat('pt-BR', compact.matches
            ? { hour: '2-digit', minute: '2-digit' }
            : { weekday: 'short', day: 'numeric', month: 'short', hour: '2-digit', minute: '2-digit' }
        ).format(now);
    }
    updateClock();
    compact.addEventListener('change', updateClock);
    setInterval(updateClock, 15000);
})();
