import 'package:flutter/material.dart';
import 'package:fluttertest/controller/controller.dart';
import 'package:fluttertest/model/post_model.dart';
import 'package:fluttertest/second_screen.dart';
import 'package:fluttertest/widget/text_with_label.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<List<PostModel>> postData = ValueNotifier([]);

  @override
  void initState() {
    Controller().getData().then((value) {
      postData.value = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: ValueListenableBuilder<List<PostModel>>(
            valueListenable: postData,
            builder: (context, data, child) {
              return data.isEmpty
                  ? const Center(child: Text("No Data"))
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var item in data) ...[
                            cardDesign(item),
                            SizedBox(height: 0.7.h),
                          ]
                        ],
                      ),
                    );
            }));
  }

  cardDesign(PostModel data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageTransition(child: SecondScreen(postData: data), type: PageTransitionType.fade));
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithLabel(label: 'Title', data: data.title!),
                TextWithLabel(label: 'Post', data: data.body!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
