// قاموس ثلاثي اللغات: العربية (RTL) / الفرنسية / الإنجليزية
import 'package:flutter/material.dart';

class AppStrings {
  static const supported = [Locale('ar'), Locale('fr'), Locale('en')];
  static String langName(String c) => c == 'ar' ? 'العربية' : c == 'fr' ? 'Français' : 'English';

  static const _t = {
    'appTitle': {'ar': 'مواردنا | [اسم الشركة]', 'fr': 'RH | [Entreprise]', 'en': 'HR | [Company]'},
    'login': {'ar': 'تسجيل الدخول', 'fr': 'Connexion', 'en': 'Login'},
    'emailOrId': {'ar': 'البريد أو الرقم الوظيفي', 'fr': 'Email ou matricule', 'en': 'Email or job number'},
    'password': {'ar': 'كلمة المرور', 'fr': 'Mot de passe', 'en': 'Password'},
    'biometric': {'ar': 'الدخول بالبصمة / الوجه', 'fr': 'Biométrie / Face ID', 'en': 'Fingerprint / Face'},
    'home': {'ar': 'الرئيسية', 'fr': 'Accueil', 'en': 'Home'},
    'profile': {'ar': 'ملفي', 'fr': 'Profil', 'en': 'Profile'},
    'leaves': {'ar': 'الإجازات', 'fr': 'Congés', 'en': 'Leaves'},
    'attendance': {'ar': 'الحضور', 'fr': 'Présence', 'en': 'Attendance'},
    'payslip': {'ar': 'كشف الراتب', 'fr': 'Bulletins', 'en': 'Payslips'},
    'requests': {'ar': 'الطلبات', 'fr': 'Demandes', 'en': 'Requests'},
    'training': {'ar': 'التدريب', 'fr': 'Formation', 'en': 'Training'},
    'performance': {'ar': 'الأداء', 'fr': 'Performance', 'en': 'Performance'},
    'jobs': {'ar': 'التوظيف الداخلي', 'fr': 'Recrutement', 'en': 'Jobs'},
    'directory': {'ar': 'الدليل', 'fr': 'Annuaire', 'en': 'Directory'},
    'contact': {'ar': 'تواصل مع HR', 'fr': 'Contacter RH', 'en': 'Contact HR'},
    'admin': {'ar': 'لوحة المشرف', 'fr': 'Admin', 'en': 'Admin'},
    'logout': {'ar': 'خروج', 'fr': 'Déconnexion', 'en': 'Logout'},
    'dark': {'ar': 'الوضع الداكن', 'fr': 'Mode sombre', 'en': 'Dark mode'},
    'language': {'ar': 'اللغة', 'fr': 'Langue', 'en': 'Language'},
  };
  final String lang;
  AppStrings(this.lang);
  String get(String k) => _t[k]?[lang] ?? _t[k]?['ar'] ?? k;
}
