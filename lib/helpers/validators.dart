bool cpfValidator(String cpf) {
  String cpfNumbers = cpf.replaceAll('.', '').replaceFirst('-', '');
  if (cpfNumbers.length != 11) return false;

  int firstSum = 0;
  for (int i = 10; i >= 2; i--) firstSum += i * int.parse(cpfNumbers[10 - i]);
  int fistVerificationDigit = (firstSum * 10) % 11;

  int secondSum = 0;
  for (int i = 11; i >= 2; i--) secondSum += i * int.parse(cpfNumbers[11 - i]);
  int secondVerificationDigit = (secondSum * 10) % 11;

  return (fistVerificationDigit == int.parse(cpfNumbers[9])) &&
      (secondVerificationDigit == int.parse(cpfNumbers[10]));
}

bool emailValidator(String email) {
  //encontrado em https://regexr.com/3e48o
  RegExp exp = RegExp(
      r'''^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''');
  return exp.hasMatch(email);
}
