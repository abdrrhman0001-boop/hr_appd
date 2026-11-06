import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart'; import '../models/models.dart';
class RequestsScreen extends StatefulWidget { const RequestsScreen({super.key}); @override State<RequestsScreen> createState()=>_R(); }
class _R extends State<RequestsScreen> {
  String kind='إذن خروج'; final det=TextEditingController();
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar:AppBar(title:const Text('الطلبات الإدارية')),body:ListView(padding:const EdgeInsets.all(12),children:[
      Card(child:Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
        const Text('طلب جديد',style:TextStyle(fontWeight:FontWeight.bold)),
        DropdownButtonFormField(value:kind,items:['إذن خروج','سلفة','شهادة راتب','أخرى'].map((k)=>DropdownMenuItem(value:k,child:Text(k))).toList(),onChanged:(v)=>setState(()=>kind=v!)),
        TextField(controller:det,decoration:const InputDecoration(labelText:'التفاصيل (المبلغ/السبب/التاريخ)')),
        const SizedBox(height:8),
        FilledButton(onPressed:(){ s.adminRequests.add(AdminRequest(id:'R${s.adminRequests.length+1}',employeeId:'me',kind:kind,details:det.text)); s.log('طلب $kind'); setState(()=>det.clear()); },child:const Text('إرسال')),
      ]))),
      const Text('تتبع الحالة',style:TextStyle(fontWeight:FontWeight.bold)),
      ...s.adminRequests.map((r)=>Card(child:ListTile(title:Text('${r.kind} — ${r.details}'),subtitle:Text(r.createdAt.toString().substring(0,16)),trailing:Chip(label:Text(r.status)),onTap: s.role.isPrivileged? ()=>showDialog(context:context,builder:(_)=>SimpleDialog(title:Text(r.kind),children:['معلقة','قيد المعالجة','مقبولة','مرفوضة'].map((st)=>SimpleDialogOption(child:Text(st),onPressed:(){r.status=st;s.log('تعديل طلب ${r.id} إلى $st');setState((){});Navigator.pop(context);})).toList())):null))),
    ]));
  }
}
