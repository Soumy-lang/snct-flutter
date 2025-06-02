class TrajetModel {
  final String departureTime;
  final String arrivalTime;
  final String from;
  final String to;
  final String trainLabel;
  final String company;
  final String duration;
  final String price;
  final bool isAvailable;

  TrajetModel({
    required this.departureTime,
    required this.arrivalTime,
    required this.from,
    required this.to,
    required this.trainLabel,
    required this.company,
    required this.duration,
    required this.price,
    required this.isAvailable,
  });
  factory TrajetModel.fromJson(Map<String, dynamic> json) {
  return TrajetModel(
    departureTime: json['departureTime'] ?? '',
    arrivalTime: json['arrivalTime'] ?? '',
    from: json['from'] ?? '',
    to: json['to'] ?? '',
    trainLabel: json['trainLabel'] ?? '',
    company: json['company'] ?? '',
    duration: json['duration'] ?? '',
    price: json['price'] ?? 'non disponible',
    isAvailable: json['isAvailable'] ?? false,
  );
}

}


/*class PassModel {
  final String label;
  final String description;
  final String price;

  PassModel(this.label, this.description, this.price);
}*/

class Search{
  final String from;
  final String to;

  Search({required this.from, required this.to});

  Map<String, dynamic>toJson(){
    return{
    'depart': from,
    'destination': to,
    };
  }
}