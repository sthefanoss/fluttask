import 'credentials.dart';
import 'address.dart';

class User {
  final String name;
  final String cpf;
  final Address address;
  final Credentials credentials;
  final DateTime dateOfBirth;

  const User({
    this.name,
    this.cpf,
    this.address,
    this.credentials,
    this.dateOfBirth,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      credentials: Credentials(
        email: map['email'],
        password: map['password'],
      ),
      name: map['name'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      cpf: map['cpf'],
      address: Address(
        location: map['location'],
        cep: map['cep'],
        number: map['number'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': credentials.email,
      'password': credentials.password,
      'name': name,
      'cpf': cpf ?? '',
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'number': address.number ?? '',
      'cep': address.cep ?? '',
      'location': address.location ?? '',
    };
  }

//  "CREATE TABLE IF NOT EXISTS users"
//  "(email TEXT PRIMARY KEY, name TEXT, dateOfBirth DATE,"
//  "cpf TEXT, password TEXT, cep TEXT, location TEXT, number TEXT)",
}
