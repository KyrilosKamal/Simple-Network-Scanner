#!/bin/bash
# سكربت لفحص الأجهزة الحية في شبكة محددة باستخدام ping

# طلب إدخال معرف الشبكة من المستخدم (مثال: 192.168.1)
read -p "Enter Network ID (e.g. 192.168.1): " networkID

# طلب بداية ونهاية النطاق لفحص IPs
read -p "Enter the start range: " start
read -p "Enter the end range: " end

# التحقق من أن معرف الشبكة يتبع تنسيق IP جزئي (ثلاث مجموعات رقمية مفصولة بنقاط)
regex='^[0-9]+\.[0-9]+\.[0-9]+$'
if ! [[ "$networkID" =~ $regex ]]; then
  echo "Invalid network ID"  # طباعة رسالة خطأ إذا لم يكن التنسيق صحيح
  exit 1                    # إنهاء السكربت
fi

# التحقق من أن النطاق المدخل صحيح (من 1 إلى 254، والبداية أصغر من النهاية)
if (( start < 1 || end > 254 || start > end )); then
  echo "Invalid range"      # طباعة رسالة خطأ إذا كان النطاق غير منطقي
  exit 1                    # إنهاء السكربت
fi

# طباعة بداية الفحص
echo -e "\nScanning from $networkID.$start to $networkID.$end..."
echo "===================================================================="

# عدادات للأجهزة الحية والمطفأة
liveDeviceCount=0
downDeviceCount=0

# حلقة لفحص كل IP في النطاق المحدد
for i in $(seq "$start" "$end"); do
  ip="$networkID.$i"  # تكوين عنوان IP كامل

# تنفيذ أمر ping لفحص الجهاز الحالي:
# -c 4 → إرسال 4 طلبات ping فقط (عدد المحاولات)
# -W 2 → الانتظار حتى 2 ثانية لكل رد قبل اعتبار الجهاز غير متصل (timeout لكل محاولة)
# "$ip" → عنوان IP الذي يتم فحصه حاليًا داخل الحلقة
# &> /dev/null → تجاهل كل المخرجات (stdout و stderr) للحفاظ على نظافة الشاشة
if ping -c 4 -W 2 "$ip" &> /dev/null; then
  if ping -c 4 -W 2 "$ip" &> /dev/null; then
    echo "===================================================================="
    echo "Host $ip UP"       # الجهاز متصل
    ((liveDeviceCount++))  # زيادة عداد الأجهزة الحية
  else
    echo "Host $ip Down"     # الجهاز غير متصل
    ((downDeviceCount++))   # زيادة عداد الأجهزة المطفأة
  fi
done

# طباعة تقرير الفحص النهائي
echo "===================================================================="
echo "Scan Report:"
echo "Up Devices:   $liveDeviceCount"
echo "Down Devices: $downDeviceCount"
echo "Total Scanned: $((liveDeviceCount + downDeviceCount))"
