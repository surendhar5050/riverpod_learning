import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:uuid/uuid.dart';

@immutable
class Person {
  final String? name;
  final int? age;
  String? uuid;

  Person({required this.age, required this.name, String? uuid})
    : uuid = uuid ?? Uuid().v4();

  Person updated([String? personName, int? newAge]) {
    return Person(age: newAge ?? age, name: personName ?? name, uuid: uuid);
  }

  String get displayName => '$name (age is $age)';

  @override
  int get hashCode => uuid.hashCode;

  @override
  bool operator ==(covariant Person other) {
    return uuid == other.uuid;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'person ( $name ,$age ,$uuid)';
  }
}

class PersonModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get peoples => UnmodifiableListView(_people);

  void add(Person newPerson) {
    _people.add(newPerson);

    notifyListeners();
  }

  void remove(Person newPerson) {
    _people.remove(newPerson);

    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _people.indexOf(updatedPerson);

    final oldPerson = _people[index];

    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _people[index] = oldPerson.updated(updatedPerson.name, updatedPerson.age);
    }

    notifyListeners();
  }
}

final TextEditingController nameController = TextEditingController();

final TextEditingController ageController = TextEditingController();

Future<Person?> updateOrCreateDialogBox(BuildContext context, Person? person) {
  String? name = person?.name;
  int? age = person?.age;

  nameController.text = name ?? "";

  ageController.text = age?.toString() ?? "";

  return showDialog<Person?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Create a Person"),

        content: Column(
          children: [
            TextField(
              controller: nameController,
              onChanged: (value) => name = value,
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              onChanged: (value) => int.parse(value),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (person != null) {
                  Navigator.of(context).pop(person.updated(name, age));
                } else {
                  Navigator.of(context).pop(Person(age: age, name: name));
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}

class Example5 extends ConsumerWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: AppBar());
  }
}
