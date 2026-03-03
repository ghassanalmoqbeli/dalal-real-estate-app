<?php
/**
 * Role-Based Access Control (RBAC) System
 * نظام إدارة الصلاحيات
 */

class RBAC {
    
    /**
     * جدول الصلاحيات
     * Permissions Matrix
     */
    private static $permissions = [
        'manage_admins' => ['super_admin'],
        'manage_users' => ['super_admin', 'moderator'],
        'manage_ads' => ['super_admin', 'moderator'],
        'manage_reports' => ['super_admin', 'moderator'],
        'manage_banners' => ['super_admin', 'editor'],
        'manage_packages' => ['super_admin', 'editor'],
        'manage_static_content' => ['super_admin', 'editor'],
        'manage_notifications' => ['super_admin', 'moderator'],
        'view_dashboard' => ['super_admin', 'moderator'],
        'manage_profile' => ['super_admin', 'editor', 'moderator']
    ];
    
    /**
     * تحقق من صلاحية معينة لدور معين
     * Check if a role has a specific permission
     * 
     * @param string $permission اسم الصلاحية
     * @param string $role دور المستخدم
     * @return bool
     */
    public static function hasPermission($permission, $role) {
        if (!isset(self::$permissions[$permission])) {
            return false;
        }
        
        return in_array($role, self::$permissions[$permission]);
    }
    
    /**
     * تحقق من صلاحية المستخدم
     * Check admin permission
     * 
     * @param array $admin بيانات الأدمن (يجب أن يحتوي على 'role')
     * @param string $permission اسم الصلاحية
     * @return bool
     */
    public static function checkPermission($admin, $permission) {
        if (!isset($admin['role'])) {
            return false;
        }
        
        return self::hasPermission($permission, $admin['role']);
    }
    
    /**
     * إرجاع رسالة خطأ الوصول الممنوع
     * Return access denied message
     * 
     * @return array
     */
    public static function accessDeniedResponse() {
        return [
            'success' => false,
            'message' => 'غير مصرح لك بالوصول إلى هذا القسم',
            'code' => 'ACCESS_DENIED'
        ];
    }
    
    /**
     * التحقق من الصلاحيات وإرجاع الاستجابة المناسبة
     * Verify permission and return appropriate response
     * 
     * @param array $admin بيانات الأدمن
     * @param string $permission اسم الصلاحية
     * @return array|null null إذا كانت الصلاحية متوفرة، array مع رسالة الخطأ إذا كانت غير متوفرة
     */
    public static function verifyPermission($admin, $permission) {
        if (!self::checkPermission($admin, $permission)) {
            return self::accessDeniedResponse();
        }
        return null;
    }
    
    /**
     * الحصول على جميع الصلاحيات المتاحة لدور معين
     * Get all permissions for a specific role
     * 
     * @param string $role دور المستخدم
     * @return array قائمة الصلاحيات المتاحة
     */
    public static function getRolePermissions($role) {
        $allowedPermissions = [];
        
        foreach (self::$permissions as $permission => $roles) {
            if (in_array($role, $roles)) {
                $allowedPermissions[] = $permission;
            }
        }
        
        return $allowedPermissions;
    }
    
    /**
     * الحصول على معلومات الصلاحيات لدور معين (للواجهة الأمامية)
     * Get permissions info for frontend
     * 
     * @param string $role دور المستخدم
     * @return array معلومات الصلاحيات
     */
    public static function getPermissionsInfo($role) {
        return [
            'can_manage_admins' => self::hasPermission('manage_admins', $role),
            'can_manage_users' => self::hasPermission('manage_users', $role),
            'can_manage_ads' => self::hasPermission('manage_ads', $role),
            'can_manage_reports' => self::hasPermission('manage_reports', $role),
            'can_manage_banners' => self::hasPermission('manage_banners', $role),
            'can_manage_packages' => self::hasPermission('manage_packages', $role),
            'can_manage_static_content' => self::hasPermission('manage_static_content', $role),
            'can_manage_notifications' => self::hasPermission('manage_notifications', $role),
            'can_view_dashboard' => self::hasPermission('view_dashboard', $role),
            'can_manage_profile' => self::hasPermission('manage_profile', $role)
        ];
    }
    
    /**
     * تعيين الصلاحية المناسبة للصفحة حسب اسمها
     * Map page to permission
     * 
     * @param string $page اسم الصفحة
     * @return string|null اسم الصلاحية المطلوبة
     */
    public static function getPagePermission($page) {
        $pageMap = [
            'admins' => 'manage_admins',
            'users' => 'manage_users',
            'ads' => 'manage_ads',
            'reports' => 'manage_reports',
            'banners' => 'manage_banners',
            'packages' => 'manage_packages',
            'static-content' => 'manage_static_content',
            'notifications' => 'manage_notifications',
            'dashboard' => 'view_dashboard',
            'profile' => 'manage_profile'
        ];
        
        return isset($pageMap[$page]) ? $pageMap[$page] : null;
    }
}




