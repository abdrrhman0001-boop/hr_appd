// حالة التطبيق: لغة، ثيم، دور، مستخدم، بيانات تجريبية + Audit Log + وضع دون إنترنت
import 'package:flutter/material.dart';
import '../models/models.dart';

class AppStore extends ChangeNotifier {
  String lang = 'ar'; bool dark = false; bool offline = false;
  UserRole role = UserRole.superAdmin; // بدّل هنا لتجربة الأدوار
  String userName = 'أحمد بن يوسف'; String jobNumber = 'EMP-1042';
  List<String> audit = [];
  void log(String e) { audit.insert(0, '${DateTime.now().toString().substring(0,19)} — $e'); notifyListeners(); }

  void setLang(String v){ lang=v; notifyListeners(); }
  void setDark(bool v){ dark=v; notifyListeners(); }
  void setRole(UserRole r){ role=r; log('تغيير الدور إلى ${r.arName}'); notifyListeners(); }

  // --- بيانات تجريبية ---
  List<Announcement> announcements = [
    Announcement('1','إعلان: عطلة رسمية','يُعلم قسم الموارد البشرية أن يوم الخميس عطلة مدفوعة الأجر.','2026-11-05', pinned: true),
    Announcement('2','تقييم الأداء السنوي','انطلاق حملة تحديد الأهداف قبل 20 نوفمبر.','2026-11-03'),
    Announcement('3','دورة السلامة المهنية','التسجيل مفتوح — 20 مقعداً متبقياً.','2026-11-01'),
  ];
  List<LeaveRequest> leaves = [ LeaveRequest(id:'L1',employeeId:'me',type:'سنوية',from:DateTime(2026,11,20),to:DateTime(2026,11,23),status:'معلقة') ];
  int leaveBalance = 24;
  List<AdminRequest> adminRequests = [ AdminRequest(id:'R1',employeeId:'me',kind:'شهادة راتب',details:'موجهة للبنك',status:'قيد المعالجة') ];
  List<Payslip> payslips = List.generate(6,(i)=> Payslip(id:'P$i',employeeId:'me',month:'2026-${10-i>0?10-i:1}',gross:85000,deductions:12000,net:73000));
  List<AttendanceDay> attendance = List.generate(30,(i)=> AttendanceDay('2026-10-${(i+1).toString().padLeft(2,'0')}', i%7==5?null:'08:${(i%10).toString().padLeft(2,'0')}', i%7==5?null:'17:05', i%7==5?'غياب':'حاضر'));
  List<Course> courses = [ Course('C1','القيادة وإدارة الفرق','معهد التطوير','2026-12-01','12h'), Course('C2','Excel متقدم للموارد البشرية','أكاديمية الشركة','2026-12-10','8h',certified:true), Course('C3','السلامة المهنية','HSE','2026-11-25','6h') ];
  List<JobPosting> jobs = [ JobPosting('J1','مسؤول توظيف','الموارد البشرية','الجزائر العاصمة','دوام كامل'), JobPosting('J2','مطور Flutter','تقنية المعلومات','عن بُعد','دوام كامل') ];
  List<Employee> employees = [
    Employee(id:'1',jobNumber:'EMP-1042',name:'أحمد بن يوسف',department:'تقنية المعلومات',position:'مطور',hireDate:DateTime(2021,3,1),salary:85000,phone:'0550 00 00 01',email:'ahmed@company.dz',leaveBalance:24),
    Employee(id:'2',jobNumber:'EMP-1007',name:'سارة مرابط',department:'الموارد البشرية',position:'مسؤولة HR',hireDate:DateTime(2019,6,15),salary:95000,phone:'0550 00 00 02',email:'sara@company.dz',leaveBalance:18),
    Employee(id:'3',jobNumber:'EMP-0988',name:'كريم بوزيد',department:'المالية',position:'محاسب',hireDate:DateTime(2020,1,10),salary:78000,phone:'0550 00 00 03',email:'karim@company.dz',leaveBalance:30),
  ];
  List<String> departments = const ['الموارد البشرية','تقنية المعلومات','المالية','التسويق','العمليات'];
}
