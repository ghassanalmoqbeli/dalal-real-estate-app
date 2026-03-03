// Auth Management
const API_BASE = 'api/';

// Initialize password visibility toggles
function initPasswordToggles() {
    const wrappers = document.querySelectorAll('.password-input');
    
    wrappers.forEach(wrapper => {
        const input = wrapper.querySelector('input');
        const toggle = wrapper.querySelector('.password-toggle');
        
        if (!input || !toggle) return;
        
        // Ensure label matches initial state
        toggle.setAttribute('aria-label', 'إظهار كلمة المرور');
        
        toggle.addEventListener('click', function() {
            const isHidden = input.type === 'password';
            input.type = isHidden ? 'text' : 'password';
            toggle.setAttribute('aria-label', isHidden ? 'إخفاء كلمة المرور' : 'إظهار كلمة المرور');
            
            const icon = toggle.querySelector('i');
            if (icon) {
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            }
        });
    });
}

// Check if user is logged in
function getPostLoginRedirectPage() {
    // Prefer server-provided permissions stored in localStorage
    try {
        const permsStr = localStorage.getItem('admin_permissions');
        const perms = permsStr ? JSON.parse(permsStr) : null;

        // If we have permissions, pick the first allowed page.
        if (perms) {
            if (perms.can_view_dashboard) return 'dashboard.html';
            if (perms.can_manage_users) return 'users.html';
            if (perms.can_manage_ads) return 'ads.html';
            if (perms.can_manage_reports) return 'reports.html';
            if (perms.can_manage_banners) return 'banners.html';
            if (perms.can_manage_notifications) return 'notifications.html';
            if (perms.can_manage_static_content) return 'static-content.html';
            if (perms.can_manage_packages) return 'packages.html';
            if (perms.can_manage_profile) return 'profile.html';
            return 'access-denied.html';
        }
    } catch (e) {
        // ignore parsing errors and fallback below
    }

    // Fallback to old behavior if permissions are not available yet
    return 'dashboard.html';
}

function checkAuth() {
    const token = localStorage.getItem('admin_token');
    if (token && window.location.pathname.includes('index.html')) {
        window.location.href = getPostLoginRedirectPage();
    } else if (!token && !window.location.pathname.includes('index.html')) {
        window.location.href = 'index.html';
    }
}

// Login
document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    initPasswordToggles();
    
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.getElementById('errorMessage');
            
            try {
                const response = await fetch(API_BASE + 'auth.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ username, password })
                });
                
                const data = await response.json();
                
                if (data.success) {
                    localStorage.setItem('admin_token', data.token);
                    localStorage.setItem('admin_data', JSON.stringify(data.admin));
                    if (data.permissions) {
                        localStorage.setItem('admin_permissions', JSON.stringify(data.permissions));
                    }
                    window.location.href = getPostLoginRedirectPage();
                } else {
                    errorMessage.textContent = data.message;
                    errorMessage.style.display = 'block';
                }
            } catch (error) {
                errorMessage.textContent = 'حدث خطأ في الاتصال. يرجى المحاولة مرة أخرى.';
                errorMessage.style.display = 'block';
            }
        });
    }
});

// Logout
function logout() {
    if (confirm('هل أنت متأكد من تسجيل الخروج؟')) {
        localStorage.removeItem('admin_token');
        localStorage.removeItem('admin_data');
        localStorage.removeItem('admin_permissions');
        window.location.href = 'index.html';
    }
}

// Get auth token
function getAuthToken() {
    return localStorage.getItem('admin_token');
}

// Get admin data
function getAdminData() {
    const data = localStorage.getItem('admin_data');
    return data ? JSON.parse(data) : null;
}

// API request helper
async function apiRequest(endpoint, options = {}) {
    const token = getAuthToken();
    
    const defaultOptions = {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        }
    };
    
    const mergedOptions = {
        ...defaultOptions,
        ...options,
        headers: {
            ...defaultOptions.headers,
            ...(options.headers || {})
        }
    };
    
    try {
        const response = await fetch(API_BASE + endpoint, mergedOptions);
        
        if (!response.ok) {
            console.error('HTTP Error:', response.status, response.statusText);
            return { success: false, message: `خطأ في الاتصال: ${response.status}` };
        }
        
        const contentType = response.headers.get('content-type');
        if (!contentType || !contentType.includes('application/json')) {
            const text = await response.text();
            console.error('Non-JSON response:', text);
            return { success: false, message: 'استجابة غير صحيحة من الخادم' };
        }
        
        const data = await response.json();
        
        if (!data) {
            return { success: false, message: 'لا توجد بيانات من الخادم' };
        }
        
        if (!data.success && data.message === 'غير مصرح') {
            logout();
            return null;
        }
        
        return data;
    } catch (error) {
        console.error('API Error:', error);
        return { success: false, message: 'حدث خطأ في الاتصال: ' + error.message };
    }
}

