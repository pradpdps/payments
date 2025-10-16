// ...existing code...
import 'package:flutter/material.dart';
import 'package:payments/model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:payments/ui/products.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00796B);
    const backgroundColor = Color(0xFFF5F5F5);

    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, _) {
          Future<void> submit() async {
            if (!_formKey.currentState!.validate()) return;

            // For sign-up flow, show not implemented message (adjust as needed)
            if (!isLogin) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign up not implemented')),
              );
              return;
            }

            final accessToken = await vm.login(
              _userNameController.text.trim(),
              _passwordController.text,
            );

            if (accessToken != null && context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Products(token: accessToken)),
              );
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(vm.error ?? 'Login failed. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }

          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_circle,
                            size: 64, color: primaryColor),
                        const SizedBox(height: 16),
                        Text(
                          isLogin ? 'Welcome Back!' : 'Create Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isLogin
                              ? 'Login to continue shopping'
                              : 'Sign up to start your journey',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (!isLogin)
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (!isLogin &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        if (!isLogin) const SizedBox(height: 16),
                        TextFormField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.account_box),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username cannot be empty';
                            }
                            if (!RegExp(r'^[a-zA-Z0-9_]{3,16}$')
                                .hasMatch(value)) {
                              return 'Username is invalid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            onPressed: vm.isLoading ? null : submit,
                            child: vm.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(isLogin ? 'Login' : 'Sign Up',
                                    style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                              vm.clearError();
                            });
                          },
                          child: Text(
                            isLogin
                                ? "Don't have an account? Sign Up"
                                : "Already have an account? Login",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// ...existing code...
