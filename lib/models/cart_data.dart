final String tableCart = 'Cart';

class CartFields {
  static final List<String> values = [
    id, name, amount, picture
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String amount = 'amount';
  static final String picture = 'picture';


}

class Cart{
  final int? id;
  final String name;
  final String amount;
  final String picture;


  const Cart({
    this.id,
    required this.amount,
    required this.name,
    required this.picture,


  });
  Cart copy({
    int? id,
    String? name,
    String? amount,
    String? picture,


  }) =>
      Cart(
          id: id ?? this.id,
          name: name ?? this.name,
          amount: amount?? this.amount,
          picture: picture?? this.picture,


      );
  static Cart fromJson(Map<String, Object?> json) => Cart(
      id: json[CartFields.id] as int?,
      name: json[CartFields.name] as String,
      amount: json[CartFields.amount] as String,
      picture: json[CartFields.picture] as String,


  );

  Map<String, Object?> toJson() => {
    CartFields.id: id,
    CartFields.name: name,
    CartFields.amount: amount,
    CartFields.picture: picture


  };
}