class Reservation {
  final String id;
  final String userId;
  final String trainId;
  final String departure;
  final String arrival;
  final double price;
  final DateTime reservationDate;
  final DateTime purchaseDate;

  Reservation({
    required this.id,
    required this.userId,
    required this.trainId,
    required this.departure,
    required this.arrival,
    required this.price,
    required this.reservationDate,
    required this.purchaseDate,
  });
}