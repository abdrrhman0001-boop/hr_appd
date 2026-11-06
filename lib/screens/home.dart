import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
import 'leaves.dart'; import 'attendance.dart'; import 'payslip.dart'; import 'requests.dart'; import 'directory.dart'; import 'contact.dart';

class HomeScreen extends StatelessWidget { const HomeScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    final shortcuts=[(Icons.beach_access,'إجازة',const LeavesScreen()),(Icons.qr_code,'تسجيل حضور',const AttendanceScreen()),(Icons.payments,'راتبي',const PayslipScreen()),(Icons.description,'طلب إداري',const RequestsScreen()),(Icons.people,'الدليل',const DirectoryScreen()),(Icons.support_agent,'تواصل HR',const ContactScreen())];
    return Scaffold(appBar: AppBar(title: const Text('الرئيسية'), actions:[IconButton(icon:const Icon(Icons.notifications), onPressed:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('الإشعارات (Push)'),content:const Text('• تم قبول طلبك\n• تذكير: تقييم الأداء قبل 20 نوفمبر\n• إعلان جديد من HR'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('حسناً'))])))]),
      body: ListView(children:[
        if(s.offline) const ListTile(tileColor:Colors.orange, leading:Icon(Icons.wifi_off), title:Text('وضع دون إنترنت — ستُزامَن الطلبات لاحقاً')),
        const Padding(padding:EdgeInsets.all(12),child:Text('إعلانات الشركة',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))),
        ...s.announcements.map((a)=>Card(child:ListTile(leading:Icon(a.pinned?Icons.push_pin:Icons.campaign,color:Colors.teal),title:Text(a.title,style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${a.body}\n${a.date}')))),
        const Padding(padding:EdgeInsets.all(12),child:Text('اختصارات سريعة',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))),
        Padding(padding:const EdgeInsets.symmetric(horizontal:12),child:GridView.count(crossAxisCount:3,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),children:shortcuts.map((e)=>Card(child:InkWell(onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>e.$3)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(e.$1,color:Colors.teal),const SizedBox(height:6),Text(e.$2,textAlign:TextAlign.center)])))).toList())),
        Padding(padding:const EdgeInsets.all(12),child:Card(color:Colors.teal.shade50,child:ListTile(leading:const Icon(Icons.info),title:Text('رصيد إجازاتك: ${s.leaveBalance} يوماً'),subtitle:const Text('تقويم الفريق: 3 زملاء في إجازة هذا الأسبوع')))),
      ]));
  }
}
