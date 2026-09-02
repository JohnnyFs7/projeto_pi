  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import '../../core/app_colors.dart';

 class SplashScreen extends StatelessWidget{
   const SplashScreen({super.key});

   @override
   Widget build(BuildContext context) {
     return AnnotatedRegion<SystemUiOverlayStyle>(
       value: const SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness: Brightness.light,
         statusBarBrightness: Brightness.dark,
       ),
       child: Scaffold(
         backgroundColor: AppColors.primary,
         body: Container(
           width: double.infinity,
           height: double.infinity,
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment(-0.3, -1),
               end: Alignment(0.3, 1),
               colors:  [
                 AppColors.primary,
                 AppColors.primaryLight,
                 Colors.white,
               ],
               stops: [0.0, 0.4, 1.0],
             ),
           ),
           child: SafeArea(
               child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                       SizedBox.shrink(),
                       _MiddleContent(),
                       _BottomActions(),
                     ],
                   ),
               ),
           ),
         ),
       ),
     );
   }
 }

 class _MiddleContent extends StatelessWidget {
   const _MiddleContent();

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Container(
           width: 80,
           height: 80,
           alignment: Alignment.center,
           decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.15),
             borderRadius: BorderRadius.circular(24),
             boxShadow: [
               BoxShadow(
                 color: Colors.white.withOpacity(0.15),
                 blurRadius: 16,
                 offset: const Offset(0, 6),
               ),
             ],
           ),
           child: const Icon(Icons.bolt, color: Colors.white, size: 40),
         ),
         const SizedBox(height: 24),

         const Text(
           'ServAqui',
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 32,
             fontWeight: FontWeight.w800,
             color: Colors.white,
             height: 1.2,
           ),
         ),
         const SizedBox(height: 4),
         Text(
           'MARKETPLACE DE SERVIÇOS',
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 12,
             fontWeight: FontWeight.w500,
             color: Colors.white.withOpacity(0.7),
             letterSpacing: 2,
           ),
         ),
         const SizedBox(height: 24),

         const SizedBox(
           width: 260,
           child: Text(
             'Seus serviços favoritos, a um toque de distância',
             textAlign: TextAlign.center,
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.w500,
               color: AppColors.dark,
               height: 1.5,
             ),
           ),
         ),
       ],
     );
   }
 }

  class _BottomActions extends StatelessWidget {
   const _BottomActions();

   @override
   Widget build(BuildContext context) {
     return Column(
       children: [
         _SplashButton(
           label: 'Entrar',
           background: AppColors.primary,
           textColor: Colors.white,
           withShadow: true,
           onPressed: () =>
               Navigator.pushReplacementNamed(context, '/auth-register'),
         ),
         const SizedBox(height: 20),

         RichText(
             textAlign: TextAlign.center,
             text: TextSpan(
               style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
               children: [
                 const TextSpan(text: 'Ao continuar, você aceita os '),
                 TextSpan(
                   text: 'Termos de Uso',
                   style: TextStyle(
                     color: AppColors.primary,
                     fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  class _SplashButton extends StatefulWidget {
   final String label;
   final Color background;
   final Color textColor;
   final VoidCallback onPressed;
   final bool withShadow;

   const _SplashButton({
     required this.label,
     required this.background,
     required this.textColor,
     required this.onPressed,
     this.withShadow = false,
  });

   @override
   State<_SplashButton> createState() => _SplashButtonState();
  }

  class _SplashButtonState extends State<_SplashButton> {
   double _scale = 1.0;

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTapDown: (_) => setState(() => _scale = 0.95),
       onTapUp: (_) => setState(() => _scale = 1.0),
       onTapCancel: () => setState(() => _scale = 1.0),
       onTap: widget.onPressed,
       child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadiusGeometry.circular(24),
              boxShadow: widget.withShadow
                ?[
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
              ]
              : null,
       ),
       child: Text(
         widget.label,
         style: TextStyle(
           fontSize: 16,
           fontWeight: FontWeight.w700,
           color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}