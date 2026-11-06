import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart'; import '../models/models.dart';

class LeavesScreen extends StatefulWidget { const LeavesScreen({super.key}); @override State<LeavesScreen> createState()=>_V(); }
class _V extends State<LeavesScreen> {
  final types=['سنوية','مرضية','استثنائية','أمومة/أبوة']; String type='سنوية'; DateTime from=DateTime.now(), to=DateTime.now().add(const Duration(days:2));
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar: AppBar(title: const Text('الإجازات')),
      body: ListView(padding:const EdgeInsets.all(12),children:[
        Card(child:Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
          Text('طلب إجازة جديد — الرصيد: ${s.leaveBalance} يوماً',style:const TextStyle(fontWeight:FontWeight.bold)),
          DropdownButtonFormField(value:type,items:types.map((t)=>DropdownMenuItem(value:t,child:Text(t))).toList(),onChanged:(v)=>setState(()=>type=v!)),
          Row(children:[Expanded(child:ListTile(title:const Text('من'),subtitle:Text(from.toString().substring(0,10)),onTap:()=>_pick(true))),Expanded(child:ListTile(title:const Text('إلى'),subtitle:Text(to.toString().substring(0,10)),onTap:()=>_pick(false)))]),
          FilledButton(onPressed:(){ s.leaves.add(LeaveRequest(id:'L${s.leaves.length+1}',employeeId:'me',type:type,from:from,to:to)); s.log('طلب إجازة $type من $from'); setState((){}); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('أُرسل الطلب (يعمل دون إنترنت — مزامنة لاحقة)'))); },child:const Text('إرسال الطلب')),
        ]))),
        const Text('حالة الطلبات',style:TextStyle(fontWeight:FontWeight.bold)),
        ...s.leaves.map((l)=>Card(child:ListTile(title:Text('${l.type}: ${l.from.toString().substring(0,10)} → ${l.to.toString().substring(0,10)}'),trailing:Chip(label:Text(l.status)),subtitle: s.role.isPrivileged? Row(children:[TextButton(onPressed:(){l.status='مقبولة';s.log('قبول إجازة ${l.id}');setState((){});},child:const Text('قبول')),TextButton(onPressed:(){l.status='مرفوضة';s.log('رفض إجازة ${l.id}');setState((){});},child:const Text('رفض'))]):null))),
        const Text('تقويم الفريق (نوفمبر)',style:TextStyle(fontWeight:FontWeight.bold)),
        const Card(child:ListTile(leading:Icon(Icons.calendar_month),title:Text('سارة: 10–12 إجازة سنوية'),subtitle:Text('كريم: 18 مرضية • لا تعارض مع طلبك'))),
      ]));
  }
  Future<void> _pick(bool isFrom) async { final d=await showDatePicker(context:context,firstDate:DateTime(2026,1,1),lastDate:DateTime(2027,12,31),initialDate:isFrom?from:to); if(d!=null) setState(()=>isFrom?from=d:to=d); }
}
