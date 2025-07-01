import 'package:flutter/material.dart';
import '../database/person_dao.dart';
import '../database/person.dart';

class PersonViewModel extends ChangeNotifier {
  final PersonDao _personDao;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  late final Stream<List<Person>> personStream;

  PersonViewModel(this._personDao) {
    personStream = _personDao.findAllPersonsAsStream();
  }

  Future<void> addPerson() async {
    final name = nameController.text;
    final age = int.tryParse(ageController.text);

    if (name.isNotEmpty && age != null && age > 0) {
      final newPerson = Person(name: name, age: age);
      await _personDao.insertPerson(newPerson);

      nameController.clear();
      ageController.clear();
    } else {
      print("Erro: Nome inválido ou idade inválida.");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}