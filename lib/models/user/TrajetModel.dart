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
}


/*class PassModel {
  final String label;
  final String description;
  final String price;

  PassModel(this.label, this.description, this.price);
}*/

class Search{
  final String depart;
  final String destination;

  Search({required this.depart, required this.destination});

  Map<String, dynamic>toJson(){
    return{
    'depart': depart,
    'destination': destination,
    };
  }
}