import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'dart:ui';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
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
                constraints: const BoxConstraints(maxWidth: 448),
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
                            ),
                            const SizedBox(height: 32),
                            _buildResetButton(context),
                          ],
                        ),
                      ),
                    ),
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
          child: const Icon(
            Icons.lock_reset,
            size: 40,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Reset Password',
          style: GoogleFonts.manrope(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.04 * 32,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email to reset your password',
          textAlign: TextAlign.center,
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
              letterSpacing: 2.4,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Format email tidak valid';
              }
              return null;
            },
            style: GoogleFonts.inter(
              color: AppColors.onSurface,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: AppColors.outline.withOpacity(0.6),
              ),
              prefixIcon: Icon(icon, color: AppColors.outline, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetButton(BuildContext context) {
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
              
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              
              setState(() {
                _isLoading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link reset telah dikirim ke email Anda')),
              );
              Navigator.pop(context);
            }
          },
          borderRadius: BorderRadius.circular(9999),
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
                    'Kirim Link Reset',
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
}
