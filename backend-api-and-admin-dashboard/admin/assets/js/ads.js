// Ads Management
let currentPage = 1;
let totalPages = 1;
let currentAdId = null;

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
    
    // Check URL params for specific ad
    const urlParams = new URLSearchParams(window.location.search);
    const adId = urlParams.get('id');
    const status = urlParams.get('status');
    
    if (status) {
        document.getElementById('statusFilter').value = status;
    }
    
    if (adId) {
        viewAd(adId);
    }
    
    loadAds();
    
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            loadAds();
        }
    });
    
    document.getElementById('rejectForm').addEventListener('submit', function(e) {
        e.preventDefault();
        rejectAd();
    });
});

async function loadAds(page = 1) {
    currentPage = page;
    
    const search = document.getElementById('searchInput').value;
    const status = document.getElementById('statusFilter').value;
    const type = document.getElementById('typeFilter').value;
    const city = document.getElementById('cityFilter').value;
    
    const params = new URLSearchParams({
        page: page,
        limit: 20
    });
    
    if (search) params.append('search', search);
    if (status) params.append('status', status);
    if (type) params.append('type', type);
    if (city) params.append('city', city);
    
    try {
        const data = await apiRequest(`ads.php?${params.toString()}`);
        
        if (data && data.success) {
            displayAds(data.data);
            totalPages = data.pagination.pages;
            displayPagination();
        }
    } catch (error) {
        console.error('Error loading ads:', error);
    }
}

function displayAds(ads) {
    const container = document.getElementById('adsTable');
    
    if (!ads || ads.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد نتائج</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد الإعلانات:</strong> ${ads.length} ${ads.length === 1 ? 'إعلان' : 'إعلان'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>العنوان</th>
                    <th>المالك</th>
                    <th>النوع</th>
                    <th>المدينة</th>
                    <th>السعر</th>
                    <th>الحالة</th>
                    <th>التاريخ</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    ads.forEach(ad => {
        const statusBadges = {
            'pending': '<span class="badge badge-warning">قيد المراجعة</span>',
            'published': '<span class="badge badge-success">منشور</span>',
            'rejected': '<span class="badge badge-danger">مرفوض</span>'
        };
        
        const typeLabels = {
            'apartment': 'شقة',
            'house': 'منزل',
            'land': 'أرض',
            'shop': 'دكان'
        };
        
        const cityLabels = {
            'sanaa': 'صنعاء',
            'taiz': 'تعز',
            'aden': 'عدن',
            'ibb': 'إب',
            'dhamar': 'ذمار',
            'hodeidah': 'الحديدة',
            'hadramout': 'حضرموت',
            'yareem': 'يريم',
            'saada': 'صعدة',
            'amran': 'عمران',
            'raymah': 'ريمة',
            'mahweet': 'المحويت',
            'haggah': 'حجة',
            'lahj': 'لحج',
            'mahrah': 'المهرة',
            'shabwa': 'شبوة',
            'marib': 'مأرب',
            'aljawf': 'الجوف',
            'albayda': 'البيضاء',
            'aldhale': 'الضالع',
            'socotra': 'سقطرى',
            'abian': 'أبين'
        };
        
        // Check if featured - handle both string and number
        const isFeatured = ad.is_featured == 1 || ad.is_featured === '1' || ad.is_featured === true;
        
        html += `
            <tr>
                <td>${ad.id}</td>
                <td>${ad.title}${isFeatured ? ' <i class="fas fa-star" style="color: #f59e0b; margin-right: 5px;" title="إعلان مميز"></i>' : ''}</td>
                <td>${ad.user_name || 'غير معروف'}</td>
                <td>${typeLabels[ad.type] || ad.type}</td>
                <td>${cityLabels[ad.city] || ad.city}</td>
                <td>${ad.price} ${ad.currency}</td>
                <td>${statusBadges[ad.status] || ad.status}</td>
                <td>${formatDateTime(ad.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="viewAd(${ad.id})" title="عرض التفاصيل">
                            <i class="fas fa-eye"></i>
                        </button>
                        ${ad.status === 'rejected' || ad.status === 'pending' ? `
                            <button class="btn btn-sm btn-success" onclick="approveAd(${ad.id})" title="نشر الإعلان">
                                <i class="fas fa-check"></i>
                            </button>
                        ` : ''}
                        ${ad.status === 'pending' || ad.status === 'published' ? `
                            <button class="btn btn-sm btn-warning" onclick="openRejectModal(${ad.id})" title="رفض الإعلان">
                                <i class="fas fa-times"></i>
                            </button>
                        ` : ''}
                        <button class="btn btn-sm btn-danger" onclick="deleteAd(${ad.id})" title="حذف الإعلان">
                            <i class="fas fa-trash"></i>
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
    html += `<button ${currentPage === 1 ? 'disabled' : ''} onclick="loadAds(${currentPage - 1})">
        <i class="fas fa-chevron-right"></i> السابق
    </button>`;
    
    for (let i = 1; i <= totalPages; i++) {
        if (i === 1 || i === totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
            html += `<button class="${i === currentPage ? 'active' : ''}" onclick="loadAds(${i})">${i}</button>`;
        } else if (i === currentPage - 3 || i === currentPage + 3) {
            html += `<button disabled>...</button>`;
        }
    }
    
    html += `<button ${currentPage === totalPages ? 'disabled' : ''} onclick="loadAds(${currentPage + 1})">
        التالي <i class="fas fa-chevron-left"></i>
    </button>`;
    
    container.innerHTML = html;
}

async function viewAd(adId) {
    try {
        const data = await apiRequest(`ads.php?id=${adId}`);
        
        if (data && data.success) {
            const ad = data.data;
            const modal = document.getElementById('adModal');
            const details = document.getElementById('adDetails');
            
            // Debug: Log media data
            console.log('Ad data received:', ad);
            console.log('Media count:', ad.media ? ad.media.length : 0);
            if (ad.media && ad.media.length > 0) {
                console.log('Media items:', ad.media);
            }
            
            const typeLabels = {
                'apartment': 'شقة',
                'house': 'منزل',
                'land': 'أرض',
                'shop': 'دكان'
            };
            
            const offerTypeLabels = {
                'sale_freehold': 'تمليك حر',
                'sale_waqf': 'تمليك وقف',
                'rent': 'إيجار'
            };
            
            const cityLabels = {
                'sanaa': 'صنعاء',
                'taiz': 'تعز',
                'aden': 'عدن',
                'ibb': 'إب',
                'dhamar': 'ذمار',
                'hodeidah': 'الحديدة',
                'hadramout': 'حضرموت',
                'yareem': 'يريم',
                'saada': 'صعدة',
                'amran': 'عمران',
                'raymah': 'ريمة',
                'mahweet': 'المحويت',
                'haggah': 'حجة',
                'lahj': 'لحج',
                'mahrah': 'المهرة',
                'shabwa': 'شبوة',
                'marib': 'مأرب',
                'aljawf': 'الجوف',
                'albayda': 'البيضاء',
                'aldhale': 'الضالع',
                'socotra': 'سقطرى',
                'abian': 'أبين'
            };
            
            const statusBadges = {
                'pending': '<span class="badge badge-warning">قيد المراجعة</span>',
                'published': '<span class="badge badge-success">منشور</span>',
                'rejected': '<span class="badge badge-danger">مرفوض</span>'
            };
            
            // Check if featured
            const isFeatured = ad.featured ? true : false;
            
            let html = `
                <div class="details-section">
                    <div class="details-card">
                        <h3>${ad.title}${isFeatured ? ' <i class="fas fa-star" style="color: #f59e0b; margin-right: 5px;" title="إعلان مميز"></i>' : ''}</h3>
                        <div class="details-row">
                            <div class="details-label">المعرف (ID):</div>
                            <div class="details-value">#${ad.id}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">المالك:</div>
                            <div class="details-value">${ad.user_name} - ${ad.user_phone}</div>
                        </div>
                        ${ad.user_whatsapp ? `
                        <div class="details-row">
                            <div class="details-label">واتساب:</div>
                            <div class="details-value">${ad.user_whatsapp}</div>
                        </div>
                        ` : ''}
                        <div class="details-row">
                            <div class="details-label">النوع:</div>
                            <div class="details-value">${typeLabels[ad.type] || ad.type}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">نوع العرض:</div>
                            <div class="details-value">${offerTypeLabels[ad.offer_type] || ad.offer_type}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">المدينة:</div>
                            <div class="details-value">${cityLabels[ad.city] || ad.city}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">الموقع:</div>
                            <div class="details-value">${ad.location_text}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">السعر:</div>
                            <div class="details-value">${ad.price} ${ad.currency} ${ad.negotiable == 1 ? '<span class="badge badge-info">قابل للتفاوض</span>' : ''}</div>
                        </div>
                        <div class="details-row">
                            <div class="details-label">المساحة:</div>
                            <div class="details-value">${ad.area} متر مربع</div>
                        </div>
                        ${ad.rooms ? `
                        <div class="details-row">
                            <div class="details-label">الغرف:</div>
                            <div class="details-value">${ad.rooms}</div>
                        </div>
                        ` : ''}
                        ${ad.bathrooms ? `
                        <div class="details-row">
                            <div class="details-label">الحمامات:</div>
                            <div class="details-value">${ad.bathrooms}</div>
                        </div>
                        ` : ''}
                        ${ad.floors ? `
                        <div class="details-row">
                            <div class="details-label">الطوابق:</div>
                            <div class="details-value">${ad.floors}</div>
                        </div>
                        ` : ''}
                        <div class="details-row">
                            <div class="details-label">الحالة:</div>
                            <div class="details-value">${statusBadges[ad.status] || ad.status}</div>
                        </div>
                        ${ad.reject_reason ? `
                        <div class="details-row">
                            <div class="details-label">سبب الرفض:</div>
                            <div class="details-value"><span class="badge badge-danger">${ad.reject_reason}</span></div>
                        </div>
                        ` : ''}
                        ${isFeatured ? `
                        <div class="details-row">
                            <div class="details-label">الباقة المميزة:</div>
                            <div class="details-value">
                                <span class="badge badge-warning">
                                    <i class="fas fa-star"></i> ${ad.featured.package_name || 'باقة مميزة'}
                                </span>
                                <br>
                                <small style="color: var(--text-secondary);">
                                    من ${formatDateTime(ad.featured.start_date)} إلى ${formatDateTime(ad.featured.end_date)}
                                </small>
                            </div>
                        </div>
                        ` : ''}
                        ${ad.google_map_url ? `
                        <div class="details-row">
                            <div class="details-label">الخريطة:</div>
                            <div class="details-value"><a href="${ad.google_map_url}" target="_blank" rel="noopener noreferrer" class="btn btn-sm btn-primary"><i class="fas fa-map-marker-alt"></i> عرض على الخريطة</a></div>
                        </div>
                        ` : ''}
                        ${ad.extra_details ? `
                        <div class="details-row" style="grid-template-columns: 1fr;">
                            <div class="details-value" style="padding: 15px; background-color: var(--bg-color); border-radius: 8px; margin-top: 10px;">
                                <strong>تفاصيل إضافية:</strong><br>${ad.extra_details}
                            </div>
                        </div>
                        ` : ''}
                        <div class="details-row">
                            <div class="details-label">تاريخ الإنشاء:</div>
                            <div class="details-value">${formatDateTime(ad.created_at)}</div>
                        </div>
                        ${ad.updated_at ? `
                        <div class="details-row">
                            <div class="details-label">آخر تحديث:</div>
                            <div class="details-value">${formatDateTime(ad.updated_at)}</div>
                        </div>
                        ` : ''}
                    </div>
                </div>
            `;
            
            if (ad.media && ad.media.length > 0) {
                html += `
                    <div class="details-section">
                        <div class="details-card">
                            <h3>الوسائط (${ad.media.length})</h3>
                            <div class="media-gallery">
                `;
                ad.media.forEach(media => {
                    // Build correct path from admin folder to api-app/storage
                    let mediaPath = media.file_path;
                    
                    // Remove any leading ../ from the path
                    mediaPath = mediaPath.replace(/^(\.\.\/)+/, '');
                    
                    // Build absolute path from admin folder
                    // admin/ads.html -> ../api-app/storage/ad_media/file.jpg
                    if (mediaPath.includes('storage/')) {
                        // Path already contains storage folder
                        mediaPath = '../api-app/' + mediaPath.substring(mediaPath.indexOf('storage/'));
                    } else if (mediaPath.includes('ad_media/')) {
                        // Path contains ad_media folder
                        mediaPath = '../api-app/storage/' + mediaPath.substring(mediaPath.indexOf('ad_media/'));
                    } else {
                        // Assume it's just the filename
                        mediaPath = '../api-app/storage/ad_media/' + mediaPath;
                    }
                    
                    if (media.type === 'image') {
                        html += `
                            <div class="media-item">
                                <img src="${mediaPath}" alt="صورة الإعلان" 
                                     onerror="this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'200\' height=\'200\'%3E%3Crect fill=\'%23ddd\' width=\'200\' height=\'200\'/%3E%3Ctext fill=\'%23999\' font-family=\'sans-serif\' font-size=\'14\' dy=\'10.5\' font-weight=\'bold\' x=\'50%25\' y=\'50%25\' text-anchor=\'middle\'%3Eصورة غير متوفرة%3C/text%3E%3C/svg%3E'; this.style.border='2px dashed #ccc'; console.error('Failed to load image:', '${mediaPath}');"
                                     onload="console.log('Image loaded successfully:', '${mediaPath}');">
                            </div>
                        `;
                    } else if (media.type === 'video') {
                        html += `
                            <div class="media-item">
                                <video controls preload="metadata"
                                       onerror="console.error('Failed to load video:', '${mediaPath}');"
                                       onloadedmetadata="console.log('Video loaded successfully:', '${mediaPath}');">
                                    <source src="${mediaPath}" type="video/mp4">
                                    المتصفح لا يدعم تشغيل الفيديو
                                </video>
                            </div>
                        `;
                    }
                });
                html += '</div></div></div>';
            } else {
                // Show message if no media found
                console.log('No media found for ad:', ad.id);
            }
            
            // Action buttons - show appropriate buttons based on status
            html += '<div class="action-buttons" style="margin-top: 20px; justify-content: center;">';
            
            // Show publish button for pending and rejected ads
            if (ad.status === 'rejected' || ad.status === 'pending') {
                html += `<button class="btn btn-success" onclick="approveAd(${ad.id}); closeAdModal();">
                    <i class="fas fa-check"></i> نشر الإعلان
                </button>`;
            }
            
            // Show reject button for pending and published ads
            if (ad.status === 'published' || ad.status === 'pending') {
                html += `<button class="btn btn-warning" onclick="openRejectModal(${ad.id})">
                    <i class="fas fa-times"></i> رفض الإعلان
                </button>`;
            }
            
            // Always show delete button for all statuses
            html += `<button class="btn btn-danger" onclick="if(confirm('هل أنت متأكد من حذف هذا الإعلان؟')) { deleteAd(${ad.id}); closeAdModal(); }">
                <i class="fas fa-trash"></i> حذف الإعلان
            </button>`;
            
            html += '</div>';
            
            details.innerHTML = html;
            modal.classList.add('active');
            
            // Make media clickable after adding to DOM
            if (ad.media && ad.media.length > 0) {
                // Wait for DOM to update
                setTimeout(() => {
                    makeMediaClickable('#adDetails .media-gallery');
                }, 100);
            }
        }
    } catch (error) {
        console.error('Error loading ad:', error);
        alert('حدث خطأ في تحميل بيانات الإعلان');
    }
}

function closeAdModal() {
    document.getElementById('adModal').classList.remove('active');
}

function openRejectModal(adId) {
    currentAdId = adId;
    document.getElementById('rejectModal').classList.add('active');
    document.getElementById('rejectReason').value = '';
}

function closeRejectModal() {
    document.getElementById('rejectModal').classList.remove('active');
    currentAdId = null;
}

async function rejectAd() {
    if (!currentAdId) return;
    
    const reason = document.getElementById('rejectReason').value;
    if (!reason.trim()) {
        alert('يرجى إدخال سبب الرفض');
        return;
    }
    
    try {
        const data = await apiRequest('ads.php', {
            method: 'PUT',
            body: JSON.stringify({
                ad_id: currentAdId,
                action: 'reject',
                reject_reason: reason
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            closeRejectModal();
            closeAdModal();
            loadAds(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error rejecting ad:', error);
        alert('حدث خطأ في رفض الإعلان');
    }
}

async function approveAd(adId) {
    if (!confirm('هل أنت متأكد من نشر هذا الإعلان؟')) return;
    
    try {
        const data = await apiRequest('ads.php', {
            method: 'PUT',
            body: JSON.stringify({
                ad_id: adId,
                action: 'approve'
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            closeAdModal();
            loadAds(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error approving ad:', error);
        alert('حدث خطأ في نشر الإعلان');
    }
}

async function deleteAd(adId) {
    if (!confirm('هل أنت متأكد من حذف هذا الإعلان؟')) return;
    
    try {
        const data = await apiRequest('ads.php', {
            method: 'PUT',
            body: JSON.stringify({
                ad_id: adId,
                action: 'delete'
            })
        });
        
        if (data && data.success) {
            alert(data.message);
            loadAds(currentPage);
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error deleting ad:', error);
        alert('حدث خطأ في حذف الإعلان');
    }
}

// Use formatDateTime from common.js

