// ============================================
// SIDEBAR TOGGLE - Ultra Simple Version
// ============================================

// Define toggle function IMMEDIATELY - available before DOM
window.toggleSidebar = function() {
    var sidebar = document.querySelector('.sidebar');
    var mainContent = document.querySelector('.main-content');
    
    if (!sidebar || !mainContent) {
        console.error('Sidebar not found');
        return;
    }
    
    var isMobile = window.innerWidth <= 768;
    
    if (isMobile) {
        // Mobile: toggle show
        sidebar.classList.toggle('show-mobile');
        var overlay = document.querySelector('.sidebar-overlay');
        if (overlay) {
            overlay.classList.toggle('active');
        }
    } else {
        // Desktop: toggle collapse
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('expanded');
        
        // Save
        try {
            localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed') ? 'true' : 'false');
        } catch(e) {}
    }
};

// Initialize
(function() {
    function init() {
        var sidebar = document.querySelector('.sidebar');
        var mainContent = document.querySelector('.main-content');
        if (!sidebar || !mainContent) return;
        
        var isMobile = window.innerWidth <= 768;
        
        // Load state
        if (!isMobile) {
            try {
                if (localStorage.getItem('sidebarCollapsed') === 'true') {
                    sidebar.classList.add('collapsed');
                    mainContent.classList.add('expanded');
                }
            } catch(e) {}
        }
        
        // Mobile setup
        if (isMobile) {
            if (!document.querySelector('.mobile-menu-btn')) {
                var btn = document.createElement('button');
                btn.className = 'mobile-menu-btn';
                btn.innerHTML = '<i class="fas fa-bars"></i>';
                btn.onclick = function() {
                    sidebar.classList.add('show-mobile');
                    var overlay = document.querySelector('.sidebar-overlay');
                    if (overlay) overlay.classList.add('active');
                };
                document.body.appendChild(btn);
            }
            
            if (!document.querySelector('.sidebar-overlay')) {
                var overlay = document.createElement('div');
                overlay.className = 'sidebar-overlay';
                overlay.onclick = function() {
                    sidebar.classList.remove('show-mobile');
                    overlay.classList.remove('active');
                };
                document.body.appendChild(overlay);
            }
        }
        
        // Keyboard shortcut
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'b' && !isMobile) {
                e.preventDefault();
                window.toggleSidebar();
            }
        });
    }
    
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    setTimeout(init, 100);
})();
