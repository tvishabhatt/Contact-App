import 'package:contact_app_final/Contact.dart';
import 'package:contact_app_final/EditScreen.dart';
import 'package:contact_app_final/Golbal.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';


import 'package:provider/provider.dart';


import 'ContactList.dart';

import 'ThemeProvider.dart';
import 'android_contact.dart';

class ios_contact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ios_contactState();
  }

}

class ios_contactState extends State<ios_contact> with SingleTickerProviderStateMixin , Golbal
{
    late TabController controller;
    Color color=Colors.green;
  @override
  void initState() {
    controller=TabController(length: 4, vsync: this,initialIndex: 1);
    super.initState();
    Provider.of<forvalues>(context, listen: false).loadProfileInfoFromPrefs();
  }
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);
    return  Scaffold(
      backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Platform Converter',style: TextStyle(color: themeProvider.currentTheme.focusColor),),
        backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
        actions: [
          CupertinoSwitch(
            value:forvaluesprovider.isIos,
            focusColor: Colors.green,
            thumbColor:Colors.green ,
            trackColor: Colors.white,
            activeColor: Colors.white,
            onChanged: (value) {
              forvaluesprovider.navigate(value);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: TabBarView(
        controller: controller,

        children: [
          Tab1(),
          Tab2(),
          Tab3(),
          Tab4(),

        ],
      ),
      bottomNavigationBar: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: TabBar(
          controller: controller,
          indicatorSize: TabBarIndicatorSize.label,

          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: Colors.grey,
          labelColor: color,
          labelPadding: EdgeInsets.zero,
          indicatorColor: themeProvider.currentTheme.scaffoldBackgroundColor,
          indicatorPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
              color: color
          ),
          tabs: [
            Tab(icon: Icon(CupertinoIcons.person_badge_plus),),
            Tab(icon: Icon(CupertinoIcons.chat_bubble_2),),
            Tab(icon: Icon(CupertinoIcons.phone),),
            Tab(icon: Icon(CupertinoIcons.settings),),

          ],
        ),
      ),

    );

  }

    Widget Tab1(){
    final themeProvider=Provider.of<ThemeProvider>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);
    final contactprovider=Provider.of<ContactList>(context);
    return
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor:  themeProvider.isLight?Colors.black:Colors.white,
                  radius: 40,
                  child:Icon(
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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
      return    contactprovider.contacts.length>0?Column(
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
      Center(child: Text('No any Conatct yet...',
          style: TextStyle(color: themeProvider.currentTheme.focusColor)));
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
              subtitle: Text("${contactprovider.contacts[i].email}",style: TextStyle(
                  color: themeProvider.currentTheme.focusColor,
                  fontWeight: FontWeight.w400
              ),),
              leading: CircleAvatar(
                  backgroundColor:c,
                  child: Text(contactprovider.contacts[i].fullname[0])
              ),
              trailing: Icon(CupertinoIcons.phone,color: Colors.blue,) ,

            ),
          ]
        ],
      ):
      Center(child: Text('No any Call yet...',
          style: TextStyle(color: themeProvider.currentTheme.focusColor)));
    }

    Widget Tab4(){
      final themeProvider=Provider.of<ThemeProvider>(context);
      final forvaluesprovider = Provider.of<forvalues>(context);
      final contactprovider=Provider.of<ContactList>(context);
      return   SingleChildScrollView(
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
                  CupertinoSwitch(
                    value: forvaluesprovider.profile,
                    focusColor: Colors.green,
                    thumbColor:Colors.green ,
                    trackColor: Colors.white,
                    activeColor: Colors.white,
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
                          backgroundColor: themeProvider.isLight ? Color(
                              0xff38d035)
                              : Color(0xffE9DAFC),
                          radius: 40,
                          child:Icon(
                              Icons.person,
                              color: Colors.green.shade200,
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
                     )
                         :Column(
                       children: [
                         SizedBox(width: 100,child:
                         TextField(style: TextStyle(
                             color: themeProvider.currentTheme.focusColor, fontSize: 20),
                           decoration: InputDecoration(hintText: "Enter your name.." ,
                               hintStyle: TextStyle(color: Colors.grey),border: InputBorder.none),
                           controller: pname,readOnly: r,)),
                         SizedBox(height: 15,),
                         SizedBox(width: 100,
                             child:
                             TextField(
                               style:
                               TextStyle(     color: themeProvider.currentTheme.focusColor,fontSize: 18),decoration: InputDecoration(hintText: "Enter your Bio.." ,hintStyle: TextStyle(color: Colors.grey),border: InputBorder.none),controller: pBio,readOnly: r,)),
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

                  CupertinoSwitch(
                    value: themeProvider.isLight,
                    focusColor: Colors.green,
                    thumbColor:Colors.green ,
                    trackColor: Colors.white,
                    activeColor: Colors.white,
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
      return Consumer(
          builder: (context,ConatctList,child) {
            return Consumer(
                builder: (context,ThemeProvider themeNotifier,child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color:themeNotifier.currentTheme.focusColor),
                      controller: t,
                      keyboardType: k,

                      decoration: InputDecoration(
                        icon: Icon(icon,size: 20,color: Colors.green,),
                        labelText: name,
                        labelStyle: TextStyle(color:themeNotifier.currentTheme.focusColor,fontSize: 20),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 4,
                            )),
                      ),
                    ),
                  );
                }
            );
          }
      );
    }

}
