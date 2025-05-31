import 'package:flutter/material.dart';

class EmployeeTopAppBar extends StatelessWidget {
  final FocusNode searchFocusNode;
  final bool isSearchFocused;

  const EmployeeTopAppBar({
    super.key,
    required this.searchFocusNode,
    required this.isSearchFocused,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Empleados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(isSearchFocused ? 20.0 : 30.0),
                  border: Border.all(
                    color: isSearchFocused
                        ? Theme.of(context).primaryColor
                        : Colors.blue,
                    width: isSearchFocused ? 1.5 : 1.0,
                  ),
                  boxShadow: isSearchFocused
                      ? [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColor
                                .withAlpha((0.1 * 255).toInt()),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ]
                      : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  focusNode: searchFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Buscar empleados...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: const TextStyle(color: Colors.black87),
                  cursorColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/user_avatar.png'),
                radius: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Visualiza y gestiona los empleados de tu empresa.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
