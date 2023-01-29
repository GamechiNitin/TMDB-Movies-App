import 'package:tmdb/utils/imports.dart';

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({
    super.key,
    required this.price,
    required this.onFavoriteTap,
    required this.isAddedToCart,
    required this.onWatchNowTap,
  });
  final String price;
  final VoidCallback onFavoriteTap;
  final VoidCallback onWatchNowTap;
  final bool isAddedToCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFavoriteTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        decoration: BoxDecoration(
          // color: kPrimaryColor,
          borderRadius: BorderRadius.circular(300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onWatchNowTap,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: kBlueColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(300),
                      bottomLeft: Radius.circular(300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.play_circle_outline,
                        size: 24,
                        color: kWhiteColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Watch Now',
                        style: TextStyle(
                          fontSize: size18,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isAddedToCart ? kErrorColor : kBlackColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(300),
                      bottomRight: Radius.circular(300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isAddedToCart ? 'Remove ' : "Add ",
                        style: const TextStyle(
                          fontSize: size18,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.favorite,
                        size: 24,
                        color: kWhiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
