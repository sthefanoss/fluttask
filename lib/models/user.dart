import 'credentials.dart';
import 'address.dart';

class User {
  final int id;
  final String name;
  final int cpf;
  final Address address;
  final Credentials credentials;
  final DateTime dateOfBirth;

  const User({
    this.id,
    this.name,
    this.cpf,
    this.address,
    this.credentials,
    this.dateOfBirth,
  });
}
