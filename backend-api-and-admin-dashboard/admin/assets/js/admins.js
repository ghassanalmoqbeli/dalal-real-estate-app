// Admins Management
let currentAdminId = null;

document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('currentAdminUsername').textContent = adminData.username;
    }
    
    // Load common.js for formatDateTime
    if (typeof formatDateTime === 'undefined') {
        const script = document.createElement('script');
        script.src = 'assets/js/common.js';
        document.head.appendChild(script);
    }
    
    // Load admins list
    loadAdmins();
    
    // Setup form handler
    document.getElementById('adminForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        await saveAdmin();
    });
    
    // Setup search input
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            loadAdmins();
        }
    });
});

// Load admins list
async function loadAdmins() {
    try {
        const search = document.getElementById('searchInput').value;
        const role = document.getElementById('roleFilter').value;
        const status = document.getElementById('statusFilter').value;
        
        let url = 'api/admins.php?';
        const params = [];
        if (search) params.push('search=' + encodeURIComponent(search));
        if (role) params.push('role=' + encodeURIComponent(role));
        if (status) params.push('status=' + encodeURIComponent(status));
        url += params.join('&');
        
        const data = await apiRequest(url.replace('api/', ''));
        
        if (data && data.success) {
            displayAdmins(data.data);
        } else {
            showError('فشل تحميل قائمة الأدمن: ' + (data?.message || 'خطأ غير معروف'));
        }
    } catch (error) {
        console.error('Error loading admins:', error);
        showError('حدث خطأ أثناء تحميل قائمة الأدمن');
    }
}

// Display admins in table
function displayAdmins(admins) {
    const container = document.getElementById('adminsTable');
    
    if (!admins || admins.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد نتائج</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد الأدمن:</strong> ${admins.length} ${admins.length === 1 ? 'أدمن' : 'أدمن'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>اسم المستخدم</th>
                    <th>الدور</th>
                    <th>الحالة</th>
                    <th>تاريخ الإنشاء</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    admins.forEach(admin => {
        const roleLabels = {
            'super_admin': '<span class="badge badge-danger"><i class="fas fa-crown"></i> Super Admin</span>',
            'editor': '<span class="badge badge-primary"><i class="fas fa-edit"></i> Editor</span>',
            'moderator': '<span class="badge badge-info"><i class="fas fa-shield-alt"></i> Moderator</span>'
        };
        
        let statusBadge = '';
        if (admin.status === 'active') {
            statusBadge = '<span class="badge badge-success">نشط</span>';
        } else if (admin.status === 'disabled') {
            statusBadge = '<span class="badge badge-danger">معطل</span>';
        } else {
            statusBadge = '<span class="badge badge-secondary">' + (admin.status || 'غير معروف') + '</span>';
        }
        
        html += `
            <tr>
                <td>${admin.id}</td>
                <td>${admin.username}</td>
                <td>${roleLabels[admin.role] || admin.role}</td>
                <td>${statusBadge}</td>
                <td>${formatDateTime(admin.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="editAdmin(${admin.id})" title="تعديل">
                            <i class="fas fa-edit"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

// Open add admin modal
function setAdminFormRequired(isRequired) {
    // Toggle required flags based on add/edit mode
    const fields = ['adminUsername', 'adminPassword', 'adminRole', 'adminStatus'];
    fields.forEach((id) => {
        const el = document.getElementById(id);
        if (!el) return;
        if (isRequired) {
            el.setAttribute('required', 'required');
        } else {
            el.removeAttribute('required');
        }
    });
}

function openAddAdminModal() {
    currentAdminId = null;
    document.getElementById('adminModalTitle').textContent = 'إضافة أدمن جديد';
    document.getElementById('adminForm').reset();
    document.getElementById('adminId').value = '';
    setAdminFormRequired(true);
    document.getElementById('passwordHint').style.display = 'none';
    const modal = document.getElementById('adminModal');
    modal.classList.add('active');
}

// Edit admin
async function editAdmin(id) {
    await loadAdminDetails(id);
}

// Load admin details for editing
async function loadAdminDetails(id) {
    try {
        // Load all admins and find the one we need
        const data = await apiRequest('admins.php');
        
        if (data && data.success && data.data) {
            const admin = data.data.find(a => a.id == id);
            if (admin) {
                currentAdminId = id;
                document.getElementById('adminModalTitle').textContent = 'تعديل أدمن';
                document.getElementById('adminId').value = admin.id;
                document.getElementById('adminUsername').value = admin.username;
                document.getElementById('adminPassword').value = '';
                setAdminFormRequired(false); // لا شيء مطلوب أثناء التعديل
                document.getElementById('passwordHint').style.display = 'block';
                document.getElementById('adminRole').value = admin.role;
                document.getElementById('adminStatus').value = admin.status;
                const modal = document.getElementById('adminModal');
                modal.classList.add('active');
            } else {
                showError('الأدمن غير موجود');
            }
        } else {
            showError('فشل تحميل بيانات الأدمن');
        }
    } catch (error) {
        console.error('Error loading admin details:', error);
        showError('حدث خطأ أثناء تحميل بيانات الأدمن');
    }
}

// Save admin (add or update)
async function saveAdmin() {
    try {
        const username = document.getElementById('adminUsername').value.trim();
        const password = document.getElementById('adminPassword').value;
        const role = document.getElementById('adminRole').value;
        const status = document.getElementById('adminStatus').value;
        
        // Validation
        if (!username) {
            showError('اسم المستخدم مطلوب');
            return;
        }
        
        if (!currentAdminId && !password) {
            showError('كلمة المرور مطلوبة عند الإضافة');
            return;
        }
        
        if (password && password.length < 8) {
            showError('كلمة المرور يجب أن تكون 8 أحرف على الأقل');
            return;
        }
        
        if (!role) {
            showError('الدور مطلوب');
            return;
        }
        
        if (!status) {
            showError('الحالة مطلوبة');
            return;
        }
        
        const formData = {
            id: currentAdminId ? parseInt(document.getElementById('adminId').value) : undefined,
            username: username,
            password: password,
            role: role,
            status: status
        };
        
        // If editing and password is empty, don't send it
        if (currentAdminId && !formData.password) {
            delete formData.password;
        }
        
        const method = currentAdminId ? 'PUT' : 'POST';
        const endpoint = 'admins.php';
        
        const data = await apiRequest(endpoint, {
            method: method,
            body: JSON.stringify(formData)
        });
        
        if (data && data.success) {
            showSuccess(data.message || 'تم الحفظ بنجاح');
            closeAdminModal();
            await loadAdmins();
        } else {
            showError(data?.message || 'فشل حفظ البيانات');
        }
    } catch (error) {
        console.error('Error saving admin:', error);
        showError('حدث خطأ أثناء حفظ البيانات');
    }
}

// NOTE: تم إلغاء زر/تدفق حذف الأدمن من لوحة التحكم لتفادي حذف الأدمنز بالخطأ.

// Close admin modal
function closeAdminModal() {
    const modal = document.getElementById('adminModal');
    modal.classList.remove('active');
    document.getElementById('adminForm').reset();
    currentAdminId = null;
}

// Helper functions
function showSuccess(message) {
    // You can implement a toast notification here
    alert(message);
}

function showError(message) {
    // You can implement a toast notification here
    alert(message);
}

