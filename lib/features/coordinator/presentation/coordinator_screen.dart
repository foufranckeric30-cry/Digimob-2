
import 'package:flutter/material.dart';

import '../data/coordinator_repository.dart';
import '../domain/installation_assignment.dart';

class CoordinatorScreen extends StatefulWidget {
  const CoordinatorScreen({super.key});

  @override
  State<CoordinatorScreen> createState() => _CoordinatorScreenState();
}

class _CoordinatorScreenState extends State<CoordinatorScreen> {
  final CoordinatorRepository _repository = CoordinatorRepository();

  final List<String> _technicians = const [
    'Technicien 1',
    'Technicien 2',
    'Technicien 3',
  ];

  List<InstallationAssignment> _assignments = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    try {
      final result = await _repository.loadAssignments();

      if (!mounted) return;

      setState(() {
        _assignments = result;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _loading = false;
      });
    }
  }

  Future<void> _assignTechnician(
    InstallationAssignment assignment,
  ) async {
    String? selectedTechnician =
        _technicians.contains(assignment.technicianName)
            ? assignment.technicianName
            : null;

    final technician = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Affecter un technicien'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Client : ${assignment.clientName}'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    //value: selectedTechnician,
                    initialValue: selectedTechnician,
                    decoration: const InputDecoration(
                      labelText: 'Choisir un technicien',
                      border: OutlineInputBorder(),
                    ),
                    items: _technicians.map((name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        selectedTechnician = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Annuler'),
                ),
                FilledButton(
                  onPressed: selectedTechnician == null
                      ? null
                      : () => Navigator.pop(
                            dialogContext,
                            selectedTechnician,
                          ),
                  child: const Text('Confirmer'),
                ),
              ],
            );
          },
        );
      },
    );

    if (technician == null || !mounted) return;

    setState(() {
      _assignments = _assignments.map((item) {
        if (item.id != assignment.id) return item;

        return InstallationAssignment(
          id: item.id,
          clientName: item.clientName,
          clientNumber: item.clientNumber,
          zone: item.zone,
          address: item.address,
          technicianName: technician,
          status: 'Affecté',
        );
      }).toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$technician affecté au dossier ${assignment.id}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final zones = _assignments.map((item) => item.zone).toSet();

    final assignedCount = _assignments
        .where((item) => _technicians.contains(item.technicianName))
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Coordinatrice'),
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            onPressed: _loading ? null : _loadAssignments,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Erreur de chargement : $_error'),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: _loadAssignments,
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadAssignments,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        'Vue d’ensemble',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              title: 'Dossiers',
                              value: '${_assignments.length}',
                              icon: Icons.folder_open,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SummaryCard(
                              title: 'Zones',
                              value: '${zones.length}',
                              icon: Icons.location_on_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SummaryCard(
                              title: 'Affectés',
                              value: '$assignedCount',
                              icon: Icons.assignment_ind_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Dossiers d’installation',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      if (_assignments.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('Aucun dossier disponible.'),
                          ),
                        ),
                      ..._assignments.map((item) {
                        final isAssigned =
                            _technicians.contains(item.technicianName);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.home_work_outlined),
                                  ),
                                  title: Text(item.clientName),
                                  subtitle: Text(
                                    'N° client : ${item.clientNumber}\n'
                                    'Zone : ${item.zone}\n'
                                    'Adresse : ${item.address}',
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.engineering_outlined,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Technicien : ${item.technicianName}',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Statut : ${item.status}',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton.icon(
                                    onPressed: () => _assignTechnician(item),
                                    icon: const Icon(Icons.person_add_alt_1),
                                    label: Text(
                                      isAssigned
                                          ? 'Modifier l’affectation'
                                          : 'Affecter un technicien',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Column(
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
