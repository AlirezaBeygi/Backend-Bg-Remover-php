# راهنمای تست API با Postman

## پیش‌نیازها

1. Postman نصب شده باشد
2. Apache و MySQL در Xampp راه‌اندازی شده باشند
3. Backend در `http://localhost/backend/public/api` در دسترس باشد

---

## تست 1: ورود (Login) - POST

### تنظیمات Request

**Method:** `POST`

**URL:**
```
http://localhost/backend/public/api/auth/login
```

**Headers:**
```
Content-Type: application/json
```

**Body (raw - JSON):**
```json
{
    "username": "testuser",
    "password": "password123"
}
```

### مراحل در Postman

1. **Method را انتخاب کنید:**
   - از منوی dropdown، `POST` را انتخاب کنید

2. **URL را وارد کنید:**
   ```
   http://localhost/backend/public/api/auth/login
   ```

3. **Headers را تنظیم کنید:**
   - روی تب `Headers` کلیک کنید
   - Key: `Content-Type`
   - Value: `application/json`

4. **Body را تنظیم کنید:**
   - روی تب `Body` کلیک کنید
   - گزینه `raw` را انتخاب کنید
   - از dropdown سمت راست، `JSON` را انتخاب کنید
   - JSON زیر را وارد کنید:
   ```json
   {
       "username": "testuser",
       "password": "password123"
   }
   ```

5. **Send را بزنید**

### پاسخ موفق (200 OK)

```json
{
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0L2JhY2tlbmQvcHVibGljL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzMxMjM0NTY3LCJleHAiOjE3MzEyMzgxNjcsIm5iZiI6MTczMTIzNDU2NywianRpIjoiYWJjMTIzIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.xxxxx"
}
```

**نکته:** این Token را کپی کنید، برای درخواست‌های بعدی نیاز دارید.

### پاسخ خطا (401 Unauthorized)

```json
{
    "error": "Invalid credentials"
}
```

---

## تست 2: حذف پس‌زمینه (Remove Background) - POST

### تنظیمات Request

**Method:** `POST`

**URL:**
```
http://localhost/backend/public/api/remove-background
```

**Headers:**
```
Authorization: Bearer YOUR_TOKEN_HERE
```

**Body (form-data):**
- Key: `image`
- Type: `File`
- Value: [انتخاب فایل تصویر]

### مراحل در Postman

1. **Method را انتخاب کنید:**
   - `POST` را انتخاب کنید

2. **URL را وارد کنید:**
   ```
   http://localhost/backend/public/api/remove-background
   ```

3. **Headers را تنظیم کنید:**
   - روی تب `Headers` کلیک کنید
   - Key: `Authorization`
   - Value: `Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...` (Token از تست قبلی)

4. **Body را تنظیم کنید:**
   - روی تب `Body` کلیک کنید
   - گزینه `form-data` را انتخاب کنید
   - Key: `image`
   - از dropdown سمت راست Key، `File` را انتخاب کنید
   - روی دکمه `Select Files` کلیک کنید
   - یک فایل تصویر انتخاب کنید (jpg, png, jpeg - حداکثر 10MB)

5. **Send را بزنید**

### پاسخ موفق (200 OK)

```json
{
    "result_url": "http://localhost/backend/public/storage/processed/1731234567_image.jpg",
    "job_id": "1",
    "status": "completed"
}
```

### پاسخ خطا (422 Validation Error)

```json
{
    "error": "Validation failed",
    "messages": {
        "image": [
            "The image field is required."
        ]
    }
}
```

### پاسخ خطا (401 Unauthorized)

```json
{
    "error": "Unauthenticated"
}
```

---

## تست 3: بررسی وضعیت Job - GET

### تنظیمات Request

**Method:** `GET`

**URL:**
```
http://localhost/backend/public/api/job/1/status
```

**Headers:**
```
Authorization: Bearer YOUR_TOKEN_HERE
```

### مراحل در Postman

1. **Method را انتخاب کنید:**
   - `GET` را انتخاب کنید

2. **URL را وارد کنید:**
   ```
   http://localhost/backend/public/api/job/1/status
   ```
   (عدد `1` را با `job_id` از پاسخ تست قبلی جایگزین کنید)

3. **Headers را تنظیم کنید:**
   - روی تب `Headers` کلیک کنید
   - Key: `Authorization`
   - Value: `Bearer YOUR_TOKEN_HERE`

4. **Send را بزنید**

### پاسخ موفق (200 OK)

```json
{
    "status": "completed",
    "progress": 100,
    "result_url": "http://localhost/backend/public/storage/processed/1731234567_image.jpg"
}
```

### پاسخ خطا (404 Not Found)

```json
{
    "error": "Job not found"
}
```

---

## نکات مهم

### 1. ذخیره Token به صورت خودکار

می‌توانید از **Environment Variables** در Postman استفاده کنید:

1. روی دکمه `Environments` کلیک کنید
2. `+` را بزنید و Environment جدید ایجاد کنید
3. Variable: `token`
4. بعد از Login موفق، در Tests tab این کد را اضافه کنید:
   ```javascript
   if (pm.response.code === 200) {
       var jsonData = pm.response.json();
       pm.environment.set("token", jsonData.token);
   }
   ```
5. در Header Authorization از `Bearer {{token}}` استفاده کنید

### 2. Collection ایجاد کنید

می‌توانید یک Collection ایجاد کنید و تمام Request ها را ذخیره کنید:

1. روی `New` > `Collection` کلیک کنید
2. نام: `Background Remover API`
3. Request ها را به Collection اضافه کنید

### 3. تست سریع

برای تست سریع، می‌توانید از این ترتیب استفاده کنید:

1. ابتدا Login کنید و Token را کپی کنید
2. Token را در Header Authorization قرار دهید
3. تصویر را آپلود کنید
4. نتیجه را مشاهده کنید

---

## عیب‌یابی

### خطای "Connection refused"

**راه حل:**
- Apache را در Xampp راه‌اندازی کنید
- مطمئن شوید که Backend در `http://localhost/backend/public/api` در دسترس است

### خطای "404 Not Found"

**راه حل:**
- URL را بررسی کنید
- مطمئن شوید که `/api/` در انتهای Base URL است
- فایل `.htaccess` در پوشه `public` وجود دارد

### خطای "401 Unauthorized"

**راه حل:**
- Token را بررسی کنید
- مطمئن شوید که `Bearer ` قبل از Token است (با فاصله)
- Token منقضی نشده باشد (معمولاً 60 دقیقه)

### خطای "422 Validation Error"

**راه حل:**
- فایل تصویر را بررسی کنید
- مطمئن شوید که فایل از نوع jpg, png, jpeg است
- اندازه فایل کمتر از 10MB باشد

---

## مثال کامل با Screenshot

### صفحه Login در Postman:

```
Method: POST
URL: http://localhost/backend/public/api/auth/login
Headers:
  Content-Type: application/json
Body (raw - JSON):
  {
      "username": "testuser",
      "password": "password123"
  }
```

### صفحه Remove Background در Postman:

```
Method: POST
URL: http://localhost/backend/public/api/remove-background
Headers:
  Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
Body (form-data):
  image: [File] - Select a image file
```

---

## تست سریع با cURL (اختیاری)

اگر می‌خواهید از Command Line تست کنید:

### Login:
```bash
curl -X POST http://localhost/backend/public/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"testuser\",\"password\":\"password123\"}"
```

### Remove Background:
```bash
curl -X POST http://localhost/backend/public/api/remove-background \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "image=@/path/to/your/image.jpg"
```

