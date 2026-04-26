import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/blur_sphere.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Dummy list of items for GridView.builder
  final List<Map<String, dynamic>> _menuItems = const [
    {'title': 'Schedule', 'icon': Icons.calendar_month, 'color': AppColors.tertiary},
    {'title': 'Classes', 'icon': Icons.play_lesson, 'color': AppColors.primary},
    {'title': 'Trainers', 'icon': Icons.people, 'color': AppColors.secondary},
    {'title': 'Community', 'icon': Icons.forum, 'color': AppColors.outline},
    {'title': 'Progress', 'icon': Icons.trending_up, 'color': Colors.green},
    {'title': 'Nutrition', 'icon': Icons.restaurant, 'color': Colors.orange},
    {'title': 'Mindfulness', 'icon': Icons.self_improvement, 'color': Colors.purple},
    {'title': 'Shop', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'title': 'Support', 'icon': Icons.help_outline, 'color': Colors.teal},
    {'title': 'Settings', 'icon': Icons.settings, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve the user email passed from LoginScreen
    final String userEmail = ModalRoute.of(context)?.settings.arguments as String? ?? 'yogauser@test.com';

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.outline),
            onPressed: () {
              // Menghapus semua riwayat navigator dan kembali ke login
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            tooltip: 'Logout',
          )
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            right: -100,
            child: const BlurSphere(color: Color(0xFFb9eaff)),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: const BlurSphere(color: Color(0xFFc9e7f5)),
          ),
          
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1024),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildUserGreeting(userEmail),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildWelcomeCard(),
                            const SizedBox(height: 24),
                            Text(
                              'Quick Actions',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(child: _buildActionGrid()),
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

  Widget _buildUserGreeting(String userEmail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceContainerHighest, width: 2),
            ),
            child: const Icon(Icons.person, color: AppColors.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat datang,',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ),
                Text(
                  userEmail,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card( // Menggunakan spesifik widget Card sesuai ketentuan
      elevation: 8,
      shadowColor: AppColors.primary.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ready for Yoga?',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Join your scheduled session in 30 minutes.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.onPrimary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerLowest,
                foregroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                'Join Session',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        double childAspectRatio = constraints.maxWidth > 600 ? 1.5 : 1.1;

        // Menggunakan GridView.builder dengan 10+ item dummy sesuai kriteria ujian
        return GridView.builder(
          itemCount: _menuItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = _menuItems[index];
            return _buildActionCard(item['title'], item['icon'], item['color']);
          },
        );
      },
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shadowColor: const Color(0xFF001f29).withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: AppColors.surfaceContainerLowest,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
