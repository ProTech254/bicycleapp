final String tableOrders = 'Orders';

class OrdersFields {
  static final List<String> values = [
    id, name, amount, picture
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String amount = 'amount';
  static final String picture = 'picture';

}

class Orders{
  final int? id;
  final String name;
  final String amount;
  final String picture;

  const Orders({
    this.id,
    required this.amount,
    required this.name,
    required this.picture

  });
  Orders copy({
    int? id,
    String? name,
    String? amount,
    String? picture


  }) =>
      Orders(
          id: id ?? this.id,
          name: name ?? this.name,
          amount: amount?? this.amount,
          picture: picture?? this.picture

      );
  static Orders fromJson(Map<String, Object?> json) => Orders(
      id: json[OrdersFields.id] as int?,
      name: json[OrdersFields.name] as String,
      amount: json[OrdersFields.amount] as String,
      picture: json[OrdersFields.picture] as String

  );

  Map<String, Object?> toJson() => {
    OrdersFields.id: id,
    OrdersFields.name: name,
    OrdersFields.amount: amount,
    OrdersFields.picture: picture

  };
}