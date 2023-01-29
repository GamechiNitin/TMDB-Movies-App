import 'package:tmdb/utils/imports.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.onTap,
    required this.onCartTap,
    required this.added,
  });
  final String? imageUrl;
  final String name;
  final String category;
  final String price;
  final String rating;
  final bool added;
  final VoidCallback onTap;
  final VoidCallback onCartTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
              // color: kBlackColor,
              color: Colors.white,
              boxShadow: kNeuShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kBorderRadius),
                          topRight: Radius.circular(kBorderRadius),
                        ),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kBorderRadius),
                          topRight: Radius.circular(kBorderRadius),
                        ),
                        child: ImageWidget(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (rating != '')
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kLightPrimaryColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              double.parse(rating) < 2.5
                                  ? Icons.star_half
                                  : Icons.star,
                              size: size12,
                              color: kOrangeColor,
                            ),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: size12,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: size12,
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: size12,
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    bottom: 4,
                    right: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            size: size14,
                            color: kBlueColor,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: size14,
                              color: kBlackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCartTap,
            child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(
                left: 8.0,
                bottom: 4,
                right: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: added ? kDeepOrangeColor : kBlackColor.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.favorite,
                color: kWhiteColor,
                size: size14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
