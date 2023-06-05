import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/consts/lists.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: Colors.grey[100],
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                ),
              ),
            ),
            Expanded(
              child: VxSwiper.builder(
                autoPlay: true,
                height: 220,
                enlargeCenterPage: true,
                itemCount: slidersList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    slidersList[index],
                    fit: BoxFit.fill,
                  )
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .make();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
