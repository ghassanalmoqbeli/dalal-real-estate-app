// Dashboard functionality
document.addEventListener('DOMContentLoaded', async function() {
    checkAuth();
    
    // Set admin username
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
    
    // Load dashboard data
    await loadDashboardData();
});

async function loadDashboardData() {
    try {
        const data = await apiRequest('dashboard.php');
        
        if (data && data.success) {
            // Update stats
            document.getElementById('totalUsers').textContent = data.stats.total_users;
            document.getElementById('publishedAds').textContent = data.stats.published_ads;
            document.getElementById('pendingAds').textContent = data.stats.pending_ads;
            document.getElementById('rejectedAds').textContent = data.stats.rejected_ads;
            document.getElementById('openReports').textContent = data.stats.open_reports;
            document.getElementById('featuredAds').textContent = data.stats.featured_ads;
            
            // Display recent pending ads
            displayRecentPendingAds(data.recent_pending_ads);
            
            // Display recent reports
            displayRecentReports(data.recent_reports);
        }
    } catch (error) {
        console.error('Error loading dashboard:', error);
    }
}

function displayRecentPendingAds(ads) {
    const container = document.getElementById('recentPendingAds');
    
    if (!ads || ads.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد إعلانات قيد المراجعة</p>';
        return;
    }
    
    let html = '<table class="table"><thead><tr><th>العنوان</th><th>المالك</th><th>التاريخ</th><th>الإجراءات</th></tr></thead><tbody>';
    
    ads.forEach(ad => {
        html += `
            <tr>
                <td>${ad.title}</td>
                <td>${ad.user_name || 'غير معروف'}</td>
                <td>${formatDateTime(ad.created_at)}</td>
                <td>
                    <a href="ads.html?id=${ad.id}" class="btn btn-sm btn-primary">
                        <i class="fas fa-eye"></i> عرض
                    </a>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

function displayRecentReports(reports) {
    const container = document.getElementById('recentReports');
    
    if (!reports || reports.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد بلاغات جديدة</p>';
        return;
    }
    
    let html = '<table class="table"><thead><tr><th>السبب</th><th>المبلغ</th><th>التاريخ</th><th>الإجراءات</th></tr></thead><tbody>';
    
    reports.forEach(report => {
        const reasonLabels = {
            'fake': 'مزيف',
            'wrong_info': 'معلومات خاطئة',
            'fraud': 'احتيال',
            'other': 'أخرى'
        };
        
        html += `
            <tr>
                <td><span class="badge badge-warning">${reasonLabels[report.reason] || report.reason}</span></td>
                <td>${report.reporter_name || 'غير معروف'}</td>
                <td>${formatDateTime(report.created_at)}</td>
                <td>
                    <a href="reports.html?id=${report.id}" class="btn btn-sm btn-primary">
                        <i class="fas fa-eye"></i> عرض
                    </a>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

// Use formatDateTime from common.js

