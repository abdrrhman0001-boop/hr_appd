import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
class ContactScreen extends StatefulWidget { const ContactScreen({super.key}); @override State<ContactScreen> createState()=>_C(); }
class _C extends State<ContactScreen> { final msg=TextEditingController();
  @override Widget build(BuildContext context){ final s=context.read<AppStore>();
    return Scaffold(appBar:AppBar(title:const Text('تواصل مع HR')),body:ListView(padding:const EdgeInsets.all(12),children:[
      const Text('أسئلة شائعة',style:TextStyle(fontWeight:FontWeight.bold)),
      const Card(child:ExpansionTile(title:Text('كيف أطلب إجازة؟'),children:[Padding(padding:EdgeInsets.all(12),child:Text('من تبويب الإجازات → طلب جديد → يُرسل للمدير ثم HR.'))])),
      const Card(child:ExpansionTile(title:Text('متى تُصرف السلفة؟'),children:[Padding(padding:EdgeInsets.all(12),child:Text('خلال 72 ساعة بعد موافقة المدير وHR.'))])),
      const Card(child:ExpansionTile(title:Text('كيف أحمّل كشف الراتب؟'),children:[Padding(padding:EdgeInsets.all(12),child:Text('من تبويب راتبي → تحميل PDF.'))])),
      TextField(controller:msg,maxLines:3,decoration:const InputDecoration(labelText:'اكتب رسالتك لـ HR',border:OutlineInputBorder())),
      const SizedBox(height:8),
      FilledButton(onPressed:(){ s.log('مراسلة HR'); setState(()=>msg.clear()); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('أُرسلت رسالتك — سيرد HR قريباً (إشعار Push)')));},child:const Text('إرسال')),
    ]));
  }
}
