// Packages Management
let currentPackageId = null;

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
    
    loadPackages();
    
    document.getElementById('packageForm').addEventListener('submit', function(e) {
        e.preventDefault();
        savePackage();
    });
});

async function loadPackages() {
    try {
        const data = await apiRequest('packages.php');
        
        if (data && data.success) {
            displayPackages(data.data);
        }
    } catch (error) {
        console.error('Error loading packages:', error);
    }
}

function displayPackages(packages) {
    const container = document.getElementById('packagesTable');
    
    if (!packages || packages.length === 0) {
        container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--text-secondary);">لا توجد باقات</p>';
        return;
    }
    
    let html = `
        <div style="margin-bottom: 15px; padding: 12px; background: var(--card-bg); border-radius: 8px; border-right: 3px solid var(--primary-color);">
            <strong>عدد الباقات:</strong> ${packages.length} ${packages.length === 1 ? 'باقة' : 'باقة'}
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>اسم الباقة</th>
                    <th>المدة (أيام)</th>
                    <th>السعر</th>
                    <th>تاريخ الإنشاء</th>
                    <th>الإجراءات</th>
                </tr>
            </thead>
            <tbody>
    `;
    
    packages.forEach(pkg => {
        html += `
            <tr>
                <td><strong>${pkg.name}</strong></td>
                <td>${pkg.duration_days}</td>
                <td>$${pkg.price}</td>
                <td>${formatDateTime(pkg.created_at)}</td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-sm btn-primary" onclick="editPackage(${pkg.id})">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="deletePackage(${pkg.id})">
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

function openPackageModal(package = null) {
    currentPackageId = package ? package.id : null;
    document.getElementById('packageModalTitle').textContent = package ? 'تعديل الباقة' : 'إضافة باقة جديدة';
    document.getElementById('packageForm').reset();
    
    if (package) {
        document.getElementById('packageName').value = package.name;
        document.getElementById('packageDuration').value = package.duration_days;
        document.getElementById('packagePrice').value = package.price;
    }
    
    document.getElementById('packageModal').classList.add('active');
}

function closePackageModal() {
    document.getElementById('packageModal').classList.remove('active');
    currentPackageId = null;
    document.getElementById('packageForm').reset();
}

async function savePackage() {
    const packageData = {
        name: document.getElementById('packageName').value,
        duration_days: parseInt(document.getElementById('packageDuration').value),
        price: parseInt(document.getElementById('packagePrice').value)
    };
    
    if (currentPackageId) {
        packageData.id = currentPackageId;
    }
    
    try {
        const endpoint = 'packages.php';
        const method = currentPackageId ? 'PUT' : 'POST';
        
        const data = await apiRequest(endpoint, {
            method: method,
            body: JSON.stringify(packageData)
        });
        
        if (data && data.success) {
            alert(data.message);
            closePackageModal();
            loadPackages();
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error saving package:', error);
        alert('حدث خطأ في حفظ الباقة');
    }
}

async function editPackage(packageId) {
    try {
        const data = await apiRequest('packages.php');
        
        if (data && data.success) {
            const pkg = data.data.find(p => p.id == packageId);
            if (pkg) {
                openPackageModal(pkg);
            }
        }
    } catch (error) {
        console.error('Error loading package:', error);
    }
}

async function deletePackage(packageId) {
    if (!confirm('هل أنت متأكد من حذف هذه الباقة؟')) return;
    
    try {
        const data = await apiRequest(`packages.php?id=${packageId}`, {
            method: 'DELETE'
        });
        
        if (data && data.success) {
            alert(data.message);
            loadPackages();
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error deleting package:', error);
        alert('حدث خطأ في حذف الباقة');
    }
}

// Use formatDateTime from common.js

