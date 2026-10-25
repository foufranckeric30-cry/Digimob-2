
import '../domain/technician_intervention.dart';

class TechnicianRepository {
  Future<List<TechnicianIntervention>> loadInterventions() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return const [
      TechnicianIntervention(
        id: 'INT-001',
        clientName: 'Client de démonstration A',
        clientNumber: 'CLI-001',
        address: 'Cocody, Abidjan',
        phone: 'Non renseigné',
        status: 'À effectuer',
      ),
      TechnicianIntervention(
        id: 'INT-002',
        clientName: 'Client de démonstration B',
        clientNumber: 'CLI-002',
        address: 'Yopougon, Abidjan',
        phone: 'Non renseigné',
        status: 'En cours',
      ),
      TechnicianIntervention(
        id: 'INT-003',
        clientName: 'Client de démonstration C',
        clientNumber: 'CLI-003',
        address: 'Abobo, Abidjan',
        phone: 'Non renseigné',
        status: 'Terminée',
      ),
    ];
  }
}
