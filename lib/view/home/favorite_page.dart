// ignore_for_file: use_build_context_synchronously

import 'package:tmdb/utils/imports.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    super.key,
  });
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<TopRatedModel> favoriteList = [];
  bool isLoading = false;
  double total = 0;
  @override
  void initState() {
    super.initState();
    getCartData();
  }

  Future<void> getCartData() async {
    _changeLoading(true);
    final db = LocalDatabase();
    favoriteList = await db.getFavorite();
    _changeLoading(false);
  }

  _changeLoading(bool loading) {
    isLoading = loading;
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: favoriteList.isNotEmpty ? Colors.grey[300] : kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: const IconThemeData(color: kBlackColor),
        title: const Text('My Favorite'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: kBlackColor,
        ),
      ),
      body: Stack(
        children: [
          if (favoriteList.isEmpty)
            const Center(
              child: Text(
                "You have not added any \nfavorite yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size14,
                  color: kHintColor,
                ),
              ),
            ),
          if (favoriteList.isNotEmpty)
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) {
                      return itemView(index);
                    },
                  ),
                ),
              ],
            ),
          if (isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  Widget itemView(int index) {
    return FavoriteWidget(
      imageUrl: favoriteList[index].posterPath ?? "",
      name: favoriteList[index].title ?? "",
      category: favoriteList[index].releaseDate ?? "",
      price: favoriteList[index].popularity.toString(),
      desc: favoriteList[index].overview ?? "",
      rating: favoriteList[index].voteAverage.toString(),
      onTap: () {
        if (favoriteList[index].id != null) {
          Helper.launchInBrowser(favoriteList[index].id.toString());
        }
      },
      onRemoveTap: () async {
        List<TopRatedModel> list = [];
        list.addAll(favoriteList);
        list.remove(favoriteList[index]);
        final db = LocalDatabase();

        bool status = await db.addToFavorite(list);
        if (status) {
          favoriteList.remove(favoriteList[index]);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(mRemovetoFavorite)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(mFailedtoRemoveFavorite)),
          );
        }
        _notify();
      },
    );
  }
}
