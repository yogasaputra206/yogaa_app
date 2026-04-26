import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            left: -100,
            child: _buildBlurSphere(AppColors.primaryFixed.withOpacity(0.3)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _buildBlurSphere(AppColors.secondaryFixed.withOpacity(0.2)),
          ),
          
          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448), // max-w-md
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 48),
                    _buildGlassCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildInputField(
                              label: 'EMAIL ADDRESS',
                              hint: 'Enter your email',
                              icon: Icons.email_outlined,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildInputField(
                              label: 'PASSWORD',
                              hint: '••••••••',
                              icon: Icons.lock_outline,
                              isPassword: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 8) {
                                  return 'Minimal 8 karakter';
                                }
                                if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
                                  return 'Harus mengandung huruf dan angka';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/forgot_password');
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.2, // tracking-tight
                                  ),
                                ),
                                child: const Text('Forgot Password?'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildLoginButton(),
                            const SizedBox(height: 8),
                            _buildSignUpLink(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildDecorativeDots(),
                    const SizedBox(height: 40),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurSphere(Color color) {
    return Container(
      width: 384,
      height: 384,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF001f29).withOpacity(0.08),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            'assets/images/yogaa.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Yogaa App',
          style: GoogleFonts.manrope(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.04 * 36,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Halo, selamat datang',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.secondary,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Stack(
      children: [
        // Shadow behind the glass
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF001f29).withOpacity(0.06),
                  blurRadius: 64,
                  offset: const Offset(0, 24),
                ),
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(32),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.4, // uppercase tracking-widest
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        _InputDecoratedField(
          hint: hint,
          icon: icon,
          isPassword: isPassword,
          obscureText: _obscureText,
          controller: controller,
          validator: validator,
          onToggleVisibility: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                _isLoading = true;
              });

              // Mock delay process
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;

              setState(() {
                _isLoading = false;
              });

              if (_emailController.text == 'admin@test.com' && _passwordController.text == 'Admin123') {
                Navigator.pushReplacementNamed(context, '/dashboard', arguments: 'Admin User');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Email atau Password salah! (Coba: admin@test.com / Admin123)',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: Colors.red.shade600,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },
          borderRadius: BorderRadius.circular(9999),
          highlightColor: Colors.black12,
          splashColor: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: _isLoading 
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.onPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Login Now',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.secondary,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          child: const Text('Sign Up'),
        ),
      ],
    );
  }

  Widget _buildDecorativeDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) ...[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
          if (i < 2) const SizedBox(width: 16),
        ]
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'VERSION 1.0.0',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.4,
            color: AppColors.onSurfaceVariant.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 48,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.outlineVariant.withOpacity(0.2),
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _InputDecoratedField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const _InputDecoratedField({
    required this.hint,
    required this.icon,
    required this.isPassword,
    required this.obscureText,
    required this.onToggleVisibility,
    this.controller,
    this.validator,
  });

  @override
  State<_InputDecoratedField> createState() => _InputDecoratedFieldState();
}

class _InputDecoratedFieldState extends State<_InputDecoratedField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isFocused ? AppColors.surfaceContainerHighest : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: _isFocused ? Border.all(color: AppColors.surfaceTint.withOpacity(0.2), width: 2) : Border.all(color: Colors.transparent, width: 2),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        focusNode: _focusNode,
        obscureText: widget.isPassword && widget.obscureText,
        style: GoogleFonts.inter(
          color: AppColors.onSurface,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.inter(
            color: AppColors.outline.withOpacity(0.6),
          ),
          prefixIcon: Icon(widget.icon, color: AppColors.outline, size: 20),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.outline,
                    size: 20,
                  ),
                  onPressed: widget.onToggleVisibility,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
