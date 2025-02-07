import 'package:get/get.dart';

class PolicyController extends GetxController {
  final RxList<String> policyListEn = [
    "Privacy is a fundamental right, and our app is designed to safeguard your personal information at every step.",
    "We ensure that your data is encrypted, keeping it secure from unauthorized access.",
    "Your personal information is never shared with third parties without your explicit consent.",
    "Our app uses the latest security protocols to protect your data while it's in transit and at rest.",
    "You control what information you share, with easy-to-use privacy settings tailored to your preferences.",
    "We collect only the data necessary to provide a seamless user experience, minimizing unnecessary exposure.",
    "Your browsing and interaction within the app remain private, with no tracking or data collection for targeted advertising.",
    "We offer transparent data management, allowing you to review, update, or delete your information at any time.",
    "ur commitment to privacy means regular security audits to ensure our protection measures remain strong.",
    "With our app, your privacy isn't just a feature; it's our top priority.",
  ].obs;

  final RxList<String> policyListFa = [
    "حریم خصوصی یک حق اساسی است و برنامه ما برای محافظت از اطلاعات شخصی شما در هر مرحله طراحی شده است.",
    "ما اطمینان می‌دهیم که داده‌های شما رمزگذاری شده است، و از دسترسی غیرمجاز محافظت می‌کنیم.",
    "اطلاعات شخصی شما هرگز بدون رضایت صریح شما با اشخاص ثالث به اشتراک گذاشته نمی شود.",
    "برنامه ما از جدیدترین پروتکل های امنیتی برای محافظت از داده های شما در حین حمل و نقل و در حالت استراحت استفاده می کند.",
    "شما کنترل می کنید که چه اطلاعاتی را به اشتراک می گذارید، با تنظیمات حریم خصوصی آسان برای استفاده متناسب با تنظیمات برگزیده شما.",
    "ما فقط داده های لازم را برای ارائه یک تجربه کاربری یکپارچه جمع آوری می کنیم و قرار گرفتن در معرض غیر ضروری را به حداقل می رساند.",
    "مرور و تعامل شما در برنامه خصوصی باقی می ماند، بدون ردیابی یا جمع آوری داده برای تبلیغات هدفمند.",
    "ما مدیریت داده‌های شفاف را ارائه می‌دهیم که به شما امکان می‌دهد اطلاعات خود را در هر زمان بررسی، به‌روزرسانی یا حذف کنید.",
    "تعهد ما به حفظ حریم خصوصی به معنای ممیزی های امنیتی منظم است تا اطمینان حاصل شود که اقدامات حفاظتی ما همچنان قوی است.",
    "با برنامه ما، حریم خصوصی شما فقط یک ویژگی نیست. این اولویت اصلی ماست.",
  ].obs;

  RxBool isEnglish = false.obs;

  void changeLang() {
    isEnglish.value = !isEnglish.value;
  }
}