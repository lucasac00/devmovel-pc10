import 'package:floor/floor.dart';
import 'person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person ORDER BY name ASC')
  Stream<List<Person>> findAllPersonsAsStream();

  @insert
  Future<void> insertPerson(Person person);
}