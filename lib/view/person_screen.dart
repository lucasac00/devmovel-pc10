import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/person.dart';
import 'person_view.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PersonViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DevMovel PC10'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputSection(context, viewModel),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Pessoas Cadastradas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Seção da Lista
            Expanded(child: _buildPersonList(context, viewModel)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context, PersonViewModel viewModel) {
    return Column(
      children: [
        TextField(
          controller: viewModel.nameController,
          decoration: const InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: viewModel.ageController,
          decoration: const InputDecoration(
            labelText: 'Idade',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            viewModel.addPerson();
            FocusScope.of(context).unfocus();
          },
          //icon: const Icon(Icons.add),
          label: const Text('Adicionar'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonList(BuildContext context, PersonViewModel viewModel) {
    return StreamBuilder<List<Person>>(
      stream: viewModel.personStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ocorreu um erro: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma pessoa cadastrada.'));
        }

        final people = snapshot.data!;
        return ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(person.name),
                subtitle: Text('Idade: ${person.age}'),
              ),
            );
          },
        );
      },
    );
  }
}