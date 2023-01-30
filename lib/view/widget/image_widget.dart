import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdb/utils/imports.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, this.imageUrl, this.fit});
  final String? imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return imageUrl == null || imageUrl == ''
        ? errorWidget()
        : CachedNetworkImage(
            imageUrl: ApiString.imageUrl + imageUrl!,
            progressIndicatorBuilder: (context, url, progress) {
              return const Center(
                child: Text(
                  "Loading...",
                  style:
                      TextStyle(fontSize: size10, color: kDeepOrangeColor,),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return errorWidget();
            },
            fit: fit ?? BoxFit.contain,
          );
  }

  Widget errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.image,
          color: kHintColor,
        ),
        Text(
          'Image not available',
          style: TextStyle(fontSize: size10, color: kHintColor),
        ),
      ],
    );
  }
}
