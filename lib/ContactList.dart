
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Contact.dart';

class ContactList extends ChangeNotifier {

  List<mainContact> contacts = [];



  Future<List> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts');

    if (contactsData != null) {
      contacts = contactsData.map((data) {
        final parts = data.split(',');
        return mainContact(parts[0], parts[1],parts[2],parts[3]);
      }).toList();
      notifyListeners();
    }
    return contacts;
  }
  void addContact(mainContact newContact) {
    contacts.add(newContact);
    saveContacts();
    notifyListeners();
  }
  void updateContact(int index, mainContact updatedContact) {
    contacts[index] = updatedContact;
    saveContacts();
    notifyListeners();
  }
  void deleteContact(int index) {
    contacts.removeAt(index);
    saveContacts();
    notifyListeners();
  }
  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = contacts.map((contact) {
      return '${contact.fullname},${contact.phoneNumber},${contact.email},${contact.date}';
    }).toList();
    prefs.setStringList('contacts', contactsData);
  }


}
