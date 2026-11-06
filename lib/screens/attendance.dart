import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';

class AttendanceScreen extends StatelessWidget { const AttendanceScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar: AppBar(title: const Text('الحضور والانصراف')),
      body: ListView(padding:const EdgeInsets.all(12),children:[
        Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[
          const Text('تسجيل اليوم',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16)),
          const SizedBox(height:8),
          Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
            FilledButton.icon(onPressed:(){ s.log('تسجيل حضور GPS'); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تم تسجيل الحضور بالموقع GPS: 08:02')));},icon:const Icon(Icons.location_on),label:const Text('GPS')),
            OutlinedButton.icon(onPressed:(){ s.log('تسجيل حضور QR'); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('وجّه الكاميرا نحو رمز QR عند المدخل')));},icon:const Icon(Icons.qr_code),label:const Text('QR')),
          ]),
          const Text('يُتحقق من الموقع داخل نطاق الشركة + بصمة الجهاز',style:TextStyle(fontSize:11,color:Colors.grey)),
        ]))),
        const Text('السجل الشهري — أكتوبر',style:TextStyle(fontWeight:FontWeight.bold)),
        ...s.attendance.map((a)=>ListTile(dense:true,leading:Icon(a.status=='حاضر'?Icons.check_circle:Icons.cancel,color:a.status=='حاضر'?Colors.green:Colors.red),title:Text(a.date),trailing:Text('${a.checkIn??'—'} → ${a.checkOut??'—'}'))),
      ]));
  }
}
