import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
                setState(() {
                  followings[index] = !followings[index];
                });
              },
              leading: RoundedAvatar(),
              title: Text('username$index'),
              subtitle: Text('user bio number $index'),
              trailing: Container(
                alignment: Alignment.center ,
                height: 30, width: 80, decoration: BoxDecoration(
                color: followings[index]?Colors.red.shade50:Colors.blue.shade50,
                border: Border.all(color: followings[index]?Colors.red:Colors.blue, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
                child: Text('following',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey,);
          },
          itemCount: followings.length),
    );
  }
}
