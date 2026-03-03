# Delete Account API Documentation

## Overview
API لإرسال طلب حذف الحساب. المستخدم يطلب حذف حسابه، ثم يتم مراجعة الطلب من قبل الأدمن.

---

## Request Delete Account (`request_delete_account.php`)

### Endpoint
```
POST /api-app/api/user/request_delete_account.php
```

### Description
إرسال طلب حذف الحساب. سيتم تغيير حالة المستخدم إلى `pending_deletion` في انتظار مراجعة الأدمن.

### Headers
- `Authorization` (required): `Bearer {token}`

### Request Body (Optional)

```json
{
    "reason": "أسباب الحذف (اختياري)"
}
```

### Request Example

```http
POST /api-app/api/user/request_delete_account.php
Authorization: Bearer your_token_here
Content-Type: application/json

{
    "reason": "I no longer want to use the application"
}
```

### Response Structure

```json
{
    "status": "success",
    "message": "تم إرسال طلب حذف حسابك بنجاح. سيتم مراجعته من قبل الإدارة قريباً.",
    "data": {
        "user_id": 101,
        "status": "pending_deletion"
    }
}
```

### Error Responses

**إذا كان هناك طلب حذف قيد المراجعة:**
```json
{
    "status": "error",
    "message": "لديك بالفعل طلب حذف قيد المراجعة"
}
```

**إذا كان الـ Token غير صحيح:**
```json
{
    "status": "error",
    "message": "Invalid or expired token"
}
```

---

## Admin Panel - كيفية التعامل مع طلبات الحذف

### 1. عرض طلبات الحذف
- افتح صفحة "المستخدمين" في لوحة التحكم
- اختر "طلبات الحذف" من قائمة الفلترة
- سيظهر جميع المستخدمين الذين لديهم حالة `pending_deletion`

### 2. الموافقة على الحذف
- اضغط على زر "الموافقة على الحذف"
- سيتم حذف الحساب وجميع بياناته نهائياً
- **هذا الإجراء لا يمكن التراجع عنه**

### 3. رفض طلب الحذف
- اضغط على زر "رفض طلب الحذف"
- سيتم إعادة تفعيل الحساب إلى `active`
- سيتم إرسال إشعار للمستخدم بإعادة تفعيل الحساب

---

## Database Update

**مهم**: قبل استخدام هذه الوظيفة، يجب تحديث قاعدة البيانات:

```sql
ALTER TABLE `users` 
MODIFY COLUMN `status` enum('active','blocked','pending_deletion') NOT NULL DEFAULT 'active';
```

قم بتشغيل هذا الأمر في قاعدة البيانات لإضافة حالة `pending_deletion`.

---

## Flow Diagram

```
1. المستخدم يطلب حذف الحساب
   ↓
2. status = 'pending_deletion'
   ↓
3. الأدمن يرى الطلب في لوحة التحكم
   ↓
4. الأدمن يختار:
   - الموافقة: حذف الحساب نهائياً
   - الرفض: إعادة الحساب إلى 'active'
```

---

## Notes

1. **Security**: فقط المستخدم المصادق عليه يمكنه طلب حذف حسابه
2. **Status Check**: لا يمكن إرسال طلب حذف إذا كان هناك طلب قيد المراجعة
3. **Admin Action**: الأدمن فقط يمكنه الموافقة أو الرفض
4. **Deletion**: عند الموافقة، يتم حذف جميع بيانات المستخدم (إعلانات، إشعارات، تقارير، إلخ)

