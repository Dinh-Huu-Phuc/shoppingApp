import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _doRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService().register(_email.text.trim(), _password.text.trim());
      if (mounted) Navigator.of(context).pop(); // quay lại Login
    } on FirebaseAuthException catch (e) {
      final msg = switch (e.code) {
        'email-already-in-use' => 'Email đã tồn tại.',
        'weak-password' => 'Mật khẩu quá yếu.',
        'invalid-email' => 'Email không hợp lệ.',
        _ => 'Lỗi đăng ký: ${e.message ?? e.code}',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo tài khoản')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Nhập email';
                          if (!RegExp(r'^.+@.+\..+\$').hasMatch(v)) return 'Email không hợp lệ';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _password,
                        obscureText: _obscure1,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscure1 = !_obscure1),
                          ),
                        ),
                        validator: (v) => (v == null || v.length < 6) ? 'Tối thiểu 6 ký tự' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirm,
                        obscureText: _obscure2,
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscure2 = !_obscure2),
                          ),
                        ),
                        validator: (v) => v != _password.text ? 'Mật khẩu không khớp' : null,
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: _loading ? null : _doRegister,
                        child: _loading
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Đăng ký'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}