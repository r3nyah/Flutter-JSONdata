import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jsondata_flutter/Src/Constant/Constants.dart';

class CharaDetail extends StatelessWidget {
  final String name;
  final String birthday;
  final String gender;
  final String image;
  final Color gen;
  //final Color color;

  const CharaDetail({
    Key? key,
    required this.gen,
    required this.image,
    required this.name,
    required this.birthday,
    //required this.color,
    required this.gender,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    const String logo = 'https://pbs.twimg.com/profile_images/1198438854841094144/y35Fe_Jj_400x400.jpg';

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    color: gen,

                    child: Center(
                      child: Image.network(
                        image,
                        height: MediaQuery.of(context).size.height*0.5,
                        loadingBuilder: (context,child,loadingProgress){
                          if(loadingProgress == null){
                            return child;
                          }else{
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.cardGreyColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.angleLeft,
                              color: AppColor.mainTextColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SvgPicture.asset(
                        'img/svg/menu.svg',
                        height: 40,
                        width: 40,
                        color: AppColor.mainTextColor,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.36,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height*0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColor.mainTextColor,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                          Image.network(
                            logo,
                            width: 90,
                            height: 90,
                            loadingBuilder: (context,child,loadingProgress){
                              if(loadingProgress == null){
                                return child;
                              }else{
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                          Text(
                            gender,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColor.secondTextColor,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                          Text(
                            'Birthday : $birthday',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColor.mainTextColor,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.006,),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
