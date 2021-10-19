import 'package:cartoonex/models/cartoonmodel.dart';
import 'package:cartoonex/utility/style.dart';
import 'package:cartoonex/widget/viewpdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShowCartoonList extends StatefulWidget {
  // const ShowCartoonList({ Key? key }) : super(key: key);

  @override
  _ShowCartoonListState createState() => _ShowCartoonListState();
}

class _ShowCartoonListState extends State<ShowCartoonList> {
  List<Widget> widgets = []; //GridView မှာထည့်ဖို့
  List<CartoonModel> cartoonModels = [];

  @override
  void initState() {
    super.initState();
    redData();
  }

  Future<Null> redData() async {
    await Firebase.initializeApp().then(
      (value) async {
        // ignore: await_only_futures
        await FirebaseFirestore.instance
            .collection('cartoon')
            .orderBy('name')
            .snapshots()
            .listen(
          (event) {
            //carton ထဲက document array
            print('SnapShot =${event.docs}');
            //firestore ထဲက document ကို array အနေအကုန်ပေါင်းထုတ်တာ
            int index = 0;
            for (var snapshots in event.docs) {
              Map<String, dynamic> map = snapshots.data();
              //firestore ထဲက document ကို array အနေတခုချင်းပြန်ထုတ်တာ
              print('Map =$map');
              CartoonModel model = CartoonModel.fromMap(map);
              cartoonModels.add(model);
              print('Name =${model.name}');
              setState(() {
                widgets.add(creatWidget(model, index));
              });
              index++;
            }
          },
        );
      },
    );
  }

  Widget creatWidget(CartoonModel model, int index) => GestureDetector(
        onTap: () {
          //17.10.2021
          print('Your click Index = $index');
          // ignore: unused_local_variable
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (context) => ViewCartoonPDF(
              cartoonModel: cartoonModels[index],
            ),
          );
          Navigator.push(context, materialPageRoute);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 120.0,
                child: Image.network(model.cover),
              ),
              SizedBox(
                height: 10,
              ),
              Style().titileH3(model.name),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.extent(
              maxCrossAxisExtent: 200,
              children: widgets,
            ),
    );
  }
}
