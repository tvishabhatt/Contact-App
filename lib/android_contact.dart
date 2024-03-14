import 'dart:math';
import 'package:contact_app_final/Contact.dart';
import 'package:contact_app_final/EditScreen.dart';
import 'package:contact_app_final/Golbal.dart';
import 'package:contact_app_final/ThemeProvider.dart';
import 'package:contact_app_final/ios_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'ContactList.dart';


class android_contact extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return android_contactState();
  }
}





class android_contactState extends State<android_contact> with SingleTickerProviderStateMixin,Golbal {

  late TabController tabController;
  Color color=Colors.purple;


  @override
  void initState() {


    dateinput.text="";

    Color color=Color.fromRGBO(random.nextInt(256), random.nextInt(256),random.nextInt(256),1);
    c=color;

    super.initState();
    Provider.of<forvalues>(context, listen: false).loadProfileInfoFromPrefs();
    tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);



    // TODO: implement build

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
            title: Text("Platform Converter", style: TextStyle(fontWeight: FontWeight.w500, color:themeProvider.currentTheme.focusColor),
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
          body:Column(
            children: [
              Container(
                child: TabBar(
                    controller: tabController,
                    indicatorColor:color,
                    labelColor: color,
                    indicatorPadding: EdgeInsets.only(left: 10, right: 10),
                    unselectedLabelColor: themeProvider.currentTheme.focusColor,
                    tabs: [
                      Tab(icon: Icon(Icons.person_add_alt,),),
                      Tab(text: "CHATS",),
                      Tab(text: "CALLS",),
                      Tab(text: "SETTINGS",),
                    ]),
              ),

              Expanded(
                child: SizedBox(
                  child: TabBarView(controller: tabController,
                      children: [
                       Tab1(),
                        Tab2(),
                        Tab3(),
                        Tab4(),
                      ]),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget Tab1(){
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);
    final contactprovider=Provider.of<ContactList>(context);
    return  SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor:  themeProvider.isLight?Colors.black:Colors.white,
                radius: 40,
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ),
            textfilled("Full Name", Icons.person_2_outlined, Fullname, TextInputType.name),
            textfilled("Phone Number", Icons.phone, Phonenumber, TextInputType.number),
            textfilled("Email", Icons.email, email, TextInputType.emailAddress),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.date_range,color: themeProvider.currentTheme.focusColor,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Consumer(

                      builder: (context, forvalues, child) {
                        return SizedBox(
                          width: 200,
                          child: TextField(
                            style: TextStyle(color: themeProvider.currentTheme.focusColor,),
                            controller: dateinput,
                            decoration: InputDecoration(labelText: "Pick Birth Date",labelStyle: TextStyle(color: themeProvider.currentTheme.focusColor,)),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                              );
                              if (pickDate != null) {
                                print(pickDate);
                                String formatteDate = DateFormat('dd-MM-yyyy').format(pickDate);
                                print(formatteDate);
                                forvaluesprovider.date(formatteDate);} else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Consumer(
                  builder: (context,ContactList,child) {

                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff6A53A7)),
                      ),
                      onPressed: () {
                        contactprovider.addContact(mainContact(Fullname.text.toString(), Phonenumber.text.toString(), email.text.toString(), dateinput.text.toString()));
                        contactprovider.saveContacts();
                        Fullname.clear();Phonenumber.clear();email.clear();dateinput.clear();

                      },
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),);
  }

  Widget Tab2(){
    final themeProvider=Provider.of<ThemeProvider>(context);
    final contactprovider=Provider.of<ContactList>(context);
    return contactprovider.contacts.length>0?
    Column(
      children: [
        for(int i=0;i<contactprovider.contacts.length;i++)...[
          ListTile(
            title: Text("${contactprovider.contacts[i].fullname}",style: TextStyle(
                color: themeProvider.currentTheme.focusColor,
                fontWeight: FontWeight.w400
            ),),
            subtitle: Text("${contactprovider.contacts[i].email}",style: TextStyle(
                color: themeProvider.currentTheme.focusColor,
                fontWeight: FontWeight.w400
            ),),
            leading: CircleAvatar(
                backgroundColor:c,
                child: Text(contactprovider.contacts[i].fullname[0])
            ),
            trailing: IconButton(

              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(i: i,c: color,),));
              },
              icon:Icon( Icons.more_vert,size: 30,),
              color: themeProvider.currentTheme.focusColor,
            ),

          ),
        ]
      ],
    ):
    Center(child: Text('No any Conatact yet...',style: TextStyle(color: themeProvider.currentTheme.focusColor)));
  }

  Widget Tab3(){
    final themeProvider=Provider.of<ThemeProvider>(context);
    final contactprovider=Provider.of<ContactList>(context);
    return  contactprovider.contacts.length>0?Column(
      children: [
        for(int i=0;i<contactprovider.contacts.length;i++)...[
          ListTile(
            title: Text("${contactprovider.contacts[i].fullname}",style: TextStyle(
                color: themeProvider.currentTheme.focusColor,
                fontWeight: FontWeight.w400
            ),),
            subtitle: Text("${contactprovider.contacts[i].phoneNumber}",style: TextStyle(
                color: themeProvider.currentTheme.focusColor,
                fontWeight: FontWeight.w400
            ),),
            leading: CircleAvatar(
                backgroundColor:c,
                child: Text(contactprovider.contacts[i].fullname[0])
            ),
            trailing: Icon(Icons.call,color: Colors.green,),

          ),
        ]
      ],
    ):
    Center(child: Text('No any Call yet...',style: TextStyle(color: themeProvider.currentTheme.focusColor)));

  }

  Widget Tab4(){
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);

    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.person,color: themeProvider.currentTheme.focusColor),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text("Profile",
                              style: TextStyle(fontSize: 20, color: themeProvider.currentTheme.focusColor, fontWeight: FontWeight.w700),),
                            Text("Update Profile",
                              style: TextStyle(fontSize: 16,color: themeProvider.currentTheme.focusColor, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: forvaluesprovider.profile,
                  onChanged: (value) {
                    forvaluesprovider.changeProfile(value);

                  },

                ),
              ],
            ),
            Consumer<forvalues>(builder: (context, forvalueprovider, child) {

              return forvalueprovider.profile?Center(
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: themeProvider.isLight ? Color(0xff4E378B) : Color(0xffE9DAFC),
                        radius: 40,
                        child:Icon(
                          Icons.person,
                          color: Colors.purple.shade200,
                          size: 25,
                        ),


                      ),
                    ),
            SizedBox(height: 30,),
            forvaluesprovider.profileText?
                Column(
              children: [
                SizedBox(width: 100,
                    child:
                    Text("${forvaluesprovider.profileName}",
                      style: TextStyle(
                          color: themeProvider.currentTheme.focusColor, fontSize: 20),

                    )),
                SizedBox(height: 15,),
                SizedBox(width: 100,
                    child:
                    Text("${forvaluesprovider.profileBio}",
                      style: TextStyle(
                          color: themeProvider.currentTheme.focusColor, fontSize: 20),

                    )),

              ],
            ):
                Column(
                  children: [
                    SizedBox(width: 100,
                        child:
                        TextField(
                          style: TextStyle(
                              color: themeProvider.currentTheme.focusColor, fontSize: 12),
                          decoration: InputDecoration(hintText: "Enter your name.." ,
                              hintStyle: TextStyle(color: Colors.grey),border: InputBorder.none),
                          controller: pname,readOnly: r,)),
                    SizedBox(height: 15,),
                    SizedBox(width: 100,child:
                    TextField(
                      style: TextStyle(color: themeProvider.currentTheme.focusColor,fontSize: 12),
                      decoration:
                      InputDecoration(hintText: "Enter your Bio.." ,
                          hintStyle: TextStyle(color: Colors.grey),border: InputBorder.none),controller: pBio,readOnly: r,)),
                  ],
                ),


                    SizedBox(height: 30,),
                    SizedBox(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () {
                              forvaluesprovider.profileName=pname.text;
                              forvaluesprovider.profileBio=pBio.text;
                              forvaluesprovider.saveProfileInfoToPrefs();
                              forvaluesprovider.changeProfileText();
                          }, child: Text("SAVE",style: TextStyle(color: color),)),
                          TextButton(onPressed: () {
                            pname.clear();
                            pBio.clear();
                            forvaluesprovider.deleteProfileInfoFromPrefs();
                            forvaluesprovider.profileText=false;
                          }, child: Text("Cancle",style: TextStyle(color: color),)),
                        ],
                      ),
                    )
                  ],
                ),
              ):Container();
            },),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Divider(
                color: Colors.grey,
                height: 10,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.light_mode_outlined,color: themeProvider.currentTheme.focusColor),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Theme",
                              style: TextStyle(
                                  fontSize: 20,color: themeProvider.currentTheme.focusColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Change Theme",
                              style: TextStyle(
                                  fontSize: 16,color: themeProvider.currentTheme.focusColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: themeProvider.isLight,
                  onChanged: (value) {
                    themeProvider.setTheme(value);
                    themeProvider.saveThemevalue(value);

                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  Widget textfilled(String name, IconData icon, TextEditingController t, dynamic k) {
    return Consumer<ThemeProvider>(
      builder: (context,ThemeProvider,child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(

            style: TextStyle(color:ThemeProvider.currentTheme.focusColor ),
            controller: t,
            keyboardType: k,


            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20,color: ThemeProvider.currentTheme.focusColor),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ThemeProvider.currentTheme.focusColor)),
              labelText: name,
              focusColor: color,

              labelStyle: TextStyle(color: ThemeProvider.currentTheme.focusColor),
              hintStyle: TextStyle(color: ThemeProvider.currentTheme.focusColor),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.grey,width: 2,)),
            ),
          ),
        );
      }
    );
  }
}

class forvalues extends ChangeNotifier with Golbal {

  bool profile = false;
   bool profileText=false;
  bool isAndroid=true;
  bool isIos=false;
  String profileName="";
  String profileBio="";



  void navigate(bool n) {
    profile= n;
    notifyListeners();
  }

  void changeProfile(bool value)async{
    profile=value;
    notifyListeners();
  }

  void changeProfileText( )async{
    profileText=true;
    notifyListeners();
  }

  void date(String a) {
    dateinput.text = a;
    notifyListeners();
  }

  void updatePbio(String value) {
    profileBio = value;
    saveProfileInfoToPrefs();
    notifyListeners();
  }

  void updatePname(String value) {
    profileName = value;
    saveProfileInfoToPrefs();
    notifyListeners();
  }



  Future<void> loadProfileInfoFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    profileName = prefs.getString('profileName') ?? "";
    profileBio = prefs.getString('profileBio') ?? "";
    profileText=prefs.getBool('profileText')??false;
    notifyListeners();
  }

  Future<void> saveProfileInfoToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileName', profileName);
    prefs.setString('profileBio', profileBio);
    prefs.setBool('profileText', profileText);

    notifyListeners();
  }

  Future<void> deleteProfileInfoFromPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('profileName');
      prefs.remove('profileBio');
      notifyListeners();
    }

}

