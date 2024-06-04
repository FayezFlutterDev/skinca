import 'package:flutter/material.dart';


class Examp extends StatefulWidget {
  Examp({super.key});

  @override
  State<Examp> createState() => _ExampState();
}

class _ExampState extends State<Examp> {
  List<Map<String, dynamic>> items = [
    {'text': 'Language', 'icon': Icons.language, 'onTap': () => print('Language tapped')},
    {'text': 'Change Password', 'icon': Icons.lock, 'onTap': () => print('Change Password tapped')},
    {'text': 'Help', 'icon': Icons.help, 'onTap': () => print('Help tapped')},
    {'text': 'Contact Us', 'icon': Icons.contact_phone, 'onTap': () => print('Contact Us tapped')},
  ];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF009788),
      appBar: AppBar(title: Text('Example')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            AnimatedContainer(

              duration: Duration(milliseconds: 300),
              height: isExpanded?60:200,

              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Color(0xFF009788),



              ),

              child: !isExpanded? FittedBox(
                child: Center(child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                    ),
                
                    Text('Your Name',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),)
                  ],
                ),),
              ):Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Expanded(child: Row(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                  ),

                  Text('Your Name',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),

                ],)),
                Icon(Icons.arrow_back)
              ],),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100))
                ),
                padding: EdgeInsets.only(top: 50),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    onExpansionChanged: (v) {
                      setState(() {
                        isExpanded = v;
                      });
                    },
                    title: Text(
                      'الإعدادات',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    childrenPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    leading: Icon(Icons.settings,color:isExpanded? Colors.lightBlueAccent:null,),
                    trailing: AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: isExpanded ? Icon(Icons.keyboard_arrow_down,color: Colors.lightBlueAccent,) : Icon(Icons.keyboard_arrow_left,color: Colors.grey,),
                    ),
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => null,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: List.generate(items.length, (index) {
                              return ListTile(
                                leading: Icon(items[index]['icon'],color: Colors.lightBlueAccent,),
                                title: Text(items[index]['text'],style: TextStyle(color: Colors.lightBlueAccent,),),
                                onTap: items[index]['onTap'],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}