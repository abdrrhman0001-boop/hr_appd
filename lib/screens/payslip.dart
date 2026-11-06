import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
class PayslipScreen extends StatelessWidget { const PayslipScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar:AppBar(title:const Text('كشف الراتب')),body:ListView(children:s.payslips.map((p)=>Card(child:ExpansionTile(leading:const Icon(Icons.receipt_long),title:Text('شهر ${p.month}'),subtitle:Text('الصافي: ${p.net} دج'),children:[ListTile(title:Text('الإجمالي: ${p.gross} • الاقتطاعات: ${p.deductions} • الصافي: ${p.net}')),ButtonBar(children:[TextButton(onPressed:(){s.log('تحميل كشف ${p.month}');ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تحميل PDF (مشفر)')));},child:const Text('تحميل PDF'))])]))).toList()));
  }
}
