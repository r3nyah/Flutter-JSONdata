import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jsondata_flutter/Src/Chara/Detail.dart';
import 'package:jsondata_flutter/Src/Model/Model.dart';
import 'package:jsondata_flutter/Src/Chara/Card.dart';
import 'package:jsondata_flutter/Src/Constant/Constants.dart';

class CharaList extends StatefulWidget {
  const CharaList({Key? key}) : super(key: key);

  @override
  State<CharaList> createState() => _CharaListState();
}

class _CharaListState extends State<CharaList> {
  Widget appBarTitle = const Text('Hololive-ID',style: TextStyle(color: Colors.blue,fontSize: 22),);
  Icon actionIcon = const Icon(Icons.search,color: Colors.blue,);

  TextEditingController controller = TextEditingController();
  List<Model> charaData = [];
  List<Model> _List = [];
  String filter = '';

  //const CharaList({Key? key}) : super(key: key);

  @override
  void dispose(){
    controller.addListener(() {
      if(controller.text.isEmpty){
        setState((){
          filter = '';
        });
      }else{
        setState((){
          filter = controller.text;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTopAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.black,
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: (){
            setState((){
              if(actionIcon.icon == Icons.search){
                actionIcon == const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                );
                appBarTitle = TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.blue,),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                    hintText: 'Search Here!'
                  ),
                  style: const TextStyle(color: Colors.blue,fontSize: 20),
                );
              }else{
                actionIcon = const Icon(
                  Icons.search,
                  color: Colors.blue,
                );
                appBarTitle = const Text('Hololive-ID Member',style: TextStyle(color: Colors.blue,fontSize: 22),);
                _List =  charaData;
                controller.clear();
              }
            });
          },
        ),
      ],
    );
    if((filter.isNotEmpty)){
      List<Model> tmpListChara = <Model>[];
      for(int i = 0;i<_List.length;i++){
        if(_List[i].name!.toLowerCase().contains(filter.toLowerCase())){
          tmpListChara.add(_List[i]);
        }
      }
      _List = tmpListChara;
    }
    if(filter.isNotEmpty && _List.isNotEmpty){
      return Scaffold(
        appBar: appTopAppBar,
        body: Center(
          child: Text(
            'Member ${filter.toString()} is`t found ;(',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: appTopAppBar,
        body: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            if(constraints.maxWidth<600){
              return _generateContainer(2);
            }else if(constraints.maxWidth<900){
              return _generateContainer(4);
            }else{
              return _generateContainer(6);
            }
          },
        ),
      );
    }
  }

  Widget _generateContainer(int value){
    Future<List<Model>> readJsonData() async{
      final jsondata = await root_bundle.rootBundle.loadString('Material/Data.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e){
        return Model.fromJson(e);
      }).toList();
    }

    return Center(
      child: FutureBuilder(
        future: readJsonData(),
        builder: (context,snapshot){
          if(snapshot.data != null){
            charaData = snapshot.data as List<Model>;
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          if((filter.isEmpty)){
            _List = charaData;
          }

          return MasonryGridView.count(
            mainAxisSpacing: 4,
            crossAxisCount: value,
            crossAxisSpacing: 4,
            itemCount: _List.length,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            itemBuilder: (context,index){
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CharaDetail(
                                name:       _List[index].name.toString(),
                                birthday:   _List[index].birthday.toString(),
                                gender:     _List[index].gender.toString(),
                                image:      _List[index].image.toString(),
                                gen:        _List[index].gen == 1?AppColor.c2020:AppColor.c2021,
                                //color:      _List[index].color,
                              );
                            },
                          )
                        );
                      },
                      child: CustomCard(
                        height: _List[index].name.toString().length > 14?270:270,
                        image: _List[index].image.toString(),
                        name: _List[index].name.toString(),

                      )
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}