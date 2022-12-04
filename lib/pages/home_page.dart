import 'dart:math';
import 'package:app/widget/appbutton.dart';
import 'package:english_words/english_words.dart';
import 'package:app/models/english_today.dart';
import 'package:app/values/assets.dart';
import 'package:app/values/colors.dart';
import 'package:app/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes/quotes.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentindex =0;
  PageController _pagecontroller=PageController();
  List<EnglishToday> words = [];
  List<int> fixedListRandom({int len=1, int max=120,int min=1}){
    if(len>max||len<min) { return [];}
    List<int> newList= [];
    Random random = Random();
    int count = 1;
    while(count<=len){
      int val= random.nextInt(max);
      if (newList.contains(val)){
        continue;
      } else{
        newList.add(val);
        count++;
      }
    }
    return newList;

  }
  getEnglishToday(){
    List<String> newList = [];
    List<int> rans = fixedListRandom(len:5, max: nouns.length);
    for (var index in rans) {newList.add(nouns[index]);}
    words= newList.map((e) => EnglishToday(noun: e)).toList();
  }
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState(){
    getEnglishToday();
    super.initState();
  }
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text('English today', style: AppStyles.h3.copyWith(color: Color(0xff353535), fontSize: 36),),
        leading: InkWell(
          onTap: (){_key.currentState!.openDrawer();},
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Image.asset(AppAssets.menu,height: 38,width: 38),
          ),
        ) ,
      ),
      body:
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        child: Column(
          children: [Container(height: size.height*1/10,
            alignment: Alignment.centerLeft,
            child: Text('"It is amazing how complete is the delusion that beauty is goodness."',
          style: AppStyles.h5.copyWith(fontSize: 12, color: AppColors.textColor),),

          ),
            Container(
              height: size.height*2/3,

              child: PageView.builder(
                controller: _pagecontroller,
                onPageChanged: (index){
                  setState(() {
                    _currentindex=index;
                  });
                },
                itemCount: 5,
                  itemBuilder: (context,index){
                  String firstLetter=words[index].noun !=null ? words[index].noun! : " ";
                  firstLetter=firstLetter.substring(0,1);
                  String leftLetter=words[index].noun !=null ? words[index].noun! : " ";
                  leftLetter=leftLetter.substring(1,leftLetter.length);
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: const BoxDecoration(color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(24)),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Icon(CupertinoIcons.heart_solid,color: Colors.white,size: (50)),
                        alignment: const Alignment(0.9, 0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: RichText(maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                          text: firstLetter,style:TextStyle(
                          fontFamily: FontFamily.sen,
                          fontSize: 89,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: Colors.black38,
                          offset: Offset(3,6), blurRadius:6)]
                        ),
                            children: [TextSpan(text: leftLetter,
                              style:TextStyle(
                                fontFamily: FontFamily.sen,
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                shadows: [BoxShadow(color: Colors.black38,
                                    offset: Offset(3,6), blurRadius:6)]
                            ),)]
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB( 12,64,12,64),
                        child: Text(Quotes.getRandom().getContent(),
                        style: AppStyles.h4.copyWith(letterSpacing: 1,color: AppColors.textColor)),
                      )
                    ],
                  ),
                );
            },
            )
            ),
            Container(
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, 
                  itemBuilder: (context,index){
                  return buildIndicator(index==_currentindex, size);
                  }
              ),
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: (){
          print('exchange');
          setState(() {
            getEnglishToday();
          });
        },
        child: Icon(Icons.change_circle,),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Padding(
              padding: const EdgeInsets.only(left:16.0,top:24),
              child: Text('Your mind', style: AppStyles.h3.copyWith(color: AppColors.textColor)),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 24.0),
               child: AppButton(label: 'Favourites', onTap:(){}),

             ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildIndicator(bool isActive, Size size){
    return Container(
      // height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width*1/5 : 24,
      decoration: BoxDecoration(
        color: isActive? AppColors.lightBlue : AppColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [BoxShadow(color: Colors.black38,
        offset: Offset(2,3),
        blurRadius: 3)]
      ),
    );
  }
}
