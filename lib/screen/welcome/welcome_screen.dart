import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:carousel_slider/carousel_slider.dart';

import '../../constants.dart';
import 'components/footer_welcome.dart';
import 'components/animated_background.dart';
import 'components/login_button.dart';
import '../neon_text/class_neon.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  double _hoverValue = 0.0;
  bool _buttonHovered = false;
  int _currentCarouselIndex = 0;

  final List<String> carouselItems = [
    'Inteligencia artificial en nuestra plataforma',
    'Pagos automáticos según rol y asistencia',
    'Reportes personalizados para personal médico',
    'Cumplimiento total con normativas laborales'
  ];

  @override
  void initState() {
    super.initState();
    timeDilation = 1.5; // Solo para desarrollo

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1000;
    final isDesktop = size.width >= 1000;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Fondo animado mejorado
          AnimatedBackground(isDesktop: isDesktop),
          // Contenido principal
          Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 20.0 : 40.0),
                    child: MouseRegion(
                      onHover: isDesktop
                          ? (event) {
                              setState(() {
                                final centerX = size.width / 2;
                                _hoverValue =
                                    ((event.position.dx - centerX) / centerX) *
                                        0.05;
                              });
                            }
                          : null,
                      child: Transform(
                        transform: isDesktop
                            ? (Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_hoverValue))
                            : Matrix4.identity(),
                        alignment: FractionalOffset.center,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 700,
                          ),
                          padding: EdgeInsets.all(isMobile ? 20.0 : 40.0),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withAlpha((0.1 * 255).toInt()),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.3 * 255).toInt()),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                            border: Border.all(
                                color: kSecondaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icono mejorado
                              ScaleTransition(
                                scale: _animation,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        kSecondaryColor.withOpacity(0.3),
                                        kSecondaryColor.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kSecondaryColor.withOpacity(0.6),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(isMobile ? 20.0 : 30.0),
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      size: isMobile ? 70 : 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: isMobile ? 25 : 35),

                              // Título con más énfasis
                              NeonText(
                                text: "SMART PAYROLL",
                                fontSize: isMobile ? 36 : 48,
                                color: kSecondaryColor,
                                blurRadius: isMobile ? 15 : 20,
                              ),
                              SizedBox(height: isMobile ? 15 : 20),
                              Text(
                                kSmartPayrollText,
                                textAlign: TextAlign.center,
                                style: kSubtitleTextStyle.copyWith(
                                  fontSize: isMobile ? 18 : 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: isMobile ? 30 : 50),
                              // Slider/Carousel de características
                              if (!isMobile) ...[
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 60,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentCarouselIndex = index;
                                      });
                                    },
                                  ),
                                  items: carouselItems.map((text) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: kSecondaryColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: kSecondaryColor
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              text,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: carouselItems.map((text) {
                                    int index = carouselItems.indexOf(text);
                                    return Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentCarouselIndex == index
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.4),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: isMobile ? 20 : 30),
                              ],
                              // Botón mejorado
                              LoginButton(
                                isMobile: isMobile,
                                isHovered: _buttonHovered,
                                onHover: (hovered) =>
                                    setState(() => _buttonHovered = hovered),
                              ),
                              // Solo para desktop/tablet
                              if (!isMobile) ...[
                                const SizedBox(height: 25),
                              ],
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Footer mejorado
          if (!isMobile) Footer(isTablet: isTablet),
        ],
      ),
    );
  }
}
