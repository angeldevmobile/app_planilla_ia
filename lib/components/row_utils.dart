import 'package:flutter/material.dart';

Widget buildHeader(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
          fontSize: 13),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

TableRow buildRow(Map<String, String> row, int index) {
  return TableRow(
    decoration:
        BoxDecoration(color: index.isOdd ? Colors.grey.shade50 : Colors.white),
    children: [
      buildCell(row["no"]!),
      buildCell(row["tipo"]!),
      buildCell(row["fecha"]!),
      buildCell(row["archivo"]!),
      buildStatusCell(row["estado"]!),
      buildActionCell(),
    ],
  );
}

Widget buildCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

Widget buildStatusCell(String estado) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: _estadoColor(estado),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: _estadoTextColor(estado).withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_estadoIcon(estado), size: 14, color: _estadoTextColor(estado)),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              estado,
              style: TextStyle(
                color: _estadoTextColor(estado),
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildActionCell() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: IconButton(
      icon: const Icon(Icons.save_alt_outlined, size: 20),
      color: Colors.blue.shade600,
      onPressed: () {},
    ),
  );
}

Color _estadoColor(String estado) {
  switch (estado) {
    case "Pendiente":
      return Colors.blue.shade50;
    case "Completado":
      return Colors.green.shade50;
    case "Rechazado":
      return Colors.red.shade50;
    default:
      return Colors.grey.shade200;
  }
}

Color _estadoTextColor(String estado) {
  switch (estado) {
    case "Pendiente":
      return Colors.blue.shade800;
    case "Completado":
      return Colors.green.shade800;
    case "Rechazado":
      return Colors.red.shade800;
    default:
      return Colors.grey.shade800;
  }
}

IconData _estadoIcon(String estado) {
  switch (estado) {
    case "Pendiente":
      return Icons.access_time;
    case "Completado":
      return Icons.check_circle;
    case "Rechazado":
      return Icons.cancel;
    default:
      return Icons.help_outline;
  }
}
