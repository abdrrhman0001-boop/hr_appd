// نماذج البيانات الأساسية
enum UserRole { employee, manager, hr, superAdmin }

extension UserRoleX on UserRole {
  String get arName {
    switch (this) {
      case UserRole.employee: return 'موظف';
      case UserRole.manager: return 'مدير مباشر';
      case UserRole.hr: return 'مسؤول موارد بشرية';
      case UserRole.superAdmin: return 'مشرف رئيسي';
    }
  }
  bool get isPrivileged => this == UserRole.manager || this == UserRole.hr || this == UserRole.superAdmin;
}

class Employee {
  final String id, jobNumber, name, department, position, phone, email;
  final DateTime hireDate;
  final double salary;
  final String? photoUrl, managerId;
  final int leaveBalance;
  final bool active;
  Employee({required this.id, required this.jobNumber, required this.name,
    required this.department, required this.position, required this.hireDate,
    required this.salary, required this.phone, required this.email,
    this.photoUrl, this.managerId, this.leaveBalance = 30, this.active = true});
}

class LeaveRequest {
  final String id, employeeId, type; // سنوية، مرضية، استثنائية...
  final DateTime from, to;
  String status; // معلقة، مقبولة، مرفوضة
  LeaveRequest({required this.id, required this.employeeId, required this.type,
    required this.from, required this.to, this.status = 'معلقة'});
}

class AdminRequest {
  final String id, employeeId, kind; // إذن خروج، سلفة، شهادة راتب...
  final String details;
  String status;
  final DateTime createdAt;
  AdminRequest({required this.id, required this.employeeId, required this.kind,
    required this.details, this.status = 'معلقة', DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();
}

class Payslip {
  final String id, employeeId, month; // 2026-10
  final double gross, deductions, net;
  Payslip({required this.id, required this.employeeId, required this.month,
    required this.gross, required this.deductions, required this.net});
}

class AttendanceDay {
  final String date; final String? checkIn, checkOut; final String status;
  AttendanceDay(this.date, this.checkIn, this.checkOut, this.status);
}

class Course { final String id, title, org, date, hours; bool registered; bool certified;
  Course(this.id, this.title, this.org, this.date, this.hours, {this.registered=false, this.certified=false}); }

class JobPosting { final String id, title, dept, location, type; bool applied;
  JobPosting(this.id, this.title, this.dept, this.location, this.type, {this.applied=false}); }

class Announcement { final String id, title, body, date; final bool pinned;
  Announcement(this.id, this.title, this.body, this.date, {this.pinned=false}); }
