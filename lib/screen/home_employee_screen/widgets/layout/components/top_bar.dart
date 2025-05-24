import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final bool isSidebarOpen;
  final VoidCallback onToggle;

  const TopBar({
    super.key,
    required this.isSidebarOpen,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 4,
                  offset: Offset(2, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                icon: Icon(isSidebarOpen
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios),
                onPressed: onToggle,
                splashRadius: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const _AnimatedSearchField(),
          const Spacer(),
          Expanded(child: Container()),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.notifications_none),
              SizedBox(width: 16),
              Icon(Icons.message_outlined),
              SizedBox(width: 16),
              Icon(Icons.settings),
              SizedBox(width: 16),
              CircleAvatar(
                backgroundImage: AssetImage('images/user_avatar.png'),
              ),
            ],
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}

class _AnimatedSearchField extends StatefulWidget {
  const _AnimatedSearchField();

  @override
  State<_AnimatedSearchField> createState() => _AnimatedSearchFieldState();
}

class _AnimatedSearchFieldState extends State<_AnimatedSearchField> {
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
    return Flexible(
      flex: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        constraints: BoxConstraints(
          minWidth: 200,
          maxWidth: _isFocused ? 450 : 350,
        ),
        child: TextField(
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Buscar...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          ),
        ),
      ),
    );
  }
}
