// Profile Management
document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
        document.getElementById('username').value = adminData.username;
    }
    
    document.getElementById('profileForm').addEventListener('submit', function(e) {
        e.preventDefault();
        updateProfile();
    });
});

async function updateProfile() {
    const username = document.getElementById('username').value;
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (!username.trim()) {
        alert('اسم المستخدم مطلوب');
        return;
    }
    
    if (newPassword && newPassword !== confirmPassword) {
        alert('كلمة المرور الجديدة وتأكيدها غير متطابقين');
        return;
    }
    
    if (newPassword && !currentPassword) {
        alert('يرجى إدخال كلمة المرور الحالية لتغيير كلمة المرور');
        return;
    }
    
    try {
        const data = await apiRequest('profile.php', {
            method: 'PUT',
            body: JSON.stringify({
                username: username,
                current_password: currentPassword || null,
                new_password: newPassword || null
            })
        });
        
        const resultDiv = document.getElementById('profileResult');
        
        if (data && data.success) {
            resultDiv.innerHTML = '<div class="success-message">تم تحديث البيانات بنجاح</div>';
            if (data.token) {
                localStorage.setItem('admin_token', data.token);
            }
            if (data.admin) {
                localStorage.setItem('admin_data', JSON.stringify(data.admin));
                document.getElementById('adminUsername').textContent = data.admin.username;
            }
            document.getElementById('profileForm').reset();
            document.getElementById('username').value = data.admin.username;
        } else {
            resultDiv.innerHTML = `<div class="error-message">${data.message || 'حدث خطأ'}</div>`;
        }
    } catch (error) {
        console.error('Error updating profile:', error);
        document.getElementById('profileResult').innerHTML = 
            '<div class="error-message">حدث خطأ في تحديث البيانات</div>';
    }
}

