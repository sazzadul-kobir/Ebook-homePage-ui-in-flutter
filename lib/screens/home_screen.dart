import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:musicplayer/Tabs/my_tabs.dart';


import 'package:musicplayer/Utils/colors.dart' as appColor;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List Popularbooks = [];
  List Books=[];
  late ScrollController scrollController;
  late TabController tabController;

  void ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("jsons/popularbooks.json")
        .then((value) {
      setState(() {
        Popularbooks = json.decode(value);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("jsons/books.json")
        .then((value) {
      setState(() {
        Books = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
    tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        "img/menu.png",
                      ),
                      size: 24,
                      color: Colors.black,
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.notifications)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Popular Books",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 180,
                child: PageView.builder(
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(Popularbooks[index]["img"]),
                          )),
                    );
                  },
                  itemCount: Popularbooks!.length,
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,

                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(40),

                        child: Container(
                          margin: EdgeInsets.only(bottom: 20,left: 15),
                          child: TabBar(

                            tabAlignment:TabAlignment.center,
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelPadding: EdgeInsets.only(right: 10,),

                            controller: tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0, 0))
                                ]),

                            tabs: [

                              appTabs(
                                  text: "New",
                                  tabColor: appColor.menu1Color
                              ),
                              appTabs(
                                  text: "Popular",
                                  tabColor: appColor.menu2Color
                              ),
                              appTabs(
                                  text: "Trending",
                                  tabColor: appColor.menu3Color
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(

                            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: appColor.tabVarViewColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey.withOpacity(0.2)
                                  )
                                ]
                              ),
                              child: Row(

                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 120,
                                    width: 90,
                                   

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        
                                        image: AssetImage(Books[index]["img"],),
                                        fit: BoxFit.fitWidth
                                      )
                                    ),

                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Icon(Icons.star,size: 24,color: appColor.starColor,),
                                        SizedBox(width: 5,),
                                        Text(Books[index]["rating"], style: TextStyle(color:appColor.menu2Color),)
                                      ],),
                                      Text(Books[index]["title"],
                                        style:TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ) ,),
                                      Text(Books[index]["text"],
                                        style:TextStyle(
                                            fontSize: 16,
                                            color: appColor.subTitleText
                                        ) ,),
                                      Container(
                                        width: 55,
                                        height: 20 ,
                                        decoration: BoxDecoration(
                                          color: appColor.loveColor,
                                          borderRadius: BorderRadius.circular(3)
                                        ),
                                        child:Text("love",
                                          style:TextStyle(
                                              fontSize: 12,
                                              color: Colors.white
                                          ) ,

                                        ),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } ,
                    itemCount: Books.length,
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("content"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("content"),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}


