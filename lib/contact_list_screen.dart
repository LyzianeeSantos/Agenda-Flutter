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
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
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
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text('${contact.phone} - ${contact.email}'),
                  trailing: Wrap(
                    spacing: 12, // Space between buttons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactFormScreen(
                                contact: contact,
                                onSave: (updatedContact) =>
                                    _editContact(updatedContact, index),
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
      ),
    );
  }
}