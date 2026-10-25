
import '../domain/installation_assignment.dart';

class CoordinatorRepository {
  Future<List<InstallationAssignment>> loadAssignments() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return const [
      InstallationAssignment(
        id: 'INT-001',
        clientName: 'Client Démonstration 1',
        clientNumber: 'client001',
        zone: 'Cocody',
        address: 'Adresse à confirmer, Cocody',
        technicianName: 'Technicien 1',
        status: 'En attente',
      ),
      InstallationAssignment(
        id: 'INT-002',
        clientName: 'Client Démonstration 2',
        clientNumber: 'client002',
        zone: 'Yopougon',
        address: 'Adresse à confirmer, Yopougon',
        technicianName: 'Non affecté',
        status: 'À affecter',
      ),
      InstallationAssignment(
        id: 'INT-003',
        clientName: 'Client Démonstration 3',
        clientNumber: 'client003',
        zone: 'Abobo',
        address: 'Adresse à confirmer, Abobo',
        technicianName: 'Technicien 2',
        status: 'En cours',
      ),
    ];
  }
}
