import 'package:flutter/material.dart';
import 'contact_form_screen.dart';
import 'contact_model.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  void _addContact(Contact contact) {
    setState(() {
      contacts.add(contact);
    });
  }

  void _editContact(Contact contact, int index) {
    setState(() {
      contacts[index] = contact;
    });
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Você tem certeza que deseja deletar este contato?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Deletar'),
              onPressed: () {
                setState(() {
                  contacts.removeAt(index);
                });
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Cor do AppBar
      ),
      body: contacts.isEmpty
          ? Center(
              child: Text(
                'Nenhum contato encontrado!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.person, size: 40),
                    title: Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16),
                            SizedBox(width: 4),
                            Text(contact.phone),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16),
                            SizedBox(width: 4),
                            Text(contact.email),
                          ],
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactFormScreen(
                                  contact: contact,
                                  onSave: (updatedContact) => _editContact(updatedContact, index),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteContact(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactFormScreen(
                onSave: _addContact,
              ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent, // Cor do botão flutuante
      ),
    );
  }
}
