import 'package:flutter/material.dart';
import 'package:fluttertest/controller/controller.dart';
import 'package:fluttertest/model/comment_model.dart';
import 'package:fluttertest/model/post_model.dart';
import 'package:fluttertest/widget/text_with_label.dart';
import 'package:sizer/sizer.dart';

class SecondScreen extends StatefulWidget {
  final PostModel postData;
  const SecondScreen({super.key, required this.postData});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  ValueNotifier<List<CommentModel>> commentData = ValueNotifier([]);
  ValueNotifier<List<CommentModel>> commentSearch = ValueNotifier([]);
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    Controller().getComment(widget.postData.id!).then((value) {
      commentData.value = value;
      commentSearch.value = [...commentData.value];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comment Page'),
        ),
        body: ValueListenableBuilder<List<CommentModel>>(
            valueListenable: commentData,
            builder: (context, data, child) {
              return data.isEmpty
                  ? const Center(child: Text("No Data"))
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textField(),
                          SizedBox(
                            height: 2.h,
                          ),
                          for (var item in data) ...[
                            cardDesign(item),
                            SizedBox(height: 0.7.h),
                          ]
                        ],
                      ),
                    );
            }));
  }

  textField() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 3.h),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          suffix: Container(
            width: 30.w,
            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: textEditingController.text == ''
                    ? null
                    : () {
                        commentData.value = [...commentSearch.value]
                            .where((element) =>
                                element.name!.contains(textEditingController.text) ||
                                element.body!.contains(textEditingController.text) ||
                                element.email!.contains(textEditingController.text))
                            .toList();
                      },
                child: const SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          ),
          hintText: 'Search',
          contentPadding: EdgeInsets.fromLTRB(5.w / 2, 5.w / 3, 5.w / 3, 5.w / 3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        controller: textEditingController,
        onChanged: (value) {
          if (value == '') {
            Controller().getComment(widget.postData.id!).then((value) {
              commentData.value = value;
              commentSearch.value = [...commentData.value];
            });
          }
        },
      ),
    );
  }

  cardDesign(CommentModel data) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithLabel(label: 'Name', data: data.name!),
              TextWithLabel(label: 'Email', data: data.email!),
              TextWithLabel(label: 'Comment', data: data.body!),
            ],
          ),
        ),
      ),
    );
  }
}
