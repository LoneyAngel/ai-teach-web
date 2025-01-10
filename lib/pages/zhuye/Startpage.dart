import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//图标
import 'package:phosphor_flutter/phosphor_flutter.dart';


//组件的补充
import 'package:untitled1/pages/zhuye/Searchpage.dart';
import 'package:untitled1/pages/zhuye/Connectpage.dart';


/*初始页面及其衍生的页面*/



class Startpage extends StatefulWidget{
  Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {

  int _selectedIndex=0;

  List<Widget> widgets=[
    Searchpage(),
    Connectpage()
  ];


  //利用点击函数进行页面的刷新
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50.withGreen(230),
        title: Text('SHOT MOON'),
        actions: [
          //设置原型的头像
          // IconButton(onPressed: ()=>print("nihao"), icon:),
          // CircleAvatar(
          //   backgroundImage: NetworkImage(r"C:\Users\程煜博\Desktop\VCG211492076912.jpg"),
          //   radius: 20.0, // 设置头像半径
          //
          // ),

          //设置复杂的现代化的头像
          InkWell(
            onTap: () {
              // 点击头像时执行的操作
              print('头像被点击了！');
            },
            borderRadius: BorderRadius.circular(100.0), // 圆形边界
            onHover: (bool value) {

            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('picture/head.jpg'),
              radius: 20.0,

            ),
          )
        ],
      ),

      drawer: Drawer(//抽屉
          child: Column(
            children: [
              //drawer的元素的填充
              DrawerHeader(child: Icon(
                  Icons.ac_unit)
              ),
              ListTile(
                  leading: Icon(Icons.account_balance_sharp),
                  title: Text("Startpage"),
                  onTap: (){
                    //点击函数
                    Navigator.pushNamed(context, '/Startpage');
                    // Navigator.pop(context);
                    print("点击");
                  }
              ),
              ListTile(
                  leading: Icon(Icons.account_tree_outlined),
                  title: Text("Resource"),
                  onTap: (){
                    //点击函数
                    Navigator.pushNamed(context, '/tabview/Resourcepage');
                    // Navigator.of(context).pop();
                    print("点击");
                  }
              ),
              ListTile(
                  leading: Icon(
                    PhosphorIcons.gear(PhosphorIconsStyle.fill),
                    size: 32.0,
                  ),
                  title: Text("Setting"),
                  onTap: (){
                    Navigator.pushNamed(context, '/tabview/Settingpage');
                    // Navigator.pop(context);
                    print("点击");
                  }
              )
            ],
          )
      ),

      body: Row(
        children:[
          Column(
            children: [
              MediaQuery(
                data: MediaQuery.of(context as BuildContext).copyWith(textScaler: TextScaler.linear(1.0)),
                child: Container(
                    margin: EdgeInsets.only(top: 30,left: 10,bottom: 30,right: 10),
                    width: 60,
                    height: MediaQuery.of(context as BuildContext).size.height * 0.75,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade100,
                          Colors.pink.shade100,
                          Colors.white
                        ],
                      ),
                      // borderRadius: BorderRadius.circular(20.0), // 圆角
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight:Radius.circular(20),
                          bottomLeft:Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      // 圆角
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // 阴影偏移
                        ),
                      ],
                      // color: Colors.lightBlueAccent,
                    ),

                    child: Align(
                      alignment: Alignment.center,
                      child: ListView(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Tooltip(
                            message: "搜索",
                            preferBelow: false, // 不优先在下方显示
                            child: IconButton(
                              icon: Icon(
                                PhosphorIcons.cat(),
                                size: 32.0,
                              ),
                              onPressed: () {
                                _onItemTapped(0);
                              },
                            ),
                          ),

                          ListTile(
                            title: Text('AI',textAlign: TextAlign.center,style: TextStyle(

                            ),),
                            onTap: () {//点击事件
                              _onItemTapped(1);
                            },
                          ),
                          ListTile(
                            title: Text('书桌',textAlign: TextAlign.center),
                            onTap: () {
                              _onItemTapped(2);
                              print('Item 2 tapped');
                            },
                          ),
                          // Add more items as needed
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
          Expanded(child: Center(
              child: widgets.elementAt(_selectedIndex))
          ),
        ],
      ),
    );
  }
}