import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
class TrainingScreen extends StatelessWidget { const TrainingScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar:AppBar(title:const Text('التدريب')),body:ListView(children:s.courses.map((c)=>Card(child:ListTile(leading:const Icon(Icons.school),title:Text(c.title),subtitle:Text('${c.org} • ${c.date} • ${c.hours}'),trailing:c.registered?const Chip(label:Text('مسجل')):TextButton(child:const Text('سجّل'),onPressed:(){c.registered=true;s.log('تسجيل دورة ${c.title}');ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تم التسجيل')));}),isThreeLine:true))).toList()));
  }
}
