import '../../models/admin/reservation_model.dart';

class ReservationService {
  List<Reservation> _reservations = [];

  List<Reservation> getAllReservations() => _reservations;

  void addReservation(Reservation reservation) {
    _reservations.add(reservation);
  }

  List<Reservation> getUserReservations(String userId) {
    return _reservations.where((r) => r.userId == userId).toList();
  }
}
