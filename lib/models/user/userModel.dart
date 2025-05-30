class Search{
  final String depart;
  final String destination;

  Search({required this.depart, required this.destination});

  Map<String, dynamic>toJson()=>{
    'depart':depart,
    'destination':destination,
  };
}