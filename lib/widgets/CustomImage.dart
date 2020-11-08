import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';

class CustomImage extends StatelessWidget {

  String imageUrl;
  String initiales;
  double radius;


  CustomImage(this.imageUrl, this.initiales, this.radius);

  @override
  Widget build(BuildContext context) {
    if (StringUtils.isNullOrEmpty(imageUrl)){
      return new CircleAvatar(
        radius: radius ?? 0.0,
        backgroundColor: Colors.blue,
        child: new Text(
          initiales ?? "",
          style:  new TextStyle(color: Colors.white, fontSize: radius),
        ),
      );
    }

    ImageProvider provider = CachedNetworkImageProvider(imageUrl);
    if(radius == null){
      // image dans chat
      return new InkWell(
        child: new Image(image: provider, width:  250,),
        onTap: (){
          // Montrer image en grand
        },
      );
    }

    return InkWell(
      child: new CircleAvatar(
        radius: radius,
        backgroundImage: provider,
      ),
      onTap: () {

      },
    );

  }

}