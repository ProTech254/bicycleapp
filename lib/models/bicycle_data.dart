final String tableBicycles = 'Bicycles';

class BicyclesFields {
  static final List<String> values = [
    id, description, name, amount, picture, category
  ];
  static final String id = '_id';
  static final String description = 'description';
  static final String name = 'name';
  static final String amount = 'amount';
  static final String picture = 'picture';
  static final String category = 'category';

}

class Bicycles{
  final int? id;
  final String description;
  final String name;
  final String amount;
  final String picture;
  final String category;

  const Bicycles({
    this.id,
    required this.description,
    required this.amount,
    required this.name,
    required this.picture,
    required this.category

  });
  Bicycles copy({
    int? id,
    String? name,
    String? description,
    String? amount,
    String? picture,
    String? category,


  }) =>
      Bicycles(
        id: id ?? this.id,
        name: name ?? this.name,
        description:  description ?? this.description,
        amount: amount?? this.amount,
        picture: picture?? this.picture,
        category: picture?? this.category

      );
  static Bicycles fromJson(Map<String, Object?> json) => Bicycles(
    id: json[BicyclesFields.id] as int?,
    name: json[BicyclesFields.name] as String,
    description: json[BicyclesFields.description] as String,
    amount: json[BicyclesFields.amount] as String,
    picture: json[BicyclesFields.picture] as String,
    category: json[BicyclesFields.category] as String

  );

  Map<String, Object?> toJson() => {
    BicyclesFields.id: id,
    BicyclesFields.name: name,
    BicyclesFields.description: description,
    BicyclesFields.amount: amount,
    BicyclesFields.picture: picture,
    BicyclesFields.category: category,

  };
}