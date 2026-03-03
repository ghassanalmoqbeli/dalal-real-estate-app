// Reports Management - Complete Rebuild
let currentPage = 1;
let totalPages = 1;
let currentReportId = null;

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
    
    const urlParams = new URLSearchParams(window.location.search);
    const reportId = urlParams.get('id');
    const status = urlParams.get('status');
    
    if (status) {
        document.getElementById('statusFilter').value = status;
    }
    
    if (reportId) {
        viewReport(parseInt(reportId));
    }
    
    loadReports();
    
    // Setup reject ad form handler
    const rejectAdForm = document.getElementById('rejectAdForm');
    if (rejectAdForm) {
        rejectAdForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const reportId = parseInt(document.getElementById('rejectAdReportId').value);
            const adId = parseInt(document.getElementById('rejectAdId').value);
            const rejectReason = document.getElementById('rejectAdReason').value.trim();
            
            if (!rejectReason) {
                alert('يجب إدخال سبب الرفض');
                return;
            }
            
            try {
                // Reject the ad
                const rejectData = await apiRequest('ads.php', {
                    method: 'PUT',
                    body: JSON.stringify({
                        ad_id: adId,
                        action: 'reject',
                        reject_reason: rejectReason
                    })
                });
                
                if (rejectData && rejectData.success) {
                    // Close the report
                    const closeData = await apiRequest('reports.php', {
                        method: 'PUT',
                        body: JSON.stringify({
                            report_id: reportId,
                            action: 'close'
                        })
                    });
                    
                    if (closeData && closeData.success) {
                        alert('تم رفض الإعلان وإغلاق البلاغ بنجاح');
                        closeRejectAdModal();
                        closeReportModal();
                        loadReports(currentPage);
                    } else {
                        alert('تم رفض الإعلان لكن فشل إغلاق البلاغ');
                    }
                } else {
                    alert(rejectData.message || 'حدث خطأ في رفض الإعلان');
                }
            } catch (error) {
                console.error('Error rejecting ad:', error);
                alert('حدث خطأ في رفض الإعلان: ' + (error.message || error));
            }
        });
    }
});

// Load reports list
async function loadReports(page = 1) {
    currentPage = page;
    
    const status = document.getElementById('statusFilter').value;
    
    const params = new URLSearchParams({
        page: page,
        limit: 20
    });
    
    if (status) {
        params.append('status', status);
    }
    
    const container = document.getElementById('reportsTable');
    container.innerHTML = '<div class="spinner"></div> جاري التحميل...';
    
    try {
        const data = await apiRequest(`reports.php?${params.toString()}`);
        
        if (data && data.success) {
            displayReports(data.data);
            totalPages = data.pagination.pages;
            displayPagination();
        } else {
            container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">' + (data.message || 'حدث خطأ في تحميل البلاغات') + '</p>';
        }
    } catch (error) {
        console.error('Error loading reports:', error);
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">حدث خطأ في تحميل البلاغات</p>';
    }
}

// Display reports in table
function displayReports(reports) {
    const container = document.getElementById('reportsTable');
    
    if (!reports || reports.length === 0) {
        container.innerHTML = `
            <div style="padding: 40px; text-align: center; color: var(--text-secondary);">
                <i class="fas fa-inbox" style="font-size: 48px; color: var(--border-color); margin-bottom: 15px;"></i>
                <p style="font-size: 16px;">لا توجد بلاغات</p>
            </div>
        `;
        return;
    }
    
    const reasonLabels = {
        'fake': 'مزيف',
        'wrong_info': 'معلومات خاطئة',
        'fraud': 'احتيال',
        'other': 'أخرى'
    };
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد البلاغات:</strong> ${reports.length} ${reports.length === 1 ? 'بلاغ' : 'بلاغ'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>السبب</th>
                    <th>المبلغ</th>
                    <th>الإعلان</th>
                    <th>الحالة</th>
                    <th>تاريخ ووقت البلاغ</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    reports.forEach(report => {
        const reportId = parseInt(report.id) || 0;
        
        if (!reportId) {
            console.error('Invalid report ID:', report);
            return;
        }
        
        const statusBadge = report.status === 'open' 
            ? '<span class="badge badge-warning">مفتوح</span>'
            : '<span class="badge badge-success">مغلق</span>';
        
        const adDeletedBadge = report.ad_deleted 
            ? '<span class="badge badge-danger" style="margin-right: 5px;">إعلان محذوف</span>' 
            : '';
        
        const adTitle = report.ad_title 
            ? `${adDeletedBadge}<strong>${report.ad_title}</strong>` 
            : `${adDeletedBadge}<span style="color: var(--text-secondary);">إعلان محذوف</span>`;
        
        html += `
            <tr>
                <td><span class="badge badge-danger">${reasonLabels[report.reason] || report.reason}</span></td>
                <td>${report.reporter_name || 'غير معروف'}</td>
                <td>${adTitle}</td>
                <td>${statusBadge}</td>
                <td>${formatDateTime(report.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="viewReport(${reportId})" title="عرض التفاصيل">
                            <i class="fas fa-eye"></i> عرض
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

// Display pagination
function displayPagination() {
    const container = document.getElementById('pagination');
    
    if (totalPages <= 1) {
        container.innerHTML = '';
        return;
    }
    
    let html = '';
    html += `<button ${currentPage === 1 ? 'disabled' : ''} onclick="loadReports(${currentPage - 1})">
        <i class="fas fa-chevron-right"></i> السابق
    </button>`;
    
    for (let i = 1; i <= totalPages; i++) {
        if (i === 1 || i === totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
            html += `<button class="${i === currentPage ? 'active' : ''}" onclick="loadReports(${i})">${i}</button>`;
        } else if (i === currentPage - 3 || i === currentPage + 3) {
            html += `<button disabled>...</button>`;
        }
    }
    
    html += `<button ${currentPage === totalPages ? 'disabled' : ''} onclick="loadReports(${currentPage + 1})">
        التالي <i class="fas fa-chevron-left"></i>
    </button>`;
    
    container.innerHTML = html;
}

// View report details
async function viewReport(reportId) {
    if (!reportId || reportId === 0) {
        alert('خطأ: معرف البلاغ غير صحيح');
        return;
    }
    
    const modal = document.getElementById('reportModal');
    const details = document.getElementById('reportDetails');
    
    if (!modal || !details) {
        alert('خطأ: عناصر الواجهة غير موجودة');
        return;
    }
    
    // Show loading
    modal.classList.add('active');
    details.innerHTML = '<div class="spinner"></div> جاري التحميل...';
    
    try {
        const data = await apiRequest(`reports.php?id=${reportId}`);
        
        if (!data) {
            details.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">حدث خطأ في الاتصال بالخادم</p>';
            return;
        }
        
        if (!data.success) {
            details.innerHTML = `<p style="padding: 20px; text-align: center; color: var(--danger-color);">${data.message || 'حدث خطأ'}</p>`;
            return;
        }
        
        const report = data.data;
        
        if (!report) {
            details.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">البلاغ غير موجود</p>';
            return;
        }
        
        // Ensure report.id exists
        report.id = parseInt(report.id || report.report_id || reportId);
        
        displayReportDetails(report);
        currentReportId = report.id;
        
    } catch (error) {
        console.error('Error loading report:', error);
        details.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--danger-color);">حدث خطأ في تحميل بيانات البلاغ</p>';
    }
}

// Display report details
function displayReportDetails(report) {
    const details = document.getElementById('reportDetails');
    
    const reasonLabels = {
        'fake': 'مزيف',
        'wrong_info': 'معلومات خاطئة',
        'fraud': 'احتيال',
        'other': 'أخرى'
    };
    
    const adDeleted = report.ad_deleted || !report.ad_title;
    const reportId = parseInt(report.id);
    const adId = report.ad_id ? parseInt(report.ad_id) : null;
    
    let html = `
        <div class="details-section">
            <div class="details-card">
                <h3>معلومات البلاغ</h3>
                <div class="details-row">
                    <div class="details-label">السبب:</div>
                    <div class="details-value"><span class="badge badge-danger">${reasonLabels[report.reason] || report.reason}</span></div>
                </div>
                <div class="details-row">
                    <div class="details-label">المبلغ:</div>
                    <div class="details-value">
                        <strong>${report.reporter_name || 'غير معروف'}</strong>
                        ${report.reporter_phone ? ` - ${report.reporter_phone}` : ''}
                    </div>
                </div>
                <div class="details-row">
                    <div class="details-label">نص البلاغ:</div>
                    <div class="details-value">${report.description || 'لا يوجد وصف'}</div>
                </div>
                <div class="details-row">
                    <div class="details-label">حالة البلاغ:</div>
                    <div class="details-value">
                        <span id="reportStatusBadge">${report.status === 'open' ? '<span class="badge badge-warning">مفتوح</span>' : '<span class="badge badge-success">مغلق</span>'}</span>
                        <select id="reportStatusSelect" onchange="updateReportStatus(${reportId}, this.value)" style="margin-right: 10px; padding: 5px; border-radius: 4px; border: 1px solid var(--border-color);">
                            <option value="open" ${report.status === 'open' ? 'selected' : ''}>مفتوح</option>
                            <option value="closed" ${report.status === 'closed' ? 'selected' : ''}>مغلق</option>
                        </select>
                    </div>
                </div>
                <div class="details-row">
                    <div class="details-label">تاريخ ووقت البلاغ:</div>
                    <div class="details-value"><strong>${formatDateTime(report.created_at)}</strong></div>
                </div>
            </div>
        </div>
        
        <div class="details-section">
            <div class="details-card">
                <h3>معلومات الإعلان المعني</h3>
                ${adDeleted ? `
                <div class="alert alert-warning" style="padding: 12px; background: #fef3c7; border: 1px solid #f59e0b; border-radius: 8px; margin-bottom: 15px;">
                    <i class="fas fa-exclamation-triangle"></i> <strong>تنبيه:</strong> هذا الإعلان محذوف مسبقاً
                </div>
                ` : ''}
                <div class="details-row">
                    <div class="details-label">عنوان الإعلان:</div>
                    <div class="details-value">
                        ${report.ad_title ? `<strong>${report.ad_title}</strong>` : '<span style="color: var(--text-secondary);">إعلان محذوف</span>'}
                        ${adId && !adDeleted ? `<a href="ads.html?id=${adId}" target="_blank" rel="noopener noreferrer" class="btn btn-sm btn-primary" style="margin-right: 10px; margin-top: 5px;">
                            <i class="fas fa-external-link-alt"></i> عرض الإعلان
                        </a>` : ''}
                    </div>
                </div>
                <div class="details-row">
                    <div class="details-label">مالك الإعلان:</div>
                    <div class="details-value">
                        <strong>${report.ad_owner_name || 'غير معروف'}</strong>
                        ${report.ad_owner_phone ? ` - ${report.ad_owner_phone}` : ''}
                    </div>
                </div>
                <div class="details-row">
                    <div class="details-label">حالة الإعلان:</div>
                    <div class="details-value">
                        ${adDeleted ? '<span class="badge badge-danger">محذوف</span>' :
                          report.ad_status === 'published' ? '<span class="badge badge-success">منشور</span>' : 
                          report.ad_status === 'pending' ? '<span class="badge badge-warning">قيد المراجعة</span>' : 
                          report.ad_status === 'rejected' ? '<span class="badge badge-danger">مرفوض</span>' : 
                          '<span class="badge badge-secondary">غير معروف</span>'}
                    </div>
                </div>
                ${adId ? `
                <div class="details-row">
                    <div class="details-label">معرف الإعلان:</div>
                    <div class="details-value"><code>#${adId}</code></div>
                </div>
                ` : ''}
            </div>
        </div>
    `;
    
    // Media gallery section removed as per user request
    
    // Add actions section
    html += `
        <div class="details-section">
            <div class="details-card">
                <h3>إدارة البلاغ</h3>
                ${report.status === 'open' ? `
                <div class="action-buttons" style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 15px;">
                    <button class="btn btn-success" onclick="handleReport(${reportId}, 'close')" title="إغلاق البلاغ بدون إجراء">
                        <i class="fas fa-check-circle"></i> إغلاق البلاغ
                    </button>
                    ${!adDeleted && adId ? `
                    <button class="btn btn-warning" onclick="openWarnOwnerModal(${reportId}, ${adId})" title="إرسال تحذير لمالك الإعلان">
                        <i class="fas fa-exclamation-triangle"></i> تحذير المعلن
                    </button>
                    <button class="btn btn-danger" onclick="handleRejectAd(${reportId}, ${adId})" title="رفض الإعلان">
                        <i class="fas fa-times-circle"></i> رفض الإعلان
                    </button>
                    <button class="btn btn-danger" onclick="handleReport(${reportId}, 'delete_ad')" title="حذف الإعلان وإغلاق البلاغ">
                        <i class="fas fa-trash"></i> حذف الإعلان
                    </button>
                    ` : `
                    <button class="btn btn-secondary" disabled title="الإعلان محذوف مسبقاً">
                        <i class="fas fa-info-circle"></i> الإعلان محذوف مسبقاً
                    </button>
                    `}
                    <button class="btn btn-danger" onclick="handleReport(${reportId}, 'delete_report')" title="حذف البلاغ نهائياً">
                        <i class="fas fa-trash-alt"></i> حذف البلاغ
                    </button>
                </div>
                ` : `
                <div class="alert alert-info" style="padding: 12px; background: #dbeafe; border: 1px solid #3b82f6; border-radius: 8px; margin-bottom: 15px;">
                    <i class="fas fa-info-circle"></i> هذا البلاغ مغلق
                </div>
                <div class="action-buttons" style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 15px;">
                    <button class="btn btn-danger" onclick="handleReport(${reportId}, 'delete_report')" title="حذف البلاغ نهائياً">
                        <i class="fas fa-trash-alt"></i> حذف البلاغ
                    </button>
                </div>
                `}
            </div>
        </div>
    `;
    
    details.innerHTML = html;
}

// Close report modal
function closeReportModal() {
    const modal = document.getElementById('reportModal');
    if (modal) {
        modal.classList.remove('active');
    }
    currentReportId = null;
}

// Handle report action (close, delete_ad, delete_report)
async function handleReport(reportId, action) {
    if (!reportId || !action) {
        alert('خطأ في البيانات');
        return;
    }
    
    reportId = parseInt(reportId);
    
    let confirmMessage = '';
    
    if (action === 'close') {
        confirmMessage = 'هل أنت متأكد من إغلاق هذا البلاغ بدون اتخاذ أي إجراء؟';
    } else if (action === 'delete_ad') {
        confirmMessage = 'هل أنت متأكد من حذف الإعلان؟\n\nسيتم:\n- حذف الإعلان نهائياً\n- إغلاق البلاغ تلقائياً\n- إشعار مالك الإعلان';
    } else if (action === 'delete_report') {
        confirmMessage = 'هل أنت متأكد من حذف هذا البلاغ نهائياً؟\n\nهذا الإجراء لا يمكن التراجع عنه.';
    } else {
        alert('إجراء غير صحيح');
        return;
    }
    
    if (!confirm(confirmMessage)) {
        return;
    }
    
    try {
        const data = await apiRequest('reports.php', {
            method: 'PUT',
            body: JSON.stringify({
                report_id: reportId,
                action: action
            })
        });
        
        if (data && data.success) {
            alert(data.message || 'تم تنفيذ الإجراء بنجاح');
            closeReportModal();
            loadReports(currentPage);
        } else {
            alert(data.message || 'حدث خطأ في معالجة البلاغ');
        }
    } catch (error) {
        console.error('Error handling report:', error);
        alert('حدث خطأ في معالجة البلاغ: ' + (error.message || error));
    }
}

// Update report status
async function updateReportStatus(reportId, newStatus) {
    if (!reportId || !newStatus) {
        return;
    }
    
    reportId = parseInt(reportId);
    
    if (!confirm(`هل أنت متأكد من تغيير حالة البلاغ إلى ${newStatus === 'open' ? 'مفتوح' : 'مغلق'}؟`)) {
        // Reset select
        try {
            const report = await apiRequest(`reports.php?id=${reportId}`);
            if (report && report.success) {
                const select = document.getElementById('reportStatusSelect');
                if (select) {
                    select.value = report.data.status;
                }
            }
        } catch (e) {
            console.error('Error resetting status:', e);
        }
        return;
    }
    
    try {
        const data = await apiRequest('reports.php', {
            method: 'PUT',
            body: JSON.stringify({
                report_id: reportId,
                action: 'update_status',
                status: newStatus
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            // Update badge
            const badge = document.getElementById('reportStatusBadge');
            if (badge) {
                badge.innerHTML = newStatus === 'open' ? '<span class="badge badge-warning">مفتوح</span>' : '<span class="badge badge-success">مغلق</span>';
            }
            // Reload report details
            viewReport(reportId);
        } else {
            alert(data.message || 'حدث خطأ في تحديث حالة البلاغ');
            // Reset select
            try {
                const report = await apiRequest(`reports.php?id=${reportId}`);
                if (report && report.success) {
                    const select = document.getElementById('reportStatusSelect');
                    if (select) {
                        select.value = report.data.status;
                    }
                }
            } catch (e) {
                console.error('Error resetting status:', e);
            }
        }
    } catch (error) {
        console.error('Error updating report status:', error);
        alert('حدث خطأ في تحديث حالة البلاغ');
        // Reset select
        try {
            const report = await apiRequest(`reports.php?id=${reportId}`);
            if (report && report.success) {
                const select = document.getElementById('reportStatusSelect');
                if (select) {
                    select.value = report.data.status;
                }
            }
        } catch (e) {
            console.error('Error resetting status:', e);
        }
    }
}

// Open warn owner modal
function openWarnOwnerModal(reportId, adId) {
    if (!adId) {
        alert('الإعلان غير موجود');
        return;
    }
    
    reportId = parseInt(reportId);
    adId = parseInt(adId);
    
    document.getElementById('warnOwnerReportId').value = reportId;
    document.getElementById('warnOwnerAdId').value = adId;
    document.getElementById('warnOwnerMessage').value = '';
    
    document.getElementById('warnOwnerModal').classList.add('active');
}

// Close warn owner modal
function closeWarnOwnerModal() {
    document.getElementById('warnOwnerModal').classList.remove('active');
}

// Submit warn owner
async function submitWarnOwner() {
    const reportId = parseInt(document.getElementById('warnOwnerReportId').value);
    const adId = parseInt(document.getElementById('warnOwnerAdId').value);
    const warningMessage = document.getElementById('warnOwnerMessage').value.trim();
    
    if (!reportId || !adId) {
        alert('خطأ في البيانات');
        return;
    }
    
    if (!warningMessage) {
        if (!confirm('لم تدخل رسالة تحذير. هل تريد استخدام الرسالة الافتراضية؟')) {
            return;
        }
    }
    
    try {
        const data = await apiRequest('reports.php', {
            method: 'PUT',
            body: JSON.stringify({
                report_id: reportId,
                action: 'warn_owner',
                warning_message: warningMessage || null
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            closeWarnOwnerModal();
            closeReportModal();
            loadReports(currentPage);
        } else {
            alert(data.message || 'حدث خطأ في معالجة البلاغ');
        }
    } catch (error) {
        console.error('Error handling warn owner:', error);
        alert('حدث خطأ في معالجة البلاغ: ' + (error.message || error));
    }
}

// Handle reject ad
function handleRejectAd(reportId, adId) {
    if (!adId) {
        alert('الإعلان غير موجود');
        return;
    }
    
    // Open reject modal
    document.getElementById('rejectAdReportId').value = reportId;
    document.getElementById('rejectAdId').value = adId;
    document.getElementById('rejectAdReason').value = '';
    document.getElementById('rejectAdModal').classList.add('active');
}

function closeRejectAdModal() {
    document.getElementById('rejectAdModal').classList.remove('active');
    document.getElementById('rejectAdReason').value = '';
}
