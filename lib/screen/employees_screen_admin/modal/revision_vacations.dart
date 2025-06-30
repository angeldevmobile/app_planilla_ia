import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../api/vacacion_service.dart';
import '../../../models/vacacion_model.dart';

class VacationRequestsScreen extends StatefulWidget {
  const VacationRequestsScreen({super.key});

  @override
  State<VacationRequestsScreen> createState() => _VacationRequestsScreenState();
}

class _VacationRequestsScreenState extends State<VacationRequestsScreen> {
  final VacacionService _service = VacacionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de Vacaciones'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<VacacionModel>>(
        future: _service.obtenerTodasLasSolicitudes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar solicitudes'));
          }
          final requests = snapshot.data ?? [];
          if (requests.isEmpty) {
            return const Center(child: Text('No hay solicitudes'));
          }
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                ],
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnimatedVacationRequestCard(
                    request: requests[index],
                    index: index,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AnimatedVacationRequestCard extends StatefulWidget {
  final VacacionModel request;
  final int index;

  const AnimatedVacationRequestCard({
    super.key,
    required this.request,
    required this.index,
  });

  @override
  State<AnimatedVacationRequestCard> createState() =>
      _AnimatedVacationRequestCardState();
}

class _AnimatedVacationRequestCardState
    extends State<AnimatedVacationRequestCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    // Parse dates from String to DateTime
    final fechaInicio = DateTime.parse(widget.request.fechaInicio);
    final fechaFin = DateTime.parse(widget.request.fechaFin);
    final daysDifference = widget.request.diasCalculados;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.blue.shade50,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildUserInfo(),
                  const SizedBox(height: 16),
                  _buildVacationDates(fechaInicio, fechaFin, daysDifference),
                  const SizedBox(height: 16),
                  _buildDocumentsSection(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Solicitud de Vacaciones',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E384D),
      ),
    );
  }

  Widget _buildUserInfo() {
    // Si tienes info de usuario aparte, aquí deberías obtenerla por idUsuario
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text('ID Usuario: ${widget.request.idUsuario}'),
      subtitle: Text('Fecha de solicitud: ${widget.request.fechaSolicitud}'),
    );
  }

  Widget _buildVacationDates(DateTime inicio, DateTime fin, int days) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade100.withOpacity(0.3),
            Colors.blue.shade50.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateItem(
                'Inicio',
                dateFormat.format(inicio),
                Icons.calendar_today,
                Colors.blue,
              ),
              _buildDateItem(
                'Fin',
                dateFormat.format(fin),
                Icons.calendar_today,
                Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade100.withOpacity(0.4),
                  Colors.blue.shade200.withOpacity(0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$days día${days > 1 ? 's' : ''} de vacaciones',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateItem(String title, String date, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    if (widget.request.documentoRespaldo == null ||
        widget.request.documentoRespaldo!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No se adjuntaron documentos',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    } else {
      return ListTile(
        leading: Icon(_getDocumentIcon(widget.request.documentoRespaldo!)),
        title: Text('Documento adjunto'),
        subtitle: Text(widget.request.documentoRespaldo!),
        trailing: IconButton(
          icon: Icon(Icons.download, color: Colors.blue.shade800),
          onPressed: () {
            // Lógica para descargar documento
          },
        ),
      );
    }
  }

  IconData _getDocumentIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'png':
      case 'jpeg':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Lógica para rechazar
              _showConfirmationDialog('rejected');
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: Colors.red.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Rechazar',
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Lógica para aprobar
              _showConfirmationDialog('approved');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Aprobar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(String action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            action == 'approved' ? 'Aprobar solicitud' : 'Rechazar solicitud',
          ),
          content: Text(
            action == 'approved'
                ? '¿Estás seguro de que deseas aprobar esta solicitud de vacaciones?'
                : '¿Estás seguro de que deseas rechazar esta solicitud de vacaciones?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final aprobado =
                    action == 'approved' ? 'Aprobado' : 'Rechazado';
                final success = await VacacionService().revisarSolicitud(
                  widget.request.idVacacion!,
                  aprobado,
                  observaciones: null,
                );
                _showResultSnackbar(action, success);
                if (success) {
                  // Refresca la lista de solicitudes en el padre
                  if (mounted) {
                    // Busca el widget padre y llama a setState
                    final parentState = context.findAncestorStateOfType<
                        _VacationRequestsScreenState>();
                    parentState?.setState(() {});
                  }
                }
              },
              child: Text(
                action == 'approved' ? 'Aprobar' : 'Rechazar',
                style: TextStyle(
                  color: action == 'approved' ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResultSnackbar(String action, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (action == 'approved'
                  ? 'Solicitud aprobada con éxito'
                  : 'Solicitud rechazada')
              : 'Error al actualizar la solicitud',
        ),
        backgroundColor: success
            ? (action == 'approved' ? Colors.green : Colors.red)
            : Colors.orange,
      ),
    );
  }
}
