// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb/utils/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFn = FocusNode();

  List<TopRatedModel> favoriteListData = [];
  List<TopRatedModel> topRatedListData = [];
  List<TrendingResultsModel> trendingListData = [];
  bool isLoading = false;

  @override
  void initState() {
    getFavoriteData();
    getTrendingListAPi();
    getTopRatedMovieListAPi();

    super.initState();
  }

  Future<void> getFavoriteData() async {
    final db = LocalDatabase();
    favoriteListData = await db.getFavorite();
    _notify();
  }

  Future getTrendingListAPi() async {
    final respo = ProductRepository();
    if (await Helper.checkInternet()) {
      _changeLoading(true);
      TrendingResponse? res = await respo.getCategories();

      if (res != null && res.results != null && res.results!.isNotEmpty) {
        trendingListData.addAll(res.results!);
      }
      log("List ${trendingListData.length.toString()}");
    } else {
      Helper.toast(context: context, text: 'No Internet');
    }
    _changeLoading(false);
  }

  Future<void> getTopRatedMovieListAPi() async {
    final respo = ProductRepository();
    if (await Helper.checkInternet()) {
      _changeLoading(true);
      TopRatedResponse? res = await respo.getTopRatedMovie();

      if (res != null && res.results != null && res.results!.isNotEmpty) {
        topRatedListData.addAll(res.results!);
      }
      log("List ${trendingListData.length.toString()}");
    } else {
      Helper.toast(context: context, text: 'No Internet');
    }
    _changeLoading(false);
  }

  Future<void> getSearchListAPi(String search) async {
    isLoading = false;
    topRatedListData.clear();
    final respo = ProductRepository();
    if (await Helper.checkInternet()) {
      _changeLoading(true);
      TopRatedResponse? res = await respo.getSearchMovie(search);

      if (res != null && res.results != null && res.results!.isNotEmpty) {
        topRatedListData.addAll(res.results!);
      }
      log("List ${trendingListData.length.toString()}");
      _changeLoading(false);
    } else {
      Helper.toast(context: context, text: 'No Internet');
    }
  }

  _refresh() {
    searchController.clear();
    searchFn.unfocus();
    favoriteListData.clear();
    trendingListData.clear();
    topRatedListData.clear();
    isLoading = false;
    getFavoriteData();
    getTrendingListAPi();
    getTopRatedMovieListAPi();
  }

  _refreshList() {
    searchController.clear();
    searchFn.unfocus();
    isLoading = false;
    topRatedListData.clear();
    getTopRatedMovieListAPi();
  }

  _changeLoading(bool loading) {
    isLoading = loading;
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kWhiteColor,
      drawer: const MyDrawerComponent(),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: const IconThemeData(color: kBlackColor),
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            text: 'TMDB',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
            ),
            children: [
              TextSpan(
                text: 'Movies',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
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
              favoriteListData.isEmpty ? Icons.favorite_border : Icons.favorite,
              color: kErrorColor,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CarouselSlider(
                options: CarouselOptions(
                  height: 210,
                  // viewportFraction: 0.2,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,

                  autoPlayInterval: const Duration(seconds: 10),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,

                  // enlargeFactor: 0.4,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
                items: trendingListData.map((i) {
                  return GestureDetector(
                    onTap: () {
                      if (i.id != null) {
                        Helper.launchInBrowser(i.id.toString());
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(kCardBorderRadius),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(kCardBorderRadius),
                            child: ImageWidget(
                              imageUrl: i.posterPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (i.originalTitle != null)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 60,
                                bottom: 12,
                                top: 12,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: kDeepOrangeColor.withOpacity(0.2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(kCardBorderRadius),
                                  bottomRight:
                                      Radius.circular(kCardBorderRadius),
                                ),
                              ),
                              child: Text(
                                i.originalTitle ?? "",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: size14,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          right: 30,
                          child: Container(
                            width: 60,
                            height: 90,
                            decoration: BoxDecoration(
                              // color: kDeepOrangeColor,
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              child: ImageWidget(
                                imageUrl: i.posterPath,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SearchWidget(
                controller: searchController,
                focusNode: searchFn,
                label: 'Search movies Ex. Wednesday... ',
                suffixIcon: searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _refreshList();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: kBlackColor,
                        ),
                      )
                    : const SizedBox(),
                onSubmitted: (val) {
                  if (val != '') {
                    getSearchListAPi(val.trim());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  searchController.text.trim().isEmpty
                      ? 'Top Rated Movies'
                      : searchController.text.trim().isNotEmpty &&
                              topRatedListData.isNotEmpty
                          ? 'Search : ${searchController.text}'
                          : searchController.text.trim().isNotEmpty &&
                                  topRatedListData.isEmpty
                              ? "Search : No Result found "
                              : "",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: size14,
                    color: kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  _refreshList();
                },
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: topRatedListData.length,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return MovieWidget(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => MovieDetailPage(
                              topRatedModel: topRatedListData[index],
                            ),
                          ),
                        );
                        _refresh();
                      },
                      onCartTap: () async {
                        if (favoriteListData
                            .any((e) => e.id == topRatedListData[index].id)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(mAlreadyAddtoCart)),
                          );
                        } else {
                          favoriteListData.add(topRatedListData[index]);
                          final db = LocalDatabase();

                          bool status =
                              await db.addToFavorite(favoriteListData);
                          if (status) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(mAddtoCart)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(mFailedtoCart)),
                            );
                          }
                        }
                        _notify();
                      },
                      imageUrl: topRatedListData[index].posterPath,
                      name:
                          topRatedListData[index].title ?? "Name not availble",
                      category: topRatedListData[index].releaseDate ??
                          "Release date not availble",
                      price: topRatedListData[index].popularity.toString(),
                      added: favoriteListData
                          .any((e) => e.id == topRatedListData[index].id),
                      rating: topRatedListData[index].voteAverage.toString(),
                    );
                  },
                ),
              )),
            ],
          ),
          if (isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
