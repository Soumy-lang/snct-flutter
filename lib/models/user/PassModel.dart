class PassModel {
  final String label;
  final String description;
  final String price;

  PassModel(this.label, this.description, this.price);

  Map<String, dynamic> toJson({String nom = 'SNCT', String email = 'SNCT@mail.com'}) {
    return {
      'label': label,
      'description': description,
      'price': price,
      'nom': nom,
      'email': email,
      'date': DateTime.now().toIso8601String(),
      'type': 'abonnement',
    };
  }
}
