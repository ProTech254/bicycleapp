final String tableUsers = 'users';

class UsersFields {
  static final List<String> values = [
    id, fullnames, phone_number, email_address, password, user_role
  ];
  static final String id = '_id';
  static final String fullnames = 'fullnames';
  static final String phone_number = 'phone_number';
  static final String email_address = 'email_address';
  static final String password = 'password';
  static final String user_role = 'user_role';

}

class Users{
  final int? id;
  final String full_names;
  final String phone_number;
  final String email_address;
  final String password;
  final String user_role;



  const Users({
    this.id,
    required this.full_names,
    required this.phone_number,
    required this.email_address,
    required this.password,
    required this.user_role,
  });
  Users copy({
    int? id,
    String? full_names,
    String? phone_number,
    String? email_address,
    String? password,
    String? user_role

  }) =>
      Users(
        id: id ?? this.id,
        full_names: full_names ?? this.full_names,
        email_address:  email_address ?? this.email_address,
        phone_number: phone_number?? this.phone_number,
        password: password?? this.password,
        user_role: user_role?? this.user_role,


      );
  static Users fromJson(Map<String, Object?> json) => Users(
    id: json[UsersFields.id] as int?,
    full_names: json[UsersFields.fullnames] as String,
    email_address: json[UsersFields.email_address] as String,
    phone_number: json[UsersFields.phone_number] as String,
    password: json[UsersFields.password] as String,
    user_role: json[UsersFields.user_role] as String,

  );

  Map<String, Object?> toJson() => {
    UsersFields.id: id,
    UsersFields.fullnames: full_names,
    UsersFields.email_address: email_address,
    UsersFields.phone_number: phone_number,
    UsersFields.password: password,
    UsersFields.user_role: user_role,
  };
}