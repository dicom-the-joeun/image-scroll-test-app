import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool _imagesCached = false;
  int _index = 0;
  late PhotoViewScaleStateController scaleStateController;

  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_imagesCached) {
      for (int index = 0; index < 20; index++) {
        precacheImage(
            CachedNetworkImageProvider(
              "http://127.0.0.1:8000/api/dcms/image?filepath=201610%5C25%5CMS0014%5CXA%5C9%5C&filename=XA.1.3.46.670589.28.681722604217246.201610250514310489962211211.dcm&index=$index",
              cacheKey:
                  "UNIQUE_CACHE_KEY_$index", // Unique cache key for each image
              headers: const {
                "Authorization":
                    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDUxNzQ1MDMsInN1YiI6ImFkbWluIn0.hs6-6wcAeNg-VhcLE5iPTLsIRb-mgkkKw0xarZc2v-c"
              },
            ),
            context);
      }
      setState(() {
        _imagesCached = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: PhotoView(
                enableRotation: true,
                scaleStateController: scaleStateController,
                imageProvider: CachedNetworkImageProvider(
                  "http://127.0.0.1:8000/api/dcms/image?filepath=201610%5C25%5CMS0014%5CXA%5C9%5C&filename=XA.1.3.46.670589.28.681722604217246.201610250514310489962211211.dcm&index=$_index",
                  cacheKey:
                      "UNIQUE_CACHE_KEY_$_index", // Unique cache key for each image
                  headers: const {
                    "Authorization":
                        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDUxNzQ1MDMsInN1YiI6ImFkbWluIn0.hs6-6wcAeNg-VhcLE5iPTLsIRb-mgkkKw0xarZc2v-c"
                  },
                ),
              ),
            ),
            CupertinoSlider(
              value: _index.toDouble(),
              max: 19.0,
              divisions: 19,
              onChanged: (double value) {
                setState(() {
                  _index = value.toInt();
                });
              },
            ),
            TextButton(
              onPressed: goBack,
              child: const Text("Go to original size"),
            ),
          ],
        ),
      ),
    );
  }

  void goBack(){
    scaleStateController.scaleState = PhotoViewScaleState.initial;
  }
}
