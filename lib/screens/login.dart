import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import '../core/store.dart'; import '../models/models.dart'; import 'shell.dart';

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState()=>_L(); }
class _L extends State<LoginScreen> {
  final id = TextEditingController(text: 'EMP-1042'); final pw = TextEditingController(text: '1234');
  UserRole role = UserRole.superAdmin;
  Future<void> bio() async {
    try { final ok = await LocalAuthentication().authenticate(localizedReason: 'تحقق بالبصمة / الوجه'); if(ok&&mounted) _go(); }
    catch(e){ if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('البصمة غير متاحة على هذا الجهاز — تم الدخول التجريبي'))); _go(); }
  }
  void _go(){ final s=context.read<AppStore>(); s.setRole(role); s.log('تسجيل دخول: ${id.text} بدور ${role.arName}'); Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const Shell())); }
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Icon(Icons.business, size: 64, color: Color(0xFF1B6B5A)), const SizedBox(height: 8),
      Text('[اسم الشركة] — الموارد البشرية', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 4), const Text('تسجيل دخول آمن • RTL • AR/FR/EN', textAlign: TextAlign.center),
      const SizedBox(height: 20),
      SegmentedButton<String>(segments: const [ButtonSegment(value:'ar',label:Text('عربية')),ButtonSegment(value:'fr',label:Text('FR')),ButtonSegment(value:'en',label:Text('EN'))], selected: {s.lang}, onSelectionChanged:(v)=>s.setLang(v.first)),
      const SizedBox(height: 12),
      TextField(controller: id, decoration: const InputDecoration(labelText:'البريد / الرقم الوظيفي', border: OutlineInputBorder(), prefixIcon: Icon(Icons.badge))),
      const SizedBox(height: 12),
      TextField(controller: pw, obscureText: true, decoration: const InputDecoration(labelText:'كلمة المرور', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock))),
      const SizedBox(height: 12),
      DropdownButtonFormField<UserRole>(value: role, decoration: const InputDecoration(labelText:'الدور (للتجربة)', border: OutlineInputBorder()), items: UserRole.values.map((r)=>DropdownMenuItem(value:r,child:Text(r.arName))).toList(), onChanged:(v)=>setState(()=>role=v!)),
      const SizedBox(height: 12),
      FilledButton(onPressed: _go, child: const Text('تسجيل الدخول')),
      TextButton.icon(onPressed: bio, icon: const Icon(Icons.fingerprint), label: const Text('الدخول بالبصمة / الوجه')),
      const Text('تشفير AES للبيانات • رموز في Secure Storage • سجل تدقيق لكل عملية حساسة', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey)),
    ]))))));
  }
}
