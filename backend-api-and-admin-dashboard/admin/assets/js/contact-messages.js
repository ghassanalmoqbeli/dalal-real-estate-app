// Contact Messages Management
let currentPage = 1;
let totalPages = 1;
let currentMessageId = null;

document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
    }
    
    loadMessages();
});

async function loadMessages(page = 1) {
    currentPage = page;
    
    const status = document.getElementById('statusFilter').value;
    
    const params = new URLSearchParams({
        page: page,
        limit: 20
    });
    
    if (status) params.append('status', status);
    
    try {
        const data = await apiRequest(`contact_messages.php?${params.toString()}`);
        
        if (data && data.success) {
            displayMessages(data.data);
            totalPages = data.pagination.pages;
            displayPagination();
        }
    } catch (error) {
        console.error('Error loading messages:', error);
    }
}

function displayMessages(messages) {
    const container = document.getElementById('messagesTable');
    
    if (!messages || messages.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد رسائل</p>';
        return;
    }
    
    let html = `
        <table class="table">
            <thead>
                <tr>
                    <th>الاسم</th>
                    <th>الهاتف</th>
                    <th>البريد الإلكتروني</th>
                    <th>الموضوع</th>
                    <th>الحالة</th>
                    <th>التاريخ</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    messages.forEach(message => {
        const statusBadge = message.status === 'pending'
            ? '<span class="badge badge-warning">قيد المعالجة</span>'
            : '<span class="badge badge-success">تمت المعالجة</span>';
        
        html += `
            <tr>
                <td>${message.name}</td>
                <td>${message.phone}</td>
                <td>${message.email || '-'}</td>
                <td>${message.subject}</td>
                <td>${statusBadge}</td>
                <td>${formatDate(message.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="viewMessage(${message.id})">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

function displayPagination() {
    const container = document.getElementById('pagination');
    
    if (totalPages <= 1) {
        container.innerHTML = '';
        return;
    }
    
    let html = '';
    html += `<button ${currentPage === 1 ? 'disabled' : ''} onclick="loadMessages(${currentPage - 1})">
        <i class="fas fa-chevron-right"></i> السابق
    </button>`;
    
    for (let i = 1; i <= totalPages; i++) {
        if (i === 1 || i === totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
            html += `<button class="${i === currentPage ? 'active' : ''}" onclick="loadMessages(${i})">${i}</button>`;
        } else if (i === currentPage - 3 || i === currentPage + 3) {
            html += `<button disabled>...</button>`;
        }
    }
    
    html += `<button ${currentPage === totalPages ? 'disabled' : ''} onclick="loadMessages(${currentPage + 1})">
        التالي <i class="fas fa-chevron-left"></i>
    </button>`;
    
    container.innerHTML = html;
}

async function viewMessage(messageId) {
    try {
        const data = await apiRequest('contact_messages.php');
        
        if (data && data.success) {
            const message = data.data.find(m => m.id == messageId);
            
            if (message) {
                const modal = document.getElementById('messageModal');
                const details = document.getElementById('messageDetails');
                
                let html = `
                    <div style="margin-bottom: 20px;">
                        <h3>${message.subject}</h3>
                        <p><strong>الاسم:</strong> ${message.name}</p>
                        <p><strong>الهاتف:</strong> ${message.phone}</p>
                        ${message.email ? `<p><strong>البريد الإلكتروني:</strong> ${message.email}</p>` : ''}
                        <p><strong>التاريخ:</strong> ${formatDate(message.created_at)}</p>
                        <p><strong>الحالة:</strong> ${message.status === 'pending' ? 'قيد المعالجة' : 'تمت المعالجة'}</p>
                        <div style="margin-top: 20px; padding: 15px; background-color: var(--bg-color); border-radius: 8px;">
                            <strong>الرسالة:</strong>
                            <p style="margin-top: 10px;">${message.message}</p>
                        </div>
                        ${message.response ? `
                            <div style="margin-top: 20px; padding: 15px; background-color: #d1fae5; border-radius: 8px;">
                                <strong>الرد:</strong>
                                <p style="margin-top: 10px;">${message.response}</p>
                            </div>
                        ` : ''}
                    </div>
                `;
                
                if (message.status === 'pending') {
                    html += `
                        <form id="responseForm" style="margin-top: 20px;">
                            <div class="form-group">
                                <label>الرد (اختياري)</label>
                                <textarea id="responseText" rows="4" placeholder="أدخل ردك على الرسالة..."></textarea>
                            </div>
                            <div class="action-buttons">
                                <button type="button" class="btn btn-success" onclick="markAsHandled(${message.id})">
                                    تمت المعالجة
                                </button>
                            </div>
                        </form>
                    `;
                }
                
                details.innerHTML = html;
                modal.classList.add('active');
                currentMessageId = messageId;
            }
        }
    } catch (error) {
        console.error('Error loading message:', error);
        alert('حدث خطأ في تحميل الرسالة');
    }
}

function closeMessageModal() {
    document.getElementById('messageModal').classList.remove('active');
    currentMessageId = null;
}

async function markAsHandled(messageId) {
    const response = document.getElementById('responseText') ? document.getElementById('responseText').value : '';
    
    try {
        const data = await apiRequest('contact_messages.php', {
            method: 'PUT',
            body: JSON.stringify({
                id: messageId,
                status: 'handled',
                response: response || null
            })
        });
        
        if (data && data.success) {
            alert('تم تحديث حالة الرسالة بنجاح');
            closeMessageModal();
            loadMessages(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error updating message:', error);
        alert('حدث خطأ في تحديث الرسالة');
    }
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('ar-SA', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

