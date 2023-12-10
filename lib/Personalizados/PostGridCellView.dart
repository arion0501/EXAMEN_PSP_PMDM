import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPosts.dart';

class PostGridCellView extends StatelessWidget {
  final List<FbPosts> post;
  final Function(int indice)? onItemListClickedFun;

  const PostGridCellView(
      {super.key, required this.post, required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: EdgeInsets.all(8),
        itemCount: post.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  post[index].titulo,
                  style: TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            onTap: () {
              onItemListClickedFun!(index);
            },
          );
        });
  }
}
