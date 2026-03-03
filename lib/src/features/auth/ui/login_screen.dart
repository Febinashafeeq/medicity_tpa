import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/constants/responsive_helper.dart';
import '../../../shared/theme/app_colors.dart';
import '../providers/authclass.dart';




//
// // ── Login Screen ─────────────────────────────────────────────────────────────
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey       = GlobalKey<FormState>();
//   final _emailCtrl     = TextEditingController();
//   final _passwordCtrl  = TextEditingController();
//   final adminAuth = AdminAuthService();
//
//   Future<void> _onSignInss() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     try {
//       setState(() => _isLoading = true);
//
//       await adminAuth.signInAdmin(
//         email: _emailCtrl.text.trim(),
//         password: _passwordCtrl.text.trim(),
//       );
//       if (mounted) {
//         setState(() => _isLoading = false);
//         // Navigate to dashboard on success
//         context.go('/dashboard');
//       }
//
//     } catch (e) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = e.toString().replaceAll('Exception:', '');
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//   Future<void> _onSignIn() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     try {
//       setState(() => _isLoading = true);
//
//       await adminAuth.signInAdmin(
//         email: _emailCtrl.text.trim(),
//         password: _passwordCtrl.text.trim(),
//       );
//
//       if (!mounted) return;
//       context.go('/dashboard');
//
//     } catch (e) {
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             e.toString().replaceAll('Exception:', '').trim(),
//           ),
//           backgroundColor: Colors.red.shade600,
//           behavior: SnackBarBehavior.floating,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
//
//   bool _obscurePassword   = true;
//   bool _isLoading         = false;
//   bool _hasError          = false;
//   String _errorMessage    = '';
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }
//
//   void _onSignIns() async {
//     setState(() { _hasError = false; _errorMessage = ''; });
//
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (mounted) {
//       setState(() => _isLoading = false);
//       // Navigate to dashboard on success
//       context.go('/dashboard');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // ── Left Brand Panel ────────────────────────────────
//           const Expanded(
//             flex: 40,
//             child: _LeftPanel(),
//           ),
//
//           // ── Right Form Panel ────────────────────────────────
//           Expanded(
//             flex: 60,
//             child: _RightPanel(
//               formKey: _formKey,
//               emailCtrl: _emailCtrl,
//               passwordCtrl: _passwordCtrl,
//               obscurePassword: _obscurePassword,
//               onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
//               isLoading: _isLoading,
//               hasError: _hasError,
//               errorMessage: _errorMessage,
//               onSignIn: _onSignIn,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  LEFT PANEL
// // ════════════════════════════════════════════════════════════
// class _LeftPanel extends StatelessWidget {
//   const _LeftPanel();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF0B833D),
//             Color(0xFF076B30),
//             Color(0xFF054D23),
//           ],
//           stops: [0.0, 0.55, 1.0],
//         ),
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background pattern
//           CustomPaint(painter: _GridPatternPainter()),
//
//           // Corner circles
//           Positioned(
//             top: -100, left: -100,
//             child: _circle(300, Colors.white.withOpacity(0.04)),
//           ),
//           Positioned(
//             bottom: -80, right: -80,
//             child: _circle(240, Colors.white.withOpacity(0.04)),
//           ),
//           Positioned(
//             top: -60, left: -60,
//             child: _circleOutline(200, Colors.white.withOpacity(0.07)),
//           ),
//
//           // Radial glow bottom-right
//           Positioned(
//             bottom: -100, right: -100,
//             child: Container(
//               width: 500, height: 500,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(colors: [
//                   Colors.white.withOpacity(0.06),
//                   Colors.transparent,
//                 ]),
//               ),
//             ),
//           ),
//
//           // Content
//           Padding(
//             padding: const EdgeInsets.all(48),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Logo
//                 _LogoBlock(),
//
//                 // Illustration + headline
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Illustration
//                       _ShieldIllustration(),
//                       const SizedBox(height: 36),
//
//                       // Headline
//                       Text(
//                         'Streamline Your\nTPA Operations',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.inter(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                           height: 1.3,
//                           letterSpacing: -0.3,
//                         ),
//                       )
//                           .animate(delay: 300.ms)
//                           .fadeIn(duration: 600.ms)
//                           .slideY(begin: 0.2, end: 0),
//
//                       const SizedBox(height: 12),
//
//                       Text(
//                         'Manage claims, patients, and insurance\ncompanies in one unified ledger platform.',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white.withOpacity(0.65),
//                           height: 1.6,
//                         ),
//                       )
//                           .animate(delay: 400.ms)
//                           .fadeIn(duration: 600.ms),
//                     ],
//                   ),
//                 ),
//
//                 // Feature pills
//                 _FeatureList(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _circle(double size, Color color) => Container(
//     width: size, height: size,
//     decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//   );
//
//   Widget _circleOutline(double size, Color borderColor) => Container(
//     width: size, height: size,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       border: Border.all(color: borderColor, width: 1),
//     ),
//   );
// }
//
// // ── Logo Block ───────────────────────────────────────────────────────────────
// class _LogoBlock extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Icon
//         Container(
//           width: 44, height: 44,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
//           ),
//           child: const Center(
//             child: _MiniShieldIcon(),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'MediAssure',
//               style: GoogleFonts.inter(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.white,
//                 letterSpacing: -0.3,
//               ),
//             ),
//             Text(
//               'Medical Insurance Ledger',
//               style: GoogleFonts.inter(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white.withOpacity(0.65),
//               ),
//             ),
//           ],
//         ),
//       ],
//     )
//         .animate()
//         .fadeIn(duration: 600.ms)
//         .slideX(begin: -0.2, end: 0);
//   }
// }
//
// // ── Shield Illustration ──────────────────────────────────────────────────────
// class _ShieldIllustration extends StatefulWidget {
//   @override
//   State<_ShieldIllustration> createState() => _ShieldIllustrationState();
// }
//
// class _ShieldIllustrationState extends State<_ShieldIllustration>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _floatCtrl;
//   late Animation<double> _floatAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _floatCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3000),
//     )..repeat(reverse: true);
//     _floatAnim = Tween<double>(begin: 0, end: -12).animate(
//       CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _floatCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _floatAnim,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _floatAnim.value),
//           child: child,
//         );
//       },
//       child: SizedBox(
//         width: 200, height: 200,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Outer glow ring
//             Container(
//               width: 200, height: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.06),
//               ),
//             ),
//             Container(
//               width: 155, height: 155,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.06),
//               ),
//             ),
//             // Shield
//             SizedBox(
//               width: 110, height: 110,
//               child: CustomPaint(
//                 painter: _LargeShieldPainter(),
//               ),
//             ),
//           ],
//         ),
//       ).animate(delay: 200.ms).fadeIn(duration: 800.ms).scale(
//         begin: const Offset(0.8, 0.8),
//         end: const Offset(1.0, 1.0),
//       ),
//     );
//   }
// }
//
// // ── Feature List ─────────────────────────────────────────────────────────────
// class _FeatureList extends StatelessWidget {
//   final _features = const [
//     (icon: Icons.business_rounded,       label: 'Multi-TPA & Insurer Management'),
//     (icon: Icons.biotech_rounded,        label: 'Daily Sample Collection Tracking'),
//     (icon: Icons.receipt_long_rounded,   label: 'Invoice-based Payment Ledger'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: _features.asMap().entries.map((entry) {
//         final i = entry.key;
//         final f = entry.value;
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: _FeatureItem(icon: f.icon, label: f.label)
//               .animate(delay: Duration(milliseconds: 500 + (i * 100)))
//               .fadeIn(duration: 500.ms)
//               .slideX(begin: -0.2, end: 0),
//         );
//       }).toList(),
//     );
//   }
// }
//
// class _FeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _FeatureItem({required this.icon, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 30, height: 30,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: Colors.white, size: 15),
//           ),
//           const SizedBox(width: 12),
//           Text(
//             label,
//             style: GoogleFonts.inter(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: Colors.white.withOpacity(0.85),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ════════════════════════════════════════════════════════════
// //  RIGHT PANEL
// // ════════════════════════════════════════════════════════════
// class _RightPanel extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailCtrl;
//   final TextEditingController passwordCtrl;
//   final bool obscurePassword;
//   final VoidCallback onToggleObscure;
//   final bool isLoading;
//   final bool hasError;
//   final String errorMessage;
//   final VoidCallback onSignIn;
//
//   const _RightPanel({
//     required this.formKey,
//     required this.emailCtrl,
//     required this.passwordCtrl,
//     required this.obscurePassword,
//     required this.onToggleObscure,
//     required this.isLoading,
//     required this.hasError,
//     required this.errorMessage,
//     required this.onSignIn,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       color: AppColors.surface,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Subtle green radial glow
//           Positioned(
//             top: -100, right: -100,
//             child: Container(
//               width: 400, height: 400,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(colors: [
//                   AppColors.primary.withOpacity(0.05),
//                   Colors.transparent,
//                 ]),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -80, left: -80,
//             child: Container(
//               width: 300, height: 300,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(colors: [
//                   AppColors.primary.withOpacity(0.04),
//                   Colors.transparent,
//                 ]),
//               ),
//             ),
//           ),
//
//           // Center form card
//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(48),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 460),
//                 child: _LoginCard(
//                   formKey: formKey,
//                   emailCtrl: emailCtrl,
//                   passwordCtrl: passwordCtrl,
//                   obscurePassword: obscurePassword,
//                   onToggleObscure: onToggleObscure,
//                   isLoading: isLoading,
//                   hasError: hasError,
//                   errorMessage: errorMessage,
//                   onSignIn: onSignIn,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Login Card ───────────────────────────────────────────────────────────────
// class _LoginCard extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailCtrl;
//   final TextEditingController passwordCtrl;
//   final bool obscurePassword;
//   final VoidCallback onToggleObscure;
//   final bool isLoading;
//   final bool hasError;
//   final String errorMessage;
//   final VoidCallback onSignIn;
//
//   const _LoginCard({
//     required this.formKey,
//     required this.emailCtrl,
//     required this.passwordCtrl,
//     required this.obscurePassword,
//     required this.onToggleObscure,
//     required this.isLoading,
//     required this.hasError,
//     required this.errorMessage,
//     required this.onSignIn,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 24, offset: const Offset(0, 4)),
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4,  offset: const Offset(0, 1)),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Green top accent bar
//             Container(
//               height: 3,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primary, Colors.transparent],
//                 ),
//               ),
//             ),
//
//             // Card body
//             Padding(
//               padding: const EdgeInsets.all(44),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header
//                     _CardHeader(),
//                     const SizedBox(height: 28),
//
//
//                     // Error banner
//                     if (hasError) ...[
//                       _ErrorBanner(message: errorMessage),
//                       const SizedBox(height: 16),
//                     ],
//
//                     // Email field
//                     const _FormLabel(text: 'Email Address'),
//                     const SizedBox(height: 7),
//                     TextFormField(
//                       controller: emailCtrl,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         hintText: 'admin@mediassure.com',
//                         prefixIcon: Icon(
//                           Icons.email_outlined,
//                           size: 18,
//                           color: hasError ? AppColors.error : AppColors.textLight,
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) return 'Email is required';
//                         if (!v.contains('@')) return 'Enter a valid email';
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 18),
//
//                     // Password field
//                     const _FormLabel(text: 'Password'),
//                     const SizedBox(height: 7),
//                     TextFormField(
//                       controller: passwordCtrl,
//                       obscureText: obscurePassword,
//                       decoration: InputDecoration(
//                         hintText: 'Enter your password',
//                         prefixIcon: Icon(
//                           Icons.lock_outline_rounded,
//                           size: 18,
//                           color: hasError ? AppColors.error : AppColors.textLight,
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             obscurePassword
//                                 ? Icons.visibility_outlined
//                                 : Icons.visibility_off_outlined,
//                             size: 18,
//                             color: AppColors.textLight,
//                           ),
//                           onPressed: onToggleObscure,
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) return 'Password is required';
//                         if (v.length < 6) return 'Minimum 6 characters';
//                         return null;
//                       },
//                       onFieldSubmitted: (_) => onSignIn(),
//                     ),
//                     const SizedBox(height: 10),
//
//                     // Forgot password
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         style: TextButton.styleFrom(
//                           foregroundColor: AppColors.primary,
//                           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                           textStyle: GoogleFonts.inter(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 13,
//                           ),
//                         ),
//                         child: const Text('Forgot password?'),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Sign In Button
//                     _SignInButton(isLoading: isLoading, onSignIn: onSignIn),
//                     const SizedBox(height: 20),
//
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
//         .animate()
//         .fadeIn(duration: 600.ms)
//         .slideY(begin: 0.15, end: 0, duration: 600.ms, curve: Curves.easeOut);
//   }
// }
//
// // ── Card Header ──────────────────────────────────────────────────────────────
// class _CardHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Welcome Back 👋',
//           style: GoogleFonts.inter(
//             fontSize: 26,
//             fontWeight: FontWeight.w800,
//             color: AppColors.textDark,
//             letterSpacing: -0.5,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           'Sign in to your MediAssure account',
//           style: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: AppColors.textMid,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// // ── Error Banner ─────────────────────────────────────────────────────────────
// class _ErrorBanner extends StatelessWidget {
//   final String message;
//   const _ErrorBanner({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: AppColors.error.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.error.withOpacity(0.25), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               message,
//               style: GoogleFonts.inter(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.error,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).animate().shake(duration: 400.ms);
//   }
// }
//
// // ── Form Label ───────────────────────────────────────────────────────────────
// class _FormLabel extends StatelessWidget {
//   final String text;
//   const _FormLabel({required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: GoogleFonts.inter(
//         fontSize: 13,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textDark,
//         letterSpacing: 0.1,
//       ),
//     );
//   }
// }
//
// // ── Sign In Button ───────────────────────────────────────────────────────────
// class _SignInButton extends StatelessWidget {
//   final bool isLoading;
//   final VoidCallback onSignIn;
//   const _SignInButton({required this.isLoading, required this.onSignIn});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onSignIn,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           disabledBackgroundColor: AppColors.primary.withOpacity(0.7),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           elevation: 0,
//           shadowColor: AppColors.primary.withOpacity(0.3),
//         ),
//         child: isLoading
//             ? const SizedBox(
//           width: 20, height: 20,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.5,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )
//             : Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Sign In',
//               style: GoogleFonts.inter(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.arrow_forward_rounded, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Grid Pattern Painter ─────────────────────────────────────────────────────
// class _GridPatternPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.04)
//       ..strokeWidth = 1;
//     const step = 40.0;
//     for (double x = 0; x < size.width; x += step) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }
//     for (double y = 0; y < size.height; y += step) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // ── Large Shield Painter ─────────────────────────────────────────────────────
// class _LargeShieldPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//
//     // Outer shield
//     final outerPaint = Paint()
//       ..color = Colors.white.withOpacity(0.15)
//       ..style = PaintingStyle.fill;
//
//     final outerBorder = Paint()
//       ..color = Colors.white.withOpacity(0.25)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//
//     final shieldPath = Path()
//       ..moveTo(w * 0.5, 0)
//       ..lineTo(w * 0.05, h * 0.18)
//       ..lineTo(w * 0.05, h * 0.52)
//       ..cubicTo(w * 0.05, h * 0.82, w * 0.25, h * 0.96, w * 0.5, h)
//       ..cubicTo(w * 0.75, h * 0.96, w * 0.95, h * 0.82, w * 0.95, h * 0.52)
//       ..lineTo(w * 0.95, h * 0.18)
//       ..close();
//
//     canvas.drawPath(shieldPath, outerPaint);
//     canvas.drawPath(shieldPath, outerBorder);
//
//     // Inner shield
//     final innerPaint = Paint()
//       ..color = Colors.white.withOpacity(0.10)
//       ..style = PaintingStyle.fill;
//
//     final innerPath = Path()
//       ..moveTo(w * 0.5, h * 0.08)
//       ..lineTo(w * 0.13, h * 0.24)
//       ..lineTo(w * 0.13, h * 0.53)
//       ..cubicTo(w * 0.13, h * 0.78, w * 0.30, h * 0.92, w * 0.5, h * 0.96)
//       ..cubicTo(w * 0.70, h * 0.92, w * 0.87, h * 0.78, w * 0.87, h * 0.53)
//       ..lineTo(w * 0.87, h * 0.24)
//       ..close();
//
//     canvas.drawPath(innerPath, innerPaint);
//
//     // Cross
//     final crossPaint = Paint()
//       ..color = Colors.white.withOpacity(0.90)
//       ..style = PaintingStyle.fill;
//
//     final crossRadius = Radius.circular(w * 0.06);
//
//     // Vertical
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(w * 0.43, h * 0.30, w * 0.14, h * 0.42),
//         crossRadius,
//       ),
//       crossPaint,
//     );
//
//     // Horizontal
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(w * 0.30, h * 0.43, w * 0.40, h * 0.14),
//         crossRadius,
//       ),
//       crossPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // ── Mini Shield Icon ─────────────────────────────────────────────────────────
// class _MiniShieldIcon extends StatelessWidget {
//   const _MiniShieldIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 22, height: 22,
//       child: CustomPaint(painter: _MiniShieldPainter()),
//     );
//   }
// }
//
// class _MiniShieldPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//
//     final shieldPaint = Paint()..color = Colors.white.withOpacity(0.9);
//     final shieldPath = Path()
//       ..moveTo(w * 0.5, 0)
//       ..lineTo(w * 0.05, h * 0.2)
//       ..lineTo(w * 0.05, h * 0.52)
//       ..cubicTo(w * 0.05, h * 0.80, w * 0.25, h * 0.95, w * 0.5, h)
//       ..cubicTo(w * 0.75, h * 0.95, w * 0.95, h * 0.80, w * 0.95, h * 0.52)
//       ..lineTo(w * 0.95, h * 0.2)
//       ..close();
//
//     canvas.drawPath(shieldPath, shieldPaint);
//
//     final crossPaint = Paint()..color = AppColors.primary;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(w * 0.43, h * 0.28, w * 0.14, h * 0.44),
//         const Radius.circular(2),
//       ),
//       crossPaint,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(w * 0.28, h * 0.43, w * 0.44, h * 0.14),
//         const Radius.circular(2),
//       ),
//       crossPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

/// changed for responsive

// lib/src/features/auth/ui/login_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
//  RESPONSIVE LOGIN SCREEN
//  • Desktop  (≥1024px) : Left brand panel (40%) + Right form panel (60%)
//  • Tablet   (600–1023): Full-screen form with top brand header bar
//  • Mobile   (<600px)  : Full-screen scrollable form, compact brand header
// ─────────────────────────────────────────────────────────────────────────────



// ════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final adminAuth     = AdminAuthService();

  bool _obscurePassword = true;
  bool _isLoading       = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await adminAuth.signInAdmin(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      if (!mounted) return;
      context.go('/dashboard');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception:', '').trim()),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── Desktop ────────────────────────────────────────────
    if (ResponsiveHelper.isDesktop(context)) {
      return Scaffold(
        body: Row(children: [
          const Expanded(flex: 40, child: _LeftPanel()),
          Expanded(
            flex: 60,
            child: _RightFormPanel(
              formKey: _formKey,
              emailCtrl: _emailCtrl,
              passwordCtrl: _passwordCtrl,
              obscurePassword: _obscurePassword,
              onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
              isLoading: _isLoading,
              onSignIn: _onSignIn,
            ),
          ),
        ]),
      );
    }

    // ── Tablet & Mobile ────────────────────────────────────
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background glows
          Positioned(
            top: -100, right: -100,
            child: _GlowCircle(size: 350, opacity: 0.05),
          ),
          Positioned(
            bottom: -80, left: -80,
            child: _GlowCircle(size: 280, opacity: 0.04),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.pagePadding(context),
                vertical: 24,
              ),
              child: Column(
                children: [
                  // ── Compact brand header ──────────────────
                  _CompactBrandHeader(),
                  const SizedBox(height: 32),

                  // ── Login card ────────────────────────────
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: ResponsiveHelper.isTablet(context) ? 480 : double.infinity,
                      ),
                      child: _LoginCard(
                        formKey: _formKey,
                        emailCtrl: _emailCtrl,
                        passwordCtrl: _passwordCtrl,
                        obscurePassword: _obscurePassword,
                        onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                        isLoading: _isLoading,
                        onSignIn: _onSignIn,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Feature pills (collapsed version) ─────
                  _CompactFeatureRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  COMPACT BRAND HEADER  (tablet + mobile)
// ════════════════════════════════════════════════════════════
class _CompactBrandHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon + name row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.health_and_safety_rounded,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MediAssure',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        letterSpacing: -0.3)),
                Text('TPA Ledger System',
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textLight)),
              ],
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }
}

// ════════════════════════════════════════════════════════════
//  COMPACT FEATURE ROW  (tablet + mobile — horizontal chips)
// ════════════════════════════════════════════════════════════
class _CompactFeatureRow extends StatelessWidget {
  final _features = const [
    (icon: Icons.business_rounded,     label: 'Multi-TPA'),
    (icon: Icons.biotech_rounded,      label: 'Collections'),
    (icon: Icons.receipt_long_rounded, label: 'Invoices'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: _features.map((f) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(f.icon, size: 14, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(f.label,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
          ],
        ),
      )).toList(),
    ).animate(delay: 300.ms).fadeIn(duration: 500.ms);
  }
}

// ════════════════════════════════════════════════════════════
//  LEFT PANEL  (desktop only)
// ════════════════════════════════════════════════════════════
class _LeftPanel extends StatelessWidget {
  const _LeftPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B833D), Color(0xFF076B30), Color(0xFF054D23)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _GridPatternPainter()),
          Positioned(top: -100, left: -100,
              child: _circle(300, Colors.white.withOpacity(0.04))),
          Positioned(bottom: -80, right: -80,
              child: _circle(240, Colors.white.withOpacity(0.04))),
          Positioned(top: -60, left: -60,
              child: _circleOutline(200, Colors.white.withOpacity(0.07))),
          Positioned(
            bottom: -100, right: -100,
            child: Container(
              width: 500, height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  Colors.white.withOpacity(0.06), Colors.transparent,
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LogoBlock(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ShieldIllustration(),
                      const SizedBox(height: 36),
                      Text(
                        'Streamline Your\nTPA Operations',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 28, fontWeight: FontWeight.w700,
                            color: Colors.white, height: 1.3, letterSpacing: -0.3),
                      ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 12),
                      Text(
                        'Manage claims, patients, and insurance\ncompanies in one unified ledger platform.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.65), height: 1.6),
                      ).animate(delay: 400.ms).fadeIn(duration: 600.ms),
                    ],
                  ),
                ),
                _FeatureList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color));

  Widget _circleOutline(double size, Color borderColor) => Container(
      width: size, height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1)));
}

// ════════════════════════════════════════════════════════════
//  RIGHT FORM PANEL  (desktop only)
// ════════════════════════════════════════════════════════════
class _RightFormPanel extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final bool isLoading;
  final VoidCallback onSignIn;

  const _RightFormPanel({
    required this.formKey,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.isLoading,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: AppColors.surface,
      child: Stack(fit: StackFit.expand, children: [
        Positioned(top: -100, right: -100, child: _GlowCircle(size: 400, opacity: 0.05)),
        Positioned(bottom: -80, left: -80,  child: _GlowCircle(size: 300, opacity: 0.04)),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: _LoginCard(
                formKey: formKey,
                emailCtrl: emailCtrl,
                passwordCtrl: passwordCtrl,
                obscurePassword: obscurePassword,
                onToggleObscure: onToggleObscure,
                isLoading: isLoading,
                onSignIn: onSignIn,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  LOGIN CARD  (shared across all screen sizes)
// ════════════════════════════════════════════════════════════
class _LoginCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final bool isLoading;
  final VoidCallback onSignIn;

  const _LoginCard({
    required this.formKey,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.isLoading,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final cardPadding = isMobile ? 24.0 : 44.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 24, offset: const Offset(0, 4)),
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4,  offset: const Offset(0, 1)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green top bar
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.primary, Colors.transparent]),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _CardHeader(compact: isMobile),
                    const SizedBox(height: 24),

                    // Email
                    const _FormLabel(text: 'Email Address'),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'admin@mediassure.com',
                        prefixIcon: Icon(Icons.email_outlined, size: 18),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // Password
                    const _FormLabel(text: 'Password'),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18, color: AppColors.textLight,
                          ),
                          onPressed: onToggleObscure,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password is required';
                        if (v.length < 6) return 'Minimum 6 characters';
                        return null;
                      },
                      onFieldSubmitted: (_) => onSignIn(),
                    ),
                    const SizedBox(height: 10),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign In Button
                    _SignInButton(isLoading: isLoading, onSignIn: onSignIn),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
  }
}

// ── Card Header ───────────────────────────────────────────────
class _CardHeader extends StatelessWidget {
  final bool compact;
  const _CardHeader({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back 👋',
          style: GoogleFonts.inter(
            fontSize: compact ? 22 : 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to your MediAssure account',
          style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textMid),
        ),
      ],
    );
  }
}

// ── Form Label ────────────────────────────────────────────────
class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
            fontSize: 13, fontWeight: FontWeight.w600,
            color: AppColors.textDark, letterSpacing: 0.1));
  }
}

// ── Sign In Button ────────────────────────────────────────────
class _SignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSignIn;
  const _SignInButton({required this.isLoading, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          width: 20, height: 20,
          child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  REUSABLE HELPERS
// ════════════════════════════════════════════════════════════
class _GlowCircle extends StatelessWidget {
  final double size;
  final double opacity;
  const _GlowCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          AppColors.primary.withOpacity(opacity),
          Colors.transparent,
        ]),
      ),
    );
  }
}

// ── Logo Block (desktop left panel) ──────────────────────────
class _LogoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: const Center(child: _MiniShieldIcon()),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MediAssure',
              style: GoogleFonts.inter(
                  fontSize: 20, fontWeight: FontWeight.w800,
                  color: Colors.white, letterSpacing: -0.3)),
          Text('Medical Insurance Ledger',
              style: GoogleFonts.inter(
                  fontSize: 11, fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.65))),
        ],
      ),
    ]).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0);
  }
}

// ── Shield Illustration (desktop left panel) ──────────────────
class _ShieldIllustration extends StatefulWidget {
  @override
  State<_ShieldIllustration> createState() => _ShieldIllustrationState();
}

class _ShieldIllustrationState extends State<_ShieldIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))
      ..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: 0, end: -12)
        .animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _floatCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (context, child) =>
          Transform.translate(offset: Offset(0, _floatAnim.value), child: child),
      child: SizedBox(
        width: 200, height: 200,
        child: Stack(alignment: Alignment.center, children: [
          Container(width: 200, height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06))),
          Container(width: 155, height: 155,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06))),
          SizedBox(width: 110, height: 110,
              child: CustomPaint(painter: _LargeShieldPainter())),
        ]),
      ).animate(delay: 200.ms).fadeIn(duration: 800.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
    );
  }
}

// ── Feature List (desktop left panel) ────────────────────────
class _FeatureList extends StatelessWidget {
  final _features = const [
    (icon: Icons.business_rounded,       label: 'Multi-TPA & Insurer Management'),
    (icon: Icons.biotech_rounded,        label: 'Daily Sample Collection Tracking'),
    (icon: Icons.receipt_long_rounded,   label: 'Invoice-based Payment Ledger'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _features.asMap().entries.map((entry) {
        final i = entry.key; final f = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _FeatureItem(icon: f.icon, label: f.label)
              .animate(delay: Duration(milliseconds: 500 + (i * 100)))
              .fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
        );
      }).toList(),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Colors.white, size: 15),
        ),
        const SizedBox(width: 12),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.85))),
      ]),
    );
  }
}

// ── Painters ──────────────────────────────────────────────────
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.04)..strokeWidth = 1;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}

class _LargeShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width; final h = size.height;
    final outerPaint = Paint()..color = Colors.white.withOpacity(0.15)..style = PaintingStyle.fill;
    final outerBorder = Paint()..color = Colors.white.withOpacity(0.25)..style = PaintingStyle.stroke..strokeWidth = 1.5;
    final shieldPath = Path()
      ..moveTo(w * 0.5, 0)..lineTo(w * 0.05, h * 0.18)..lineTo(w * 0.05, h * 0.52)
      ..cubicTo(w * 0.05, h * 0.82, w * 0.25, h * 0.96, w * 0.5, h)
      ..cubicTo(w * 0.75, h * 0.96, w * 0.95, h * 0.82, w * 0.95, h * 0.52)
      ..lineTo(w * 0.95, h * 0.18)..close();
    canvas.drawPath(shieldPath, outerPaint);
    canvas.drawPath(shieldPath, outerBorder);
    final innerPath = Path()
      ..moveTo(w * 0.5, h * 0.08)..lineTo(w * 0.13, h * 0.24)..lineTo(w * 0.13, h * 0.53)
      ..cubicTo(w * 0.13, h * 0.78, w * 0.30, h * 0.92, w * 0.5, h * 0.96)
      ..cubicTo(w * 0.70, h * 0.92, w * 0.87, h * 0.78, w * 0.87, h * 0.53)
      ..lineTo(w * 0.87, h * 0.24)..close();
    canvas.drawPath(innerPath, Paint()..color = Colors.white.withOpacity(0.10)..style = PaintingStyle.fill);
    final crossPaint = Paint()..color = Colors.white.withOpacity(0.90)..style = PaintingStyle.fill;
    final r = Radius.circular(w * 0.06);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.43, h*0.30, w*0.14, h*0.42), r), crossPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.30, h*0.43, w*0.40, h*0.14), r), crossPaint);
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}

class _MiniShieldIcon extends StatelessWidget {
  const _MiniShieldIcon();
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: 22, height: 22, child: CustomPaint(painter: _MiniShieldPainter()));
}

class _MiniShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width; final h = size.height;
    final shieldPath = Path()
      ..moveTo(w*0.5, 0)..lineTo(w*0.05, h*0.2)..lineTo(w*0.05, h*0.52)
      ..cubicTo(w*0.05, h*0.80, w*0.25, h*0.95, w*0.5, h)
      ..cubicTo(w*0.75, h*0.95, w*0.95, h*0.80, w*0.95, h*0.52)
      ..lineTo(w*0.95, h*0.2)..close();
    canvas.drawPath(shieldPath, Paint()..color = Colors.white.withOpacity(0.9));
    final crossPaint = Paint()..color = AppColors.primary;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.43, h*0.28, w*0.14, h*0.44), const Radius.circular(2)), crossPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.28, h*0.43, w*0.44, h*0.14), const Radius.circular(2)), crossPaint);
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}