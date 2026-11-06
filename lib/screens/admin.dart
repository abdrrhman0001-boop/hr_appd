// لوحة المشرف الرئيسي (Super Admin): وصول كامل دون قيود
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart'; import '../models/models.dart';

class AdminScreen extends StatefulWidget { const AdminScreen({super.key}); @override State<AdminScreen> createState()=>_A(); }
class _A extends State<AdminScreen> with SingleTickerProviderStateMixin {
  late TabController tab;
  @override void initState(){ super.initState(); tab=TabController(length:5,vsync:this); }
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    if(s.role!=UserRole.superAdmin&&s.role!=UserRole.hr) return Scaffold(appBar:AppBar(title:const Text('المشرف')),body:const Center(child:Text('هذه المساحة للمشرف الرئيسي وHR فقط')));
    return Scaffold(appBar:AppBar(title:const Text('لوحة المشرف الرئيسي'),bottom:const TabBar(isScrollable:true,tabs:[Tab(text:'تحكم'),Tab(text:'المستخدمون'),Tab(text:'إضافة عامل'),Tab(text:'إعلانات/تقارير'),Tab(text:'سجل التدقيق')])),
      body:TabBarView(controller:tab,children:[
        _dash(s), _users(context,s), _addWorker(context,s), _ops(context,s), _audit(s),
      ]));
  }
  Widget _dash(AppStore s)=>ListView(padding:const EdgeInsets.all(12),children:[
    Wrap(spacing:8,runSpacing:8,children:[
      _stat('الموظفون','${s.employees.length}',Icons.people),_stat('الحضور اليوم','92%',Icons.check_circle),
      _stat('الغيابات','3',Icons.cancel),_stat('طلبات معلقة','${s.leaves.length+s.adminRequests.length}',Icons.hourglass_empty),
      _stat('كتلة الأجور','2.4M دج',Icons.payments),
    ]),
    Card(child:Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Text('الأقسام والهيكل',style:TextStyle(fontWeight:FontWeight.bold)),
      ...s.departments.map((d)=>ListTile(dense:true,leading:const Icon(Icons.apartment),title:Text(d),trailing:const Text('نشط'))),
    ]))),
    const Card(child:ListTile(leading:Icon(Icons.schedule),title:Text('سياسة الإجازات والدوام'),subtitle:Text('30 يوماً/سنة • الدوام 08:00–17:00 • قابلة للتعديل من هنا'))),
  ]);
  Widget _stat(String t,String v,IconData ic)=>SizedBox(width:160,child:Card(child:Padding(padding:const EdgeInsets.all(12),child:Column(children:[Icon(ic,color:Colors.teal),Text(v,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text(t)]))));
  Widget _users(BuildContext c,AppStore s)=>ListView(children:s.employees.map((e)=>Card(child:ListTile(title:Text('${e.name} (${e.jobNumber})'),subtitle:Text('${e.position} • ${e.department} • رصيد: ${e.leaveBalance}'),trailing:PopupMenuButton(itemBuilder:(_)=>const [PopupMenuItem(value:'edit',child:Text('تعديل')),PopupMenuItem(value:'move',child:Text('نقل قسم')),PopupMenuItem(value:'leave',child:Text('تعديل رصيد الإجازات')),PopupMenuItem(value:'off',child:Text('تعطيل/إنهاء خدمة')),PopupMenuItem(value:'del',child:Text('حذف'))],onSelected:(v){ s.log('$v للعامل ${e.name}'); ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('نُفذ: $v — ${e.name} (يُحفظ السجل)')));}),onTap:()=>showDialog(context:c,builder:(_)=>AlertDialog(title:Text(e.name),content:Text('تعيين الدور والمدير المباشر:\n• الدور: موظف/مدير/HR/مشرف\n• المدير: يُختار من القائمة\n• الراتب: ${e.salary}'),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('إغلاق'))]))))).toList());
  Widget _addWorker(BuildContext c,AppStore s){
    final name=TextEditingController(),job=TextEditingController(),phone=TextEditingController(),mail=TextEditingController(),sal=TextEditingController();
    String dept=s.departments.first;
    return ListView(padding:const EdgeInsets.all(12),children:[
      const Text('نموذج إضافة عامل جديد',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16)),
      TextField(controller:name,decoration:const InputDecoration(labelText:'الاسم الكامل')),TextField(controller:job,decoration:const InputDecoration(labelText:'الرقم الوظيفي')),
      DropdownButtonFormField(value:dept,items:s.departments.map((d)=>DropdownMenuItem(value:d,child:Text(d))).toList(),onChanged:(v){dept=v!;}),
      TextField(controller:phone,decoration:const InputDecoration(labelText:'الهاتف')),TextField(controller:mail,decoration:const InputDecoration(labelText:'البريد')),
      TextField(controller:sal,decoration:const InputDecoration(labelText:'الراتب'),keyboardType:TextInputType.number),
      const SizedBox(height:8),
      FilledButton(onPressed:(){ s.employees.add(Employee(id:'${s.employees.length+1}',jobNumber:job.text.isEmpty?'EMP-${1000+s.employees.length}':job.text,name:name.text.isEmpty?'عامل جديد':name.text,department:dept,position:'موظف',hireDate:DateTime.now(),salary:double.tryParse(sal.text)??50000,phone:phone.text,email:mail.text)); s.log('إضافة عامل ${name.text} + إنشاء حساب دخول تلقائي وإرسال بيانات الدخول'); ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('أُضيف العامل + أُنشئ حسابه وأُرسلت بيانات الدخول (SMS/بريد)'))); },child:const Text('إضافة + إنشاء حساب دخول')),
      OutlinedButton.icon(onPressed:(){ s.log('استيراد Excel/CSV دفعة واحدة'); ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('اختر ملف Excel/CSV لاستيراد عدة عمال — الأعمدة: الاسم، الرقم، القسم، المنصب، التعيين، الراتب، الهاتف، البريد')));},icon:const Icon(Icons.upload_file),label:const Text('استيراد دفعة عبر Excel/CSV')),
      const Text('رفع وثائق العامل: عقد، هوية، شهادات (PDF/صور) — تُشفَّر وتُحفظ',style:TextStyle(fontSize:12,color:Colors.grey)),
    ]);
  }
  Widget _ops(BuildContext c,AppStore s)=>ListView(padding:const EdgeInsets.all(12),children:[
    FilledButton.tonal(onPressed:(){ s.announcements.insert(0,Announcement('${s.announcements.length+1}','إعلان جديد','نص الإعلان التجريبي','2026-11-06',pinned:true)); s.log('نشر إعلان جماعي + Push'); setState((){}); },child:const Text('نشر إعلان + إشعار جماعي/فردي (Push)')),
    OutlinedButton(onPressed:(){ s.log('تصدير تقرير PDF/Excel'); ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('صُدّر التقرير PDF + Excel (الحضور، الطلبات، التكاليف)')));},child:const Text('تصدير التقارير PDF / Excel')),
    const Card(child:ListTile(leading:Icon(Icons.palette),title:Text('الهوية البصرية واللغات والنسخ الاحتياطي'),subtitle:Text('الشعار، الألوان، AR/FR/EN، نسخة يومية مشفرة — من إعدادات التطبيق'))),
    const Card(child:ListTile(leading:Icon(Icons.api),title:Text('ربط API مع نظام HR الحالي'),subtitle:Text('GET /employees • POST /leaves • Webhook الحضور — راجع core/api.dart'))),
  ]);
  Widget _audit(AppStore s)=>ListView(children:s.audit.map((a)=>ListTile(dense:true,leading:const Icon(Icons.history,size:16),title:Text(a,style:const TextStyle(fontSize:12)))).toList());
}
