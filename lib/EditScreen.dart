import 'package:contact_app_final/Contact.dart';
import 'package:contact_app_final/ContactList.dart';
import 'package:contact_app_final/ThemeProvider.dart';
import 'package:contact_app_final/android_contact.dart';
import 'package:contact_app_final/ios_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget{
  final int i;
  final Color c;
  EditScreen({required this.i,required this.c});

  @override
  State<StatefulWidget> createState() {

  return EditScreenState(i:i,c: c);
  }

}
class EditScreenState extends State<EditScreen>
{
  final int i;
  final Color c;
  String dateinput='';
  String timeinput = "";
  String name = "";
  String Phonenumber = "";
  String email = "";

  EditScreenState({required this.i,required this.c});

  final _formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {

    final contactProvider = Provider.of<ContactList>(context, listen: false);
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);

    name = contactProvider.contacts[i].fullname;
    Phonenumber = contactProvider.contacts[i].phoneNumber;
    email = contactProvider.contacts[i].email;
    dateinput=contactProvider.contacts[i].date;


    TextEditingController _datecontroller = TextEditingController(text: dateinput);

    return Consumer(
      builder: (context,ContactList,child) {
        return Scaffold(
          backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            toolbarOpacity: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
            title: Text("Edit Contact", style: TextStyle(fontWeight: FontWeight.w500, color:themeProvider.currentTheme.focusColor),
            ),
            actions: [
              Consumer(builder: (context, forvalues, child) {
                return Switch(
                  value: forvaluesprovider.isAndroid,
                  activeTrackColor:Colors.green,
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.black38,
                  onChanged: (value) {
                    forvaluesprovider.navigate(value);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ios_contact(),));
                  },
                );
              }),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(

                          cursorHeight: 20,
                          initialValue: name,
                          cursorColor: c,
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_2_outlined, size: 20,color: themeProvider.currentTheme.focusColor),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.currentTheme.focusColor)),
                            labelText: "Full name",
                            focusColor: c,
                            labelStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            hintStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.grey,width: 2,)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                              return 'Enter correct name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        TextFormField(

                          keyboardType: TextInputType.number,
                          cursorHeight: 20,
                          initialValue: Phonenumber,
                          cursorColor: c,

                          onChanged: (value) {
                            Phonenumber = value;
                          },
                          decoration: InputDecoration(

                            prefixIcon: Icon(Icons.phone, size: 20,color: themeProvider.currentTheme.focusColor),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.currentTheme.focusColor)),
                            labelText: "Phone Number",
                            focusColor: c,
                            labelStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            hintStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.grey,width: 2,)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || (value.length <= 9) || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Enter correct number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        TextFormField(

                          keyboardType: TextInputType.emailAddress,
                          cursorHeight: 20,
                          cursorColor: c,
                          initialValue: email,

                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(

                            prefixIcon: Icon(Icons.email, size: 20,color: themeProvider.currentTheme.focusColor),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.currentTheme.focusColor)),
                            labelText: "Email",
                            focusColor: c,
                            labelStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            hintStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.grey,width: 2,)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                              return 'Enter correct email';
                            } else {
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 30,),
                        SizedBox(height: 30,),
                        TextField(

                          controller: _datecontroller,

                          cursorHeight: 20,

                          cursorColor: c,

                          onChanged: (value) {
                            dateinput = value;
                          },
                          decoration: InputDecoration(

                            prefixIcon: Icon(Icons.date_range, size: 20,color: themeProvider.currentTheme.focusColor),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.currentTheme.focusColor)),
                            labelText: "Dtae Input",
                            focusColor: c,
                            labelStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            hintStyle: TextStyle(color: themeProvider.currentTheme.focusColor),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.grey,width: 2,)),
                          ),

                          onTap: () async {
                            DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(dateinput),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if (pickDate != null) {
                              print(pickDate);
                              String formatteDate = DateFormat('dd-MM-yyyy').format(pickDate);
                              _datecontroller.text=formatteDate;
                              print(formatteDate);
                              forvaluesprovider.date(formatteDate);} else {
                              print("Date is not selected");
                            }
                          },

                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: Consumer(
                              builder: (context,ContactList,child) {

                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(c),
                                  ),
                                  onPressed: () {
                                    contactProvider.updateContact(i,mainContact(name, Phonenumber, email, _datecontroller.text));
                                    contactProvider.saveContacts();
                                    Navigator.pop(context);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Upadte',style: TextStyle(color: Colors.white,fontSize: 15),),
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: Consumer(
                              builder: (context,ContactList,child) {

                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(c),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Delete Contact',style: TextStyle(color: themeProvider.currentTheme.focusColor),),
                                          content: Text('Are you sure you want to delete this contact?',style: TextStyle(color: themeProvider.currentTheme.focusColor),),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel',style: TextStyle(color: themeProvider.currentTheme.focusColor),),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                contactProvider.deleteContact(i);
                                                contactProvider.saveContacts();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete',style: TextStyle(color: themeProvider.currentTheme.focusColor),),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                  },
                                  child:  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Deiete',style: TextStyle(color: Colors.white,fontSize: 15),),
                                  ),
                                );
                              }
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}