// ignore_for_file: use_build_context_synchronously
import 'package:tmdb/utils/imports.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.topRatedModel});
  final TopRatedModel topRatedModel;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  List<TopRatedModel> favoriteListData = [];
  bool isAddedToCart = false;

  @override
  void initState() {
    getCartData();

    super.initState();
  }

  Future<void> getCartData() async {
    final db = LocalDatabase();
    favoriteListData = await db.getFavorite();
    if (favoriteListData.any((e) => e.id == widget.topRatedModel.id)) {
      isAddedToCart = true;
    }
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  _refresh() {
    favoriteListData.clear();
    isAddedToCart = false;
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      extendBody: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kBlackColor),
        backgroundColor: kWhiteColor,
        elevation: kAppBarElevation,
        titleSpacing: 0,
        title: const Text('Movie Detail'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: kBlackColor,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
              _refresh();
            },
            icon: Icon(
              !isAddedToCart ? Icons.favorite_border : Icons.favorite,
              color: kErrorColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          imageCard(widget.topRatedModel.posterPath ?? ""),
          Expanded(
            child: detailsCard(
              name: widget.topRatedModel.title ?? "",
              category: widget.topRatedModel.releaseDate ?? "",
              desc: widget.topRatedModel.overview ?? "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: FavoriteButtonWidget(
        isAddedToCart: isAddedToCart,
        price: widget.topRatedModel.popularity.toString(),
        onWatchNowTap: () {
          if (widget.topRatedModel.id != null) {
            Helper.launchInBrowser(widget.topRatedModel.id.toString());
          }
        },
        onFavoriteTap: () async {
          isAddedToCart = !isAddedToCart;
          if (isAddedToCart) {
            List<TopRatedModel> list = [];
            list.addAll(favoriteListData);
            list.remove(widget.topRatedModel);
            final db = LocalDatabase();
            await db.addToFavorite(list);
          } else {
            favoriteListData.add(widget.topRatedModel);
            final db = LocalDatabase();
            await db.addToFavorite(favoriteListData);
          }
          _notify();
        },
      ),
    );
  }

  Widget imageCard(String imageUrl) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 12, bottom: 12),

      // padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius),
          topRight: Radius.circular(kBorderRadius),
        ),
        color: kWhiteColor,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius),
          topRight: Radius.circular(kBorderRadius),
        ),
        child: ImageWidget(
          imageUrl: ApiString.imageUrl + imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget detailsCard({
    required String name,
    required String category,
    required String desc,
  }) {
    return Container(
      color: kLightPrimaryColor,
      padding: const EdgeInsets.all(20),
      // height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: size16,
              color: kBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                Expanded(child: categoryCard()),
                Expanded(child: ratingCard()),
              ],
            ),
          ),
          Text(
            desc,
            style: const TextStyle(
              fontSize: size14,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      color: kPrimaryColor,
      child: Text(
        widget.topRatedModel.releaseDate ?? "",
        style: const TextStyle(
          fontSize: size14,
          color: kWhiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget ratingCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: kLightPrimaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.topRatedModel.voteAverage! < 2.5
                ? Icons.star_half
                : Icons.star,
            size: size16,
            color: kOrangeColor,
          ),
          const SizedBox(width: 6),
          Text(
            widget.topRatedModel.voteAverage.toString(),
            style: const TextStyle(
              fontSize: size14,
              color: kBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            " (${widget.topRatedModel.voteCount.toString()})",
            style: const TextStyle(
              fontSize: size14,
              color: kBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
