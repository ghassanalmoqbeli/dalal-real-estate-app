// Users Management
let currentPage = 1;
let totalPages = 1;

document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
    }
    
    // Load common.js for formatDateTime
    if (typeof formatDateTime === 'undefined') {
        const script = document.createElement('script');
        script.src = 'assets/js/common.js';
        document.head.appendChild(script);
    }
    
    loadUsers();
    
    // Search on Enter
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            loadUsers();
        }
    });
});

async function loadUsers(page = 1) {
    currentPage = page;
    
    const search = document.getElementById('searchInput').value;
    const status = document.getElementById('statusFilter').value;
    const sortBy = document.getElementById('sortBy').value;
    
    const params = new URLSearchParams({
        page: page,
        limit: 20,
        sort_by: sortBy,
        sort_order: 'DESC'
    });
    
    if (search) params.append('search', search);
    if (status) params.append('status', status);
    
    try {
        const data = await apiRequest(`users.php?${params.toString()}`);
        
        if (data && data.success) {
            displayUsers(data.data);
            totalPages = data.pagination.pages;
            displayPagination();
        } else {
            document.getElementById('usersTable').innerHTML = '<p style="padding: 20px; text-align: center;">حدث خطأ في تحميل البيانات</p>';
        }
    } catch (error) {
        console.error('Error loading users:', error);
    }
}

function displayUsers(users) {
    const container = document.getElementById('usersTable');
    
    if (!users || users.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد نتائج</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد المستخدمين:</strong> ${users.length} ${users.length === 1 ? 'مستخدم' : 'مستخدمين'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>الاسم</th>
                    <th>رقم الهاتف</th>
                    <th>رقم الواتساب</th>
                    <th>عدد الإعلانات</th>
                    <th>عدد البلاغات</th>
                    <th>الحالة</th>
                    <th>تاريخ التسجيل</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    users.forEach(user => {
        let statusBadge = '';
        if (user.status === 'active') {
            statusBadge = '<span class="badge badge-success">نشط</span>';
        } else if (user.status === 'blocked') {
            statusBadge = '<span class="badge badge-danger">موقوف</span>';
        } else if (user.status === 'pending_deletion') {
            statusBadge = '<span class="badge badge-warning"><i class="fas fa-exclamation-triangle"></i> طلب حذف</span>';
        } else {
            statusBadge = '<span class="badge badge-secondary">' + (user.status || 'غير معروف') + '</span>';
        }
        
        html += `
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.phone}</td>
                <td>${user.whatsapp || '-'}</td>
                <td>${user.ads_count || 0}</td>
                <td>${user.reports_count || 0}</td>
                <td>${statusBadge}</td>
                <td>${formatDateTime(user.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="viewUser(${user.id})">
                            <i class="fas fa-eye"></i>
                        </button>
                        ${user.status === 'pending_deletion' 
                            ? `
                                <button class="btn btn-sm btn-warning" onclick="blockUser(${user.id})" title="إيقاف المستخدم">
                                    <i class="fas fa-user-slash"></i> إيقاف المستخدم
                                </button>
                                <button class="btn btn-sm btn-warning" onclick="rejectDeletion(${user.id})" title="رفض طلب الحذف">
                                    <i class="fas fa-times"></i> رفض طلب الحذف
                                </button>
                            `
                            : user.status === 'active' 
                                ? `<button class="btn btn-sm btn-warning" onclick="blockUser(${user.id})" title="إيقاف المستخدم"><i class="fas fa-user-slash"></i> إيقاف المستخدم</button>`
                                : user.status === 'blocked'
                                    ? `<button class="btn btn-sm btn-success" onclick="unblockUser(${user.id})" title="إعادة تفعيل المستخدم"><i class="fas fa-user-check"></i> إعادة تفعيل المستخدم</button>`
                                    : ''
                        }
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

function filterUsers() {
    loadUsers(1);
}

function displayPagination() {
    const container = document.getElementById('pagination');
    
    if (totalPages <= 1) {
        container.innerHTML = '';
        return;
    }
    
    let html = '';
    
    // Previous button
    html += `<button ${currentPage === 1 ? 'disabled' : ''} onclick="loadUsers(${currentPage - 1})">
        <i class="fas fa-chevron-right"></i> السابق
    </button>`;
    
    // Page numbers
    for (let i = 1; i <= totalPages; i++) {
        if (i === 1 || i === totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
            html += `<button class="${i === currentPage ? 'active' : ''}" onclick="loadUsers(${i})">${i}</button>`;
        } else if (i === currentPage - 3 || i === currentPage + 3) {
            html += `<button disabled>...</button>`;
        }
    }
    
    // Next button
    html += `<button ${currentPage === totalPages ? 'disabled' : ''} onclick="loadUsers(${currentPage + 1})">
        التالي <i class="fas fa-chevron-left"></i>
    </button>`;
    
    container.innerHTML = html;
}

async function viewUser(userId) {
    try {
        const data = await apiRequest(`users.php?id=${userId}`);
        
        if (data && data.success) {
            const user = data.data;
            const modal = document.getElementById('userModal');
            const details = document.getElementById('userDetails');
            
            const statusBadges = {
                'active': '<span class="badge badge-success">نشط</span>',
                'blocked': '<span class="badge badge-danger">موقوف</span>',
                'pending_deletion': '<span class="badge badge-warning"><i class="fas fa-exclamation-triangle"></i> طلب حذف</span>'
            };
            
            let html = `
                <div class="details-section">
                    <div class="details-card">
                        <h3>معلومات المستخدم</h3>
                        ${user.profile_image ? `
                        <div class="details-row" style="grid-template-columns: 1fr; text-align: center; margin-bottom: 20px;">
                            <div class="details-value">
                                <img src="${user.profile_image}" alt="صورة المستخدم" class="user-profile-image" style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary-color); box-shadow: var(--shadow-lg); cursor: pointer; transition: transform 0.3s ease;" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\'%3E%3Ccircle fill=\'%23ddd\' cx=\'75\' cy=\'75\' r=\'75\'/%3E%3Ctext fill=\'%23999\' font-family=\'sans-serif\' font-size=\'12\' dy=\'10.5\' font-weight=\'bold\' x=\'50%25\' y=\'50%25\' text-anchor=\'middle\'%3Eلا توجد صورة%3C/text%3E%3C/svg%3E'; this.style.border='3px solid var(--primary-color)';" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'" onclick="openMediaViewer([{type: 'image', path: '${user.profile_image}'}], 0)">
                            </div>
                        </div>
                        ` : ''}
                        <div class="details-row">
                            <div class="details-label">المعرف (ID):</div>
                            <div class="details-value">#${user.id}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">الاسم:</div>
                            <div class="details-value">${user.name}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">رقم الهاتف:</div>
                            <div class="details-value">${user.phone}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">رقم الواتساب:</div>
                            <div class="details-value">${user.whatsapp || '-'}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">تحقق من رقم الهاتف:</div>
                            <div class="details-value">
                                ${user.is_phone_verified ? '<span class="badge badge-success">محقق</span>' : '<span class="badge badge-secondary">غير محقق</span>'}
                            </div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">تاريخ الميلاد:</div>
                            <div class="details-value">${user.date_of_birth || '-'}</div>
                        </div>
                        ${user.date_of_birth ? `
                        <div class="details-row">
                            <div class="details-label">العمر:</div>
                            <div class="details-value">${calculateAge(user.date_of_birth)} سنة</div>
                        </div>
                        ` : ''}
                        <div class="details-row">
                            <div class="details-label">الحالة:</div>
                            <div class="details-value">
                                ${statusBadges[user.status] || '<span class="badge badge-secondary">غير معروف</span>'}
                            </div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">عدد الإعلانات:</div>
                            <div class="details-value">${user.ads_count || 0}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">عدد البلاغات:</div>
                            <div class="details-value">${user.reports_count || 0}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">تاريخ التسجيل:</div>
                            <div class="details-value">${formatDateTime(user.created_at)}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">آخر تحديث:</div>
                            <div class="details-value">${user.updated_at ? formatDateTime(user.updated_at) : '-'}</div>
                        </div>
                    </div>
                </div>
            `;
            
            if (user.ads && user.ads.length > 0) {
                html += `
                    <div class="details-section">
                        <div class="details-card">
                            <h3>إعلانات المستخدم (${user.ads.length})</h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>العنوان</th>
                                        <th>الحالة</th>
                                        <th>التاريخ</th>
                                    </tr>
                                </thead>
                                <tbody>
                `;
                user.ads.forEach(ad => {
                    const adStatusBadges = {
                        'pending': '<span class="badge badge-warning">قيد المراجعة</span>',
                        'published': '<span class="badge badge-success">منشور</span>',
                        'rejected': '<span class="badge badge-danger">مرفوض</span>'
                    };
                    html += `
                        <tr>
                            <td>${ad.title}</td>
                            <td>${adStatusBadges[ad.status] || ad.status}</td>
                            <td>${formatDateTime(ad.created_at)}</td>
                        </tr>
                    `;
                });
                html += '</tbody></table></div></div>';
            }
            
            if (user.reports && user.reports.length > 0) {
                html += `
                    <div class="details-section">
                        <div class="details-card">
                            <h3>البلاغات المرتبطة (${user.reports.length})</h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>السبب</th>
                                        <th>الحالة</th>
                                        <th>التاريخ</th>
                                    </tr>
                                </thead>
                                <tbody>
                `;
                user.reports.forEach(report => {
                    const reasonLabels = {
                        'fake': 'مزيف',
                        'wrong_info': 'معلومات خاطئة',
                        'fraud': 'احتيال',
                        'other': 'أخرى'
                    };
                    html += `
                        <tr>
                            <td>${reasonLabels[report.reason] || report.reason}</td>
                            <td>${report.status === 'open' ? '<span class="badge badge-warning">مفتوح</span>' : '<span class="badge badge-success">مغلق</span>'}</td>
                            <td>${formatDateTime(report.created_at)}</td>
                        </tr>
                    `;
                });
                html += '</tbody></table></div></div>';
            }
            
            details.innerHTML = html;
            modal.classList.add('active');
        }
    } catch (error) {
        console.error('Error loading user:', error);
        alert('حدث خطأ في تحميل بيانات المستخدم');
    }
}

function closeUserModal() {
    document.getElementById('userModal').classList.remove('active');
}

async function blockUser(userId) {
    if (!confirm('هل أنت متأكد من إيقاف هذا المستخدم؟')) return;
    
    try {
        const data = await apiRequest('users.php', {
            method: 'PUT',
            body: JSON.stringify({
                user_id: userId,
                action: 'block'
            })
        });
        
        if (data && data.success) {
            alert('تم إيقاف المستخدم بنجاح');
            loadUsers(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error blocking user:', error);
        alert('حدث خطأ في حظر المستخدم');
    }
}

async function unblockUser(userId) {
    if (!confirm('هل أنت متأكد من إعادة تفعيل هذا المستخدم؟')) return;
    
    try {
        const data = await apiRequest('users.php', {
            method: 'PUT',
            body: JSON.stringify({
                user_id: userId,
                action: 'unblock'
            })
        });
        
        if (data && data.success) {
            alert('تمت إعادة تفعيل المستخدم بنجاح');
            loadUsers(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error unblocking user:', error);
        alert('حدث خطأ في إلغاء حظر المستخدم');
    }
}

// NOTE: تم إلغاء زر/تدفق الحذف من لوحة الأدمن. نحتفظ بالكود القديم (إن وُجد بالباك-إند)
// لتجنب كسر أي اعتماد آخر، لكن لا يتم استدعاؤه من الواجهة.

function filterUsers() {
    loadUsers(1);
}

// approveDeletion تم استبداله بزر "إيقاف المستخدم" عند وجود طلب حذف.

async function rejectDeletion(userId) {
    if (!confirm('هل تريد رفض طلب حذف الحساب وإعادة تفعيل الحساب؟')) {
        return;
    }
    
    try {
        const data = await apiRequest('users.php', {
            method: 'PUT',
            body: JSON.stringify({
                user_id: userId,
                action: 'reject_deletion'
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            loadUsers(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error rejecting deletion:', error);
        alert('حدث خطأ في رفض طلب الحذف');
    }
}

// Calculate age from date of birth
function calculateAge(dateOfBirth) {
    if (!dateOfBirth) return '-';
    
    const birthDate = new Date(dateOfBirth);
    if (isNaN(birthDate.getTime())) return '-';
    
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    
    return age;
}

// Use formatDateTime from common.js

