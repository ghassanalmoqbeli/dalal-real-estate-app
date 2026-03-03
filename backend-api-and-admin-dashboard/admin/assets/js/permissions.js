/**
 * Permissions Management System
 * نظام إدارة الصلاحيات للواجهة الأمامية
 */

// Fallback permissions by role (في حال تعذر جلب الصلاحيات من الخادم)
const fallbackPermissionsByRole = {
    super_admin: {
        can_manage_admins: true,
        can_manage_users: true,
        can_manage_ads: true,
        can_manage_reports: true,
        can_manage_banners: true,
        can_manage_packages: true,
        can_manage_static_content: true,
        can_manage_notifications: true,
        can_view_dashboard: true,
        can_manage_profile: true
    },
    editor: {
        can_manage_admins: false,
        can_manage_users: false,
        can_manage_ads: false,
        can_manage_reports: false,
        can_manage_banners: true,
        can_manage_packages: true,
        can_manage_static_content: true,
        can_manage_notifications: false,
        can_view_dashboard: false,
        can_manage_profile: true
    },
    moderator: {
        can_manage_admins: false,
        can_manage_users: true,
        can_manage_ads: true,
        can_manage_reports: true,
        can_manage_banners: false,
        can_manage_packages: false,
        can_manage_static_content: false,
        can_manage_notifications: true,
        can_view_dashboard: true,
        can_manage_profile: true
    }
};

// Get admin role from localStorage
function getAdminRole() {
    try {
        const data = localStorage.getItem('admin_data');
        if (!data) return null;
        const parsed = JSON.parse(data);
        return parsed?.role || null;
    } catch (e) {
        return null;
    }
}

// Get permissions from localStorage (nullable)
function getPermissions() {
    const permissionsStr = localStorage.getItem('admin_permissions');
    if (!permissionsStr) {
        return null;
    }
    
    try {
        return JSON.parse(permissionsStr);
    } catch (e) {
        console.error('Error parsing permissions:', e);
        return null;
    }
}

// Check if user has a specific permission
function hasPermission(permission) {
    const permissions = getPermissions();
    // إذا كانت الصلاحيات غير محملة، استخدم صلاحيات افتراضية بحسب الدور
    if (!permissions) {
        const role = getAdminRole();
        if (role && fallbackPermissionsByRole[role]) {
            return fallbackPermissionsByRole[role][permission] === true;
        }
        return false;
    }
    
    return permissions[permission] === true;
}

// Permission checkers
const Permissions = {
    canManageAdmins: () => hasPermission('can_manage_admins'),
    canManageUsers: () => hasPermission('can_manage_users'),
    canManageAds: () => hasPermission('can_manage_ads'),
    canManageReports: () => hasPermission('can_manage_reports'),
    canManageBanners: () => hasPermission('can_manage_banners'),
    canManagePackages: () => hasPermission('can_manage_packages'),
    canManageStaticContent: () => hasPermission('can_manage_static_content'),
    canManageNotifications: () => hasPermission('can_manage_notifications'),
    canViewDashboard: () => hasPermission('can_view_dashboard'),
    canManageProfile: () => hasPermission('can_manage_profile')
};

// Map page names to permissions
const pagePermissions = {
    'admins': 'can_manage_admins',
    'users': 'can_manage_users',
    'ads': 'can_manage_ads',
    'reports': 'can_manage_reports',
    'banners': 'can_manage_banners',
    'packages': 'can_manage_packages',
    'static-content': 'can_manage_static_content',
    'notifications': 'can_manage_notifications',
    'dashboard': 'can_view_dashboard',
    'profile': 'can_manage_profile'
};

// Check if user can access a page
function canAccessPage(pageName) {
    const permission = pagePermissions[pageName];
    if (!permission) {
        return true; // Allow access if page not in list
    }
    
    return hasPermission(permission);
}

// Filter sidebar menu items based on permissions
function filterSidebarMenu() {
    // إذا لم تكن الصلاحيات محملة بعد، نستخدم fallback حسب الدور
    const perms = getPermissions();
    const role = getAdminRole();
    const fallback = role ? fallbackPermissionsByRole[role] : null;

    const menuItems = document.querySelectorAll('.sidebar-menu-link');
    
    menuItems.forEach(item => {
        let pageName = item.getAttribute('data-page');
        
        // If no data-page attribute, extract from href
        if (!pageName) {
            const href = item.getAttribute('href');
            if (href) {
                // Extract page name from href (e.g., "dashboard.html" -> "dashboard")
                pageName = href.replace('.html', '').replace('html', '');
            }
        }
        // تحديد ما إذا كان الوصول مسموحاً
        let allowed = true;
        if (pageName && pageName !== 'index') {
            if (perms) {
                allowed = canAccessPage(pageName);
            } else if (fallback) {
                const permKey = pagePermissions[pageName];
                allowed = permKey ? fallback[permKey] === true : true;
            }
        }
        
        if (pageName && pageName !== 'index' && !allowed) {
            // Hide the menu item completely
            const listItem = item.closest('li');
            if (listItem) {
                listItem.style.display = 'none';
            }
        }
    });
}

// Hide action buttons based on permissions
function hideUnauthorizedActions() {
    // Hide buttons based on page
    const currentPage = getCurrentPageName();
    
    if (!currentPage) return;
    
    const permission = pagePermissions[currentPage];
    if (!permission || hasPermission(permission)) {
        return; // Page is accessible, no need to hide actions
    }
    
    // Hide add/edit/delete buttons if page is not accessible
    const actionButtons = document.querySelectorAll('.btn-add, .btn-edit, .btn-delete, [data-action="add"], [data-action="edit"], [data-action="delete"]');
    actionButtons.forEach(btn => {
        btn.style.display = 'none';
    });
}

// Get current page name from URL
function getCurrentPageName() {
    const path = window.location.pathname;
    let filename = path.split('/').pop();
    if (!filename || filename === '') {
        filename = path.split('/').slice(-2)[0] + '/' + path.split('/').pop();
    }
    // Remove .html extension and return clean page name
    filename = filename.replace('.html', '').replace('html', '');
    // Handle index page
    if (filename === 'index' || filename === '') {
        return 'index';
    }
    return filename;
}

// Check page access and redirect if needed
function checkPageAccess() {
    const currentPage = getCurrentPageName();
    
    if (!currentPage || currentPage === 'index') {
        return; // Allow login page
    }
    
    if (!canAccessPage(currentPage)) {
        // Redirect to access denied page
        window.location.href = 'access-denied.html';
    }
}

// Refresh permissions from server
async function refreshPermissions() {
    try {
        const data = await apiRequest('auth.php');
        if (data && data.success && data.permissions) {
            localStorage.setItem('admin_permissions', JSON.stringify(data.permissions));
            return data.permissions;
        }
    } catch (error) {
        console.error('Error refreshing permissions:', error);
    }
    return null;
}

// Initialize permissions check on page load
document.addEventListener('DOMContentLoaded', function() {
    // قم بتحديث الصلاحيات دائماً لضمان أحدث حالة، ثم طبق الإخفاء/التحقق
    refreshPermissions().finally(() => {
        checkPageAccess();
        filterSidebarMenu();
        hideUnauthorizedActions();
    });
});

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        hasPermission,
        Permissions,
        canAccessPage,
        filterSidebarMenu,
        hideUnauthorizedActions,
        refreshPermissions
    };
}

