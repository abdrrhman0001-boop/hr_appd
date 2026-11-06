import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';

class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>(); final me=s.employees.first;
    return Scaffold(appBar: AppBar(title: const Text('الملف الشخصي')),
      body: ListView(padding:const EdgeInsets.all(12),children:[
        Card(child:Padding(padding:const EdgeInsets.all(16),child:Row(children:[const CircleAvatar(radius:32,child:Icon(Icons.person,size:40)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(me.name,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:18)),Text('${me.position} • ${me.department}'),Text('${me.jobNumber} • منذ ${me.hireDate.year}')]))]))),
        Card(child:Column(children:[
          ListTile(leading:const Icon(Icons.phone),title:Text(me.phone),subtitle:const Text('الهاتف')),
          ListTile(leading:const Icon(Icons.email),title:Text(me.email),subtitle:const Text('البريد')),
          ListTile(leading:const Icon(Icons.payments),title:Text('الراتب: ${me.salary} دج'),subtitle:const Text('المدير المباشر: يحدده المشرف')),
        ])),
        const Text('الوثائق الإدارية',style:TextStyle(fontWeight:FontWeight.bold)),
        ...['عقد العمل','بطاقة الهوية','شهادة العمل','كشف السوابق'].map((d)=>Card(child:ListTile(leading:const Icon(Icons.picture_as_pdf,color:Colors.red),title:Text(d),trailing:TextButton(child:const Text('تحميل'),onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('تحميل $d (PDF مشفر)'))))))),
        FilledButton.tonal(onPressed:(){ s.log('طلب شهادة عمل'); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('طُلبت شهادة العمل — ستصلك PDF موقعة')));},child:const Text('طلب شهادة عمل')),
      ]));
  }
}
