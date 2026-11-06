import 'package:flutter/material.dart';
import 'payslip.dart'; import 'requests.dart'; import 'training.dart'; import 'performance.dart'; import 'recruitment.dart'; import 'directory.dart'; import 'contact.dart';
class MoreScreen extends StatelessWidget { const MoreScreen({super.key});
  @override Widget build(BuildContext context){
    final tiles=[(Icons.payments,'كشف الراتب',const PayslipScreen()),(Icons.description,'الطلبات الإدارية',const RequestsScreen()),(Icons.school,'التدريب',const TrainingScreen()),(Icons.insights,'تقييم الأداء',const PerformanceScreen()),(Icons.work,'التوظيف الداخلي',const RecruitmentScreen()),(Icons.people,'دليل الموظفين',const DirectoryScreen()),(Icons.support_agent,'تواصل مع HR',const ContactScreen())];
    return Scaffold(appBar:AppBar(title:const Text('المزيد')),body:ListView(children:tiles.map((t)=>Card(child:ListTile(leading:Icon(t.$1,color:Colors.teal),title:Text(t.$2),trailing:const Icon(Icons.chevron_left),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>t.$3))))).toList()));
  }
}
