// Banners Management
let currentBannerId = null;

document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
    }
    
    loadBanners();
    
    document.getElementById('bannerForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveBanner();
    });
});

async function loadBanners() {
    try {
        const data = await apiRequest('banners.php');
        
        if (data && data.success) {
            displayBanners(data.data);
        }
    } catch (error) {
        console.error('Error loading banners:', error);
    }
}

function displayBanners(banners) {
    const container = document.getElementById('bannersTable');
    
    if (!banners || banners.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد بانرات</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد البانرات:</strong> ${banners.length} ${banners.length === 1 ? 'بانر' : 'بانر'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>الصورة</th>
                    <th>اسم المعلن</th>
                    <th>التكلفة</th>
                    <th>تاريخ البداية</th>
                    <th>تاريخ النهاية</th>
                    <th>الحالة</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    banners.forEach(banner => {
        const statusBadge = banner.active == 1
            ? '<span class="badge badge-success">نشط</span>'
            : '<span class="badge badge-secondary">معطل</span>';
        
        // تحديد مسار الصورة بشكل صحيح
        let imageUrl = banner.image_url;
        if (!imageUrl.startsWith('http') && !imageUrl.startsWith('../')) {
            imageUrl = '../' + imageUrl;
        }
        
        html += `
            <tr>
                <td>
                    <img src="${imageUrl}" 
                         style="width: 100px; height: 60px; object-fit: cover; border-radius: 4px; cursor: pointer; transition: transform 0.2s ease; display: block; border: 1px solid #e0e0e0;" 
                         alt="بانر" 
                         onclick="openMediaViewer([{type: 'image', path: this.src}], 0); event.stopPropagation();" 
                         onmouseover="this.style.transform='scale(1.05)'" 
                         onmouseout="this.style.transform='scale(1)'" 
                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex'; console.error('خطأ في تحميل الصورة:', '${imageUrl}');">
                    <div style="display: none; width: 100px; height: 60px; background-color: #f5f5f5; border-radius: 4px; align-items: center; justify-content: center; border: 1px solid #e0e0e0;">
                        <span style="color: var(--text-secondary); font-size: 12px; text-align: center;">لا توجد صورة</span>
                    </div>
                </td>
                <td>${banner.sponsor_name}</td>
                <td>$${banner.cost}</td>
                <td>${banner.start_date}</td>
                <td>${banner.end_date}</td>
                <td>${statusBadge}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="viewBannerDetails(${banner.id})" title="عرض التفاصيل">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-success" onclick="editBanner(${banner.id})" title="تعديل">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="deleteBanner(${banner.id})" title="حذف">
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

function openBannerModal(banner = null) {
    currentBannerId = banner ? banner.id : null;
    document.getElementById('bannerModalTitle').textContent = banner ? 'تعديل البانر' : 'إضافة بانر جديد';
    document.getElementById('bannerForm').reset();
    document.getElementById('bannerImagePreview').innerHTML = '';
    
    if (banner) {
        document.getElementById('bannerImageUrl').value = banner.image_url;
        document.getElementById('bannerLinkUrl').value = banner.link_url || '';
        document.getElementById('bannerSponsorName').value = banner.sponsor_name;
        document.getElementById('bannerSponsorPhone').value = banner.sponsor_phone;
        document.getElementById('bannerCost').value = banner.cost;
        document.getElementById('bannerStartDate').value = banner.start_date;
        document.getElementById('bannerEndDate').value = banner.end_date;
        document.getElementById('bannerActive').checked = banner.active == 1;
        
        // Show preview - تحديد مسار الصورة بشكل صحيح
        let previewImageUrl = banner.image_url;
        if (!previewImageUrl.startsWith('http') && !previewImageUrl.startsWith('../')) {
            previewImageUrl = '../' + previewImageUrl;
        }
        
        document.getElementById('bannerImagePreview').innerHTML = `
            <img src="${previewImageUrl}" 
                 style="max-width: 100%; max-height: 300px; border-radius: 12px; box-shadow: var(--shadow-lg); object-fit: contain;" 
                 alt="بانر"
                 onerror="this.style.display='none'; this.nextElementSibling.style.display='block'; console.error('خطأ في تحميل معاينة الصورة:', '${previewImageUrl}');">
            <p style="display: none; color: var(--error-color); text-align: center; padding: 20px;">فشل تحميل معاينة الصورة</p>
        `;
    }
    
    document.getElementById('bannerModal').classList.add('active');
}

function closeBannerModal() {
    document.getElementById('bannerModal').classList.remove('active');
    currentBannerId = null;
    document.getElementById('bannerForm').reset();
    document.getElementById('bannerImagePreview').innerHTML = '';
}

async function previewBannerImage() {
    const file = document.getElementById('bannerImage').files[0];
    if (!file) return;
    
    // Upload image first
    const formData = new FormData();
    formData.append('file', file);
    formData.append('type', 'banner');
    
    const token = getAuthToken();
    
    try {
        const response = await fetch('api/upload.php', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData
        });
        
        const data = await response.json();
        
        if (data.success) {
            document.getElementById('bannerImageUrl').value = data.url;
            
            // تحديد مسار المعاينة بشكل صحيح
            let previewUrl = data.url;
            if (!previewUrl.startsWith('http') && !previewUrl.startsWith('../')) {
                previewUrl = '../' + previewUrl;
            }
            
            console.log('تم رفع الصورة بنجاح:', {
                url: data.url,
                previewUrl: previewUrl,
                filename: data.filename
            });
            
            document.getElementById('bannerImagePreview').innerHTML = `
                <img src="${previewUrl}" 
                     style="max-width: 100%; max-height: 300px; border-radius: 12px; box-shadow: var(--shadow-lg); object-fit: contain;" 
                     alt="بانر"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='block'; console.error('خطأ في تحميل معاينة الصورة:', '${previewUrl}');">
                <p style="display: none; color: var(--error-color); text-align: center; padding: 20px;">فشل تحميل معاينة الصورة</p>
            `;
        } else {
            console.error('فشل رفع الصورة:', data);
            let errorMsg = data.message || 'فشل رفع الصورة';
            if (data.debug) {
                console.error('معلومات إضافية:', data.debug);
                errorMsg += '\n\nمعلومات فنية:\n';
                errorMsg += 'المجلد موجود: ' + (data.debug.dirExists ? 'نعم' : 'لا') + '\n';
                errorMsg += 'قابل للكتابة: ' + (data.debug.isWritable ? 'نعم' : 'لا');
            }
            alert(errorMsg);
        }
    } catch (error) {
        console.error('Error uploading image:', error);
        alert('حدث خطأ في رفع الصورة: ' + error.message);
    }
}

async function saveBanner() {
    const imageUrl = document.getElementById('bannerImageUrl').value;
    if (!imageUrl) {
        alert('يرجى رفع صورة البانر');
        return;
    }
    
    const bannerData = {
        image_url: imageUrl,
        link_url: document.getElementById('bannerLinkUrl').value || null,
        sponsor_name: document.getElementById('bannerSponsorName').value,
        sponsor_phone: document.getElementById('bannerSponsorPhone').value,
        cost: parseFloat(document.getElementById('bannerCost').value),
        start_date: document.getElementById('bannerStartDate').value,
        end_date: document.getElementById('bannerEndDate').value,
        active: document.getElementById('bannerActive').checked ? 1 : 0
    };
    
    try {
        const endpoint = currentBannerId ? 'banners.php' : 'banners.php';
        const method = currentBannerId ? 'PUT' : 'POST';
        
        if (currentBannerId) {
            bannerData.id = currentBannerId;
        }
        
        const data = await apiRequest(endpoint, {
            method: method,
            body: JSON.stringify(bannerData)
        });
        
        if (data && data.success) {
            alert(data.message);
            closeBannerModal();
            loadBanners();
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error saving banner:', error);
        alert('حدث خطأ في حفظ البانر');
    }
}

async function editBanner(bannerId) {
    try {
        const data = await apiRequest('banners.php');
        
        if (data && data.success) {
            const banner = data.data.find(b => b.id == bannerId);
            if (banner) {
                openBannerModal(banner);
            }
        }
    } catch (error) {
        console.error('Error loading banner:', error);
    }
}

async function viewBannerDetails(bannerId) {
    try {
        const data = await apiRequest('banners.php');
        
        if (data && data.success) {
            const banner = data.data.find(b => b.id == bannerId);
            if (banner) {
                const modal = document.getElementById('bannerDetailsModal');
                const details = document.getElementById('bannerDetails');
                
                // تحديد مسار الصورة بشكل صحيح
                let detailsImageUrl = banner.image_url;
                if (detailsImageUrl && !detailsImageUrl.startsWith('http') && !detailsImageUrl.startsWith('../')) {
                    detailsImageUrl = '../' + detailsImageUrl;
                }
                
                let html = `
                    <div class="details-section">
                        <div class="details-card">
                            <h3>معلومات البانر</h3>
                            ${banner.image_url ? `
                            <div class="details-row" style="grid-template-columns: 1fr; text-align: center; margin-bottom: 20px;">
                                <div class="details-value">
                                    <img src="${detailsImageUrl}" 
                                         alt="صورة البانر" 
                                         class="banner-clickable-image" 
                                         style="max-width: 100%; max-height: 400px; border-radius: 12px; box-shadow: var(--shadow-lg); object-fit: contain; cursor: pointer; transition: transform 0.3s ease; border: 1px solid #e0e0e0;" 
                                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'400\' height=\'200\'%3E%3Crect fill=\'%23ddd\' width=\'400\' height=\'200\'/%3E%3Ctext fill=\'%23999\' font-family=\'sans-serif\' font-size=\'16\' dy=\'10.5\' font-weight=\'bold\' x=\'50%25\' y=\'50%25\' text-anchor=\'middle\'%3Eصورة البانر غير متوفرة%3C/text%3E%3C/svg%3E'; this.style.border='2px dashed #ccc'; console.error('خطأ في تحميل صورة البانر:', '${detailsImageUrl}');" 
                                         onmouseover="this.style.transform='scale(1.02)'" 
                                         onmouseout="this.style.transform='scale(1)'">
                                </div>
                            </div>
                            ` : ''}
                            <div class="details-row">
                                <div class="details-label">اسم المعلن:</div>
                                <div class="details-value">${banner.sponsor_name}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">رقم هاتف المعلن:</div>
                                <div class="details-value">${banner.sponsor_phone}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">رابط الوجهة:</div>
                                <div class="details-value">${banner.link_url ? `<a href="${banner.link_url}" target="_blank" rel="noopener noreferrer">${banner.link_url}</a>` : 'لا يوجد'}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">التكلفة:</div>
                                <div class="details-value">$${banner.cost}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">تاريخ البداية:</div>
                                <div class="details-value">${banner.start_date}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">تاريخ النهاية:</div>
                                <div class="details-value">${banner.end_date}</div>
                            </div>
                            <div class="details-row">
                                <div class="details-label">الحالة:</div>
                                <div class="details-value">
                                    ${banner.active == 1 ? '<span class="badge badge-success">نشط</span>' : '<span class="badge badge-secondary">معطل</span>'}
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                
                details.innerHTML = html;
                modal.classList.add('active');
                
                // Make banner image clickable
                if (banner.image_url) {
                    setTimeout(() => {
                        const bannerImg = document.querySelector('.banner-clickable-image');
                        if (bannerImg && bannerImg.complete) {
                            const imgSrc = bannerImg.src;
                            bannerImg.addEventListener('click', function() {
                                openMediaViewer([{type: 'image', path: imgSrc}], 0);
                            });
                        }
                    }, 100);
                }
            }
        }
    } catch (error) {
        console.error('Error loading banner details:', error);
        alert('حدث خطأ في تحميل تفاصيل البانر');
    }
}

function closeBannerDetailsModal() {
    document.getElementById('bannerDetailsModal').classList.remove('active');
}

async function deleteBanner(bannerId) {
    if (!confirm('هل أنت متأكد من حذف هذا البانر؟')) return;
    
    try {
        const data = await apiRequest(`banners.php?id=${bannerId}`, {
            method: 'DELETE'
        });
        
        if (data && data.success) {
            alert(data.message);
            loadBanners();
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error deleting banner:', error);
        alert('حدث خطأ في حذف البانر');
    }
}

