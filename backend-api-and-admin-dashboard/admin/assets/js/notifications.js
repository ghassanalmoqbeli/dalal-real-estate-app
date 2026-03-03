// Notifications Management
document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
    }
    
    document.getElementById('notificationForm').addEventListener('submit', function(e) {
        e.preventDefault();
        sendNotification();
    });
    
    // Load notification history
    loadNotificationHistory();
});

function toggleUserSelect() {
    const targetType = document.getElementById('targetType').value;
    const userSelectGroup = document.getElementById('userSelectGroup');
    
    if (targetType === 'user') {
        userSelectGroup.style.display = 'block';
    } else {
        userSelectGroup.style.display = 'none';
        document.getElementById('selectedUserId').value = '';
    }
}

async function searchUsers() {
    const search = document.getElementById('userSearch').value;
    if (search.length < 3) {
        document.getElementById('userSearchResults').innerHTML = '';
        return;
    }
    
    try {
        const data = await apiRequest(`users.php?search=${search}&limit=10`);
        
        if (data && data.success && data.data.length > 0) {
            let html = '<div style="border: 1px solid var(--border-color); border-radius: 8px; max-height: 200px; overflow-y: auto;">';
            data.data.forEach(user => {
                html += `
                    <div style="padding: 10px; cursor: pointer; border-bottom: 1px solid var(--border-color);" 
                         onclick="selectUser(${user.id}, '${user.name}', '${user.phone}')">
                        <strong>${user.name}</strong> - ${user.phone}
                    </div>
                `;
            });
            html += '</div>';
            document.getElementById('userSearchResults').innerHTML = html;
        } else {
            document.getElementById('userSearchResults').innerHTML = '<p style="padding: 10px; color: var(--text-secondary);">لا توجد نتائج</p>';
        }
    } catch (error) {
        console.error('Error searching users:', error);
    }
}

function selectUser(userId, name, phone) {
    document.getElementById('selectedUserId').value = userId;
    document.getElementById('userSearch').value = `${name} - ${phone}`;
    document.getElementById('userSearchResults').innerHTML = '';
}

async function sendNotification() {
    const message = document.getElementById('notificationMessage').value;
    const targetType = document.getElementById('targetType').value;
    const userId = document.getElementById('selectedUserId').value;
    
    if (!message.trim()) {
        alert('يرجى إدخال نص الإشعار');
        return;
    }
    
    if (targetType === 'user' && !userId) {
        alert('يرجى اختيار مستخدم');
        return;
    }
    
    const notificationData = {
        message: message,
        target_type: targetType
    };
    
    if (targetType === 'user') {
        notificationData.user_id = parseInt(userId);
    }
    
    try {
        const data = await apiRequest('notifications.php', {
            method: 'POST',
            body: JSON.stringify(notificationData)
        });
        
        const resultDiv = document.getElementById('notificationResult');
        
        if (data && data.success) {
            resultDiv.innerHTML = `<div class="success-message">${data.message}</div>`;
            document.getElementById('notificationForm').reset();
            document.getElementById('userSelectGroup').style.display = 'none';
            // Reload notification history
            loadNotificationHistory();
        } else {
            resultDiv.innerHTML = `<div class="error-message">${data.message || 'حدث خطأ'}</div>`;
        }
    } catch (error) {
        console.error('Error sending notification:', error);
        document.getElementById('notificationResult').innerHTML = 
            '<div class="error-message">حدث خطأ في إرسال الإشعار</div>';
    }
}

async function loadNotificationHistory() {
    const container = document.getElementById('notificationHistory');
    container.innerHTML = '<div class="spinner"></div> جاري التحميل...';
    
    try {
        // Get filter value
        const readFilter = document.getElementById('filterReadStatus') ? document.getElementById('filterReadStatus').value : '';
        let url = 'notifications.php';
        if (readFilter) {
            url += `?read=${readFilter}`;
        }
        
        const data = await apiRequest(url);
        
        if (data && data.success && data.data) {
            displayNotificationHistory(data.data);
            
            // Update counter if available
            if (data.unread_count !== undefined) {
                updateNotificationCounter(data.unread_count, data.total_count);
            }
        } else {
            container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد إشعارات مرسلة</p>';
        }
    } catch (error) {
        console.error('Error loading notification history:', error);
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">حدث خطأ في تحميل سجل الإشعارات</p>';
    }
}

function filterNotifications() {
    loadNotificationHistory();
}

function updateNotificationCounter(unreadCount, totalCount) {
    // Update counter in the table header if needed
    // This can be customized based on your UI needs
}

function displayNotificationHistory(notifications) {
    const container = document.getElementById('notificationHistory');
    
    if (!notifications || notifications.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد إشعارات مرسلة</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد الإشعارات:</strong> ${notifications.length} ${notifications.length === 1 ? 'إشعار' : 'إشعار'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>نص الإشعار</th>
                    <th>المستهدف</th>
                    <th>المستخدم</th>
                    <th>حالة القراءة</th>
                    <th>التاريخ</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    notifications.forEach(notification => {
        const targetType = notification.user_id ? 'مستخدم محدد' : 'جميع المستخدمين';
        const userName = notification.user_name ? `${notification.user_name} (${notification.user_phone})` : '-';
        const date = formatDateTime ? formatDateTime(notification.created_at) : notification.created_at;
        const isRead = parseInt(notification.is_read) === 1;
        const readStatus = isRead ? 
            '<span class="badge badge-success"><i class="fas fa-check-circle"></i> مقروء</span>' : 
            '<span class="badge badge-warning"><i class="fas fa-circle"></i> غير مقروء</span>';
        
        html += `
            <tr>
                <td>${notification.message}</td>
                <td><span class="badge ${notification.user_id ? 'badge-info' : 'badge-success'}">${targetType}</span></td>
                <td>${userName}</td>
                <td>${readStatus}</td>
                <td>${date}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-danger" onclick="deleteNotification(${notification.id})" title="حذف">
                            <i class="fas fa-trash"></i> حذف
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

async function deleteNotification(notificationId) {
    if (!confirm('هل أنت متأكد من حذف الإشعار؟')) return;

    try {
        const data = await apiRequest(`notifications.php?id=${notificationId}`, {
            method: 'DELETE'
        });

        if (data && data.success) {
            loadNotificationHistory();
            showSuccessMessage(data.message || 'تم حذف الإشعار بنجاح');
        } else {
            showErrorMessage((data && data.message) ? data.message : 'حدث خطأ في حذف الإشعار');
        }
    } catch (error) {
        console.error('Error deleting notification:', error);
        showErrorMessage('حدث خطأ في حذف الإشعار');
    }
}

function showSuccessMessage(message) {
    const resultDiv = document.getElementById('notificationResult');
    resultDiv.innerHTML = `<div class="success-message" style="margin-top: 10px;">${message}</div>`;
    setTimeout(() => {
        resultDiv.innerHTML = '';
    }, 3000);
}

function showErrorMessage(message) {
    const resultDiv = document.getElementById('notificationResult');
    resultDiv.innerHTML = `<div class="error-message" style="margin-top: 10px;">${message}</div>`;
    setTimeout(() => {
        resultDiv.innerHTML = '';
    }, 3000);
}

