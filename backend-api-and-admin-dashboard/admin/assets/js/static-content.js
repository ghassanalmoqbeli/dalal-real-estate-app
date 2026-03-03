// Static Content Management
document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    
    const adminData = getAdminData();
    if (adminData) {
        document.getElementById('adminUsername').textContent = adminData.username;
    }
    
    loadStaticContent();
    
    document.getElementById('aboutForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveStaticContent('about_us', document.getElementById('aboutContent').value);
    });
    
    document.getElementById('privacyForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveStaticContent('privacy_policy', document.getElementById('privacyContent').value);
    });
    
    document.getElementById('termsForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveStaticContent('terms_of_use', document.getElementById('termsContent').value);
    });
    
    document.getElementById('contactForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveStaticContent('contact_us', document.getElementById('contactContent').value);
    });
});

async function loadStaticContent() {
    try {
        const aboutData = await apiRequest('static_content.php?page=about_us');
        if (aboutData && aboutData.success) {
            document.getElementById('aboutContent').value = aboutData.data.content || '';
        }
        
        const privacyData = await apiRequest('static_content.php?page=privacy_policy');
        if (privacyData && privacyData.success) {
            document.getElementById('privacyContent').value = privacyData.data.content || '';
        }
        
        const termsData = await apiRequest('static_content.php?page=terms_of_use');
        if (termsData && termsData.success) {
            document.getElementById('termsContent').value = termsData.data.content || '';
        }
        
        const contactData = await apiRequest('static_content.php?page=contact_us');
        if (contactData && contactData.success) {
            document.getElementById('contactContent').value = contactData.data.content || '';
        }
    } catch (error) {
        console.error('Error loading static content:', error);
    }
}

async function saveStaticContent(page, content) {
    try {
        const data = await apiRequest('static_content.php', {
            method: 'POST',
            body: JSON.stringify({
                page: page,
                content: content
            })
        });
        
        if (data && data.success) {
            alert('تم حفظ المحتوى بنجاح');
        } else {
            alert(data.message || 'حدث خطأ');
        }
    } catch (error) {
        console.error('Error saving static content:', error);
        alert('حدث خطأ في حفظ المحتوى');
    }
}

