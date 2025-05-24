import 'package:flutter/material.dart';

import '../password/components/new_password.dart';
import 'components/otp_header.dart';
import 'components/otp_input_field.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isLoading = false;
  bool _showError = false;
  int _resendCountdown = 30;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      _focusNodes[0].requestFocus();
    });
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
        _startCountdown();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOTPChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_controllers.every((c) => c.text.isNotEmpty)) {
      _validateOTP();
    } else {
      setState(() => _showError = false);
    }
  }

  Future<void> _validateOTP() async {
    setState(() {
      _isLoading = true;
      _showError = false;
    });

    await Future.delayed(const Duration(seconds: 2));
    final isValid = DateTime.now().second % 3 != 0;

    if (!isValid) {
      _animationController.forward(from: 0);
      setState(() {
        _isLoading = false;
        _showError = true;
      });
    } else {
      print('OTP válido');
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: "Verificación exitosa",
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, anim1, anim2) {
          return const SizedBox
              .shrink(); // No se usa, se reemplaza por transitionBuilder
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale:
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 28),
                  SizedBox(width: 10),
                  Text(
                    "Verificación exitosa",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: const Text(
                "Tu código fue validado correctamente.",
                style: TextStyle(fontSize: 16),
              ),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewPasswordScreen(email: widget.email),
                      ),
                    );
                  },
                  child: const Text("Crear nueva contraseña"),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _resendCode() {
    if (_resendCountdown > 0) return;

    setState(() {
      _resendCountdown = 30;
      _showError = false;
      for (var c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();
    });

    _startCountdown();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Código reenviado con éxito'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final errorColor = theme.colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación OTP'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OTPHeader(
                showError: _showError,
                email: widget.email,
                primaryColor: primaryColor,
                errorColor: errorColor,
              ),
              const SizedBox(height: 32),
              ScaleTransition(
                scale: _animation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => OTPInputField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (val) => _onOTPChanged(index, val),
                      hasError: _showError,
                      isFocused: _focusNodes[index].hasFocus,
                      primaryColor: primaryColor,
                      errorColor: errorColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No recibiste el código? ',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: _resendCode,
                    child: Text(
                      _resendCountdown > 0
                          ? 'Reenviar ($_resendCountdown)'
                          : 'Reenviar',
                      style: TextStyle(
                        color:
                            _resendCountdown > 0 ? Colors.grey : primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isLoading ? 60 : 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _validateOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text(
                          'Verificar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Verificar con otro método',
                  style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
