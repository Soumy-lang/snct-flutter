class Billet {
  final String id;
  final String ligne;
  final String depart;
  final String destination;
  final DateTime date;

  Billet({
    required this.id,
    required this.ligne,
    required this.depart,
    required this.destination,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'ligne': ligne,
    'depart': depart,
    'destination': destination,
    'date': date.toIso8601String(),
  };
}
