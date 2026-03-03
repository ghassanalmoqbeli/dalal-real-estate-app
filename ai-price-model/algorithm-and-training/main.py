from fastapi import FastAPI
import joblib
import pandas as pd
import math
import re

app = FastAPI()

sale_model = joblib.load("sale_model_xgb.pkl")
rent_model = joblib.load("rent_model_xgb.pkl")

def ceil_to_step(x: float, step: float) -> int:
    return int(math.ceil(x / step) * step)

ALLOWED_AREAS_EN = {
    'Al-Ashash','Al-Hasaba','Al-Hathili','Al-Khamseen','Al-Rawdhah','Al-Sabahah',
    'Al-Sabain','Al-Sunainah','Al-Tahrir','Asr','Bayt-Meyad','Dar Salm','Daras',
    'Faj-Attan-Upper','Hadda','Hayel','Hizyaz','Jawlat-Imran-Outskirts','Madhbah',
    "Qa'a Al-Qaidhi","Sa'wan",'Shumaylah',  "Bayt-Baws","Al-Asbahi", "Bayt-Zabtan", "Bab-AlYemen","Moeen", "Artel"
}

# ✅ تقسيم المناطق حسب PDF (بالإنجليزي)
HIGH_AREAS = {
    "Al-Ashash","Al-Khamseen","Bayt-Baws","Al-Asbahi","Bayt-Meyad",
    "Faj-Attan-Upper","Hadda","Bayt-Zabtan","Al-Sabain"
}
MID_AREAS = {
    "Al-Hasaba","Al-Rawdhah","Al-Sunainah","Al-Tahrir","Asr","Dar Salm",
    "Artel","Hayel","Madhbah","Shumaylah","Bab-AlYemen","Moeen"
}
LOW_AREAS = {
    "Al-Hathili","Al-Sabahah","Daras","Hizyaz",
    "Jawlat-Imran-Outskirts","Qa'a Al-Qaidhi","Sa'wan"
}

# ✅ رسائل قصيرة (سطر)
MSG_HIGH = "العقار يقع في حي راقٍ يتميز بمستوى خدمات عالٍ وطلب مرتفع."
MSG_MID  = "العقار يقع في منطقة قريبة من الخدمات والطرق الرئيسية لكنها غير مصنفة كحي راقٍ."
MSG_LOW  = "العقار يقع في منطقة بعيدة نسبيًا عن مراكز الخدمات ويقل فيها مستوى الطلب."

def area_message(area_en: str) -> str:
    if area_en in HIGH_AREAS:
        return MSG_HIGH
    elif area_en in MID_AREAS:
        return MSG_MID
    elif area_en in LOW_AREAS:
        return MSG_LOW
    return "العقار يقع في إحدى مناطق صنعاء وتم تقدير القيمة بناءً على خصائصه."

def normalize_ar(text: str) -> str:
    if not text:
        return ""
    text = text.lower().strip()
    text = re.sub(r"[\u064B-\u065F\u0670\u0640]", "", text)
    text = text.replace("أ", "ا").replace("إ", "ا").replace("آ", "ا")
    text = text.replace("ى", "ي")
    text = text.replace("ة", "ه")
    text = re.sub(r"[^a-z\u0600-\u06FF\s]", " ", text)
    return re.sub(r"\s+", " ", text).strip()

AREA_PATTERNS = [
    (["حدة", "حده"], "Hadda"),
    (["هائل", "هايل"], "Hayel"),
    (["حزيز"], "Hizyaz"),
    (["سعوان", "صعوان", "صوان"], "Sa'wan"),
    (["شميلة", "شميله"], "Shumaylah"),
    (["مذبح"], "Madhbah"),
    (["عصر"], "Asr"),

    (["التحرير", "تحرير"], "Al-Tahrir"),
    (["السبعين", "سبعين"], "Al-Sabain"),
    (["السنينة", "سنينة", "السنينه", "سنينه"], "Al-Sunainah"),
    (["الروضة", "روضه", "روضة"], "Al-Rawdhah"),
    (["الحصبة", "حصبة", "الحصبه", "حصبه"], "Al-Hasaba"),
    (["الصباحة", "صباحة", "الصباحه", "صباحه"], "Al-Sabahah"),
    (["الخمسين", "خمسين"], "Al-Khamseen"),
    (["الحثيلي", "حثيلي"], "Al-Hathili"),
    (["العشاش", "عشاش"], "Al-Ashash"),

    (["بيت معياد", "بيت معيد", "بيت مياد"], "Bayt-Meyad"),
    (["بيت بوس"], "Bayt-Baws"),
    (["الاصبحي", "الأصبحي", "اصبحي"], "Al-Asbahi"),
    (["بيت زبطان"], "Bayt-Zabtan"),
    (["ارتل","أرتل"], "Artel"),
    (["دار سلم", "دارسلم"], "Dar Salm"),
    (["دارس"], "Daras"),

    (["فج عطان", "فج عطان فوق", "فج عطان علوي"], "Faj-Attan-Upper"),

    (["جولة عمران", "جوله عمران", "عمران"], "Jawlat-Imran-Outskirts"),

    (["قاع القيضي", "القيضي", "القيظي", "قاع القيظي"], "Qa'a Al-Qaidhi"),

    (["باب اليمن"], "Bab-AlYemen"),
    (["معين"], "Moeen"),
]


def extract_area_to_model(area_text: str):
    if not area_text:
        return None

    t = normalize_ar(area_text)
    best_match, best_len = None, -1

    for aliases, area_en in AREA_PATTERNS:
        for a in aliases:
            a_norm = normalize_ar(a)
            if re.search(rf"(^|\s){re.escape(a_norm)}(\s|$)", t):
                if len(a_norm) > best_len:
                    best_len = len(a_norm)
                    best_match = area_en

    if best_match in ALLOWED_AREAS_EN:
        return best_match
    return None

@app.post("/predict")
def predict(data: dict):

    if data["city"] != "Sanaa":
        return {"error": "هذا النموذج يدعم صنعاء فقط حالياً"}

    deal_type = data["deal_type"]

    area_clean = extract_area_to_model(data.get("area_name", ""))
    if not area_clean:
        return {"error": "لم يتم التعرف على المنطقة، اكتب اسم المنطقة بشكل أوضح"}

    area_m2 = float(data["area_m2"])
    rooms = int(data["rooms"])
    baths = int(data["baths"])
    floors = int(data["floors"])

    row = {
        "city": "Sanaa",
        "area_name": area_clean,
        "property_type": str(data["property_type"]).lower().strip(),
        "deal_type": deal_type,
        "area_m2": area_m2,
        "rooms": rooms,
        "baths": baths,
        "floors": floors
    }

    df = pd.DataFrame([row])

    msg = area_message(area_clean)

    if deal_type == "sale":
        raw_price = float(sale_model.predict(df)[0])
        nice_price = ceil_to_step(raw_price, 5_000_000)
        return {"predicted_price": nice_price, "message": msg}

    elif deal_type == "rent":
        raw_price = float(rent_model.predict(df)[0])
        raw_price = max(20_000, min(raw_price, 1_000_000))
        nice_price = ceil_to_step(raw_price, 5_000)
        return {"predicted_price": nice_price, "message": msg}

    else:
        return {"error": "deal_type لازم يكون sale أو rent"}
