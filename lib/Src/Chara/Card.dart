import 'package:flutter/material.dart';
import 'package:jsondata_flutter/Src/Constant/Constants.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final String image;
  final String name;

  const CustomCard({
    Key? key,
    required this.name,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      width: 200,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20,),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(right: 13),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainTextColor,
                      ),
                    ),
                  )
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
          const SizedBox(height: 10,),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                width: 140,
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
        ],
      ),
    );
  }
}