// Common functions for all admin pages
function formatDateTime(dateString) {
    // عرض التاريخ والوقت كما هو مخزن في قاعدة البيانات مع AM/PM
    if (!dateString) return '-';
    
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    
    let hours = date.getHours();
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // الساعة 0 تصبح 12
    hours = String(hours).padStart(2, '0');
    
    return `${year}-${month}-${day} ${hours}:${minutes} ${ampm}`;
}

function formatDate(dateString) {
    // عرض التاريخ فقط
    if (!dateString) return '-';
    
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    
    return `${year}-${month}-${day}`;
}

// Media Viewer System
let mediaViewerData = {
    items: [],
    currentIndex: 0
};

function initMediaViewer() {
    // Create media viewer modal if it doesn't exist
    if (!document.getElementById('mediaViewerModal')) {
        const modalHTML = `
            <div id="mediaViewerModal" class="media-viewer-modal">
                <span class="media-viewer-close" onclick="closeMediaViewer()">&times;</span>
                <div class="media-viewer-info" id="mediaViewerInfo"></div>
                <div class="media-viewer-content" id="mediaViewerContent"></div>
                <div class="media-viewer-nav media-viewer-prev" onclick="prevMedia()" id="mediaViewerPrev">
                    <i class="fas fa-chevron-left"></i>
                </div>
                <div class="media-viewer-nav media-viewer-next" onclick="nextMedia()" id="mediaViewerNext">
                    <i class="fas fa-chevron-right"></i>
                </div>
                <div class="media-viewer-counter" id="mediaViewerCounter"></div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHTML);
        
        // Add keyboard navigation
        document.addEventListener('keydown', function(e) {
            const modal = document.getElementById('mediaViewerModal');
            if (modal && modal.classList.contains('active')) {
                if (e.key === 'Escape') closeMediaViewer();
                if (e.key === 'ArrowLeft') prevMedia();
                if (e.key === 'ArrowRight') nextMedia();
            }
        });
        
        // Close on background click
        document.getElementById('mediaViewerModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeMediaViewer();
            }
        });
    }
}

function openMediaViewer(mediaItems, startIndex = 0) {
    initMediaViewer();
    
    mediaViewerData.items = mediaItems;
    mediaViewerData.currentIndex = startIndex;
    
    showCurrentMedia();
    document.getElementById('mediaViewerModal').classList.add('active');
    document.body.style.overflow = 'hidden'; // Prevent body scroll
}

function closeMediaViewer() {
    document.getElementById('mediaViewerModal').classList.remove('active');
    document.body.style.overflow = ''; // Restore body scroll
    
    // Stop any playing videos
    const content = document.getElementById('mediaViewerContent');
    const video = content.querySelector('video');
    if (video) {
        video.pause();
    }
}

function showCurrentMedia() {
    const item = mediaViewerData.items[mediaViewerData.currentIndex];
    const content = document.getElementById('mediaViewerContent');
    const counter = document.getElementById('mediaViewerCounter');
    const info = document.getElementById('mediaViewerInfo');
    const prevBtn = document.getElementById('mediaViewerPrev');
    const nextBtn = document.getElementById('mediaViewerNext');
    
    // Show/hide navigation buttons
    if (mediaViewerData.items.length <= 1) {
        prevBtn.style.display = 'none';
        nextBtn.style.display = 'none';
        counter.style.display = 'none';
    } else {
        prevBtn.style.display = 'flex';
        nextBtn.style.display = 'flex';
        counter.style.display = 'block';
        counter.textContent = `${mediaViewerData.currentIndex + 1} / ${mediaViewerData.items.length}`;
    }
    
    // Show media type info
    const typeIcon = item.type === 'image' ? '🖼️' : '🎥';
    info.innerHTML = `${typeIcon} ${item.type === 'image' ? 'صورة' : 'فيديو'}`;
    
    // Display media
    if (item.type === 'image') {
        content.innerHTML = `<img src="${item.path}" alt="صورة" onclick="event.stopPropagation()">`;
    } else if (item.type === 'video') {
        content.innerHTML = `
            <video controls autoplay onclick="event.stopPropagation()">
                <source src="${item.path}" type="video/mp4">
                المتصفح لا يدعم تشغيل الفيديو
            </video>
        `;
    }
}

function nextMedia() {
    if (mediaViewerData.currentIndex < mediaViewerData.items.length - 1) {
        mediaViewerData.currentIndex++;
        showCurrentMedia();
    }
}

function prevMedia() {
    if (mediaViewerData.currentIndex > 0) {
        mediaViewerData.currentIndex--;
        showCurrentMedia();
    }
}

// Helper function to make media items clickable
function makeMediaClickable(containerSelector) {
    const container = typeof containerSelector === 'string' 
        ? document.querySelector(containerSelector) 
        : containerSelector;
    
    if (!container) return;
    
    const mediaItems = container.querySelectorAll('.media-item img, .media-item video');
    const mediaData = [];
    
    mediaItems.forEach((element, index) => {
        const type = element.tagName.toLowerCase() === 'img' ? 'image' : 'video';
        const path = element.tagName.toLowerCase() === 'img' ? element.src : element.querySelector('source').src;
        
        mediaData.push({ type, path });
        
        // Make clickable
        element.style.cursor = 'pointer';
        element.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            openMediaViewer(mediaData, index);
        });
    });
}
