import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'novelViewProvider.dart';

class NovelView extends StatefulWidget {
  const NovelView({Key? key}) : super(key: key);

  @override
  State<NovelView> createState() => _NovelViewState();
}

class _NovelViewState extends State<NovelView> {
  late NovelViewProvider novelViewProvider;
  late PageController pageController;
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;
  String? dropdownvalue = '9';
  @override
  void initState() {
    super.initState();
    novelViewProvider = Provider.of<NovelViewProvider>(context, listen: false);
    pageController = PageController(initialPage: 0);
    novelViewProvider.generatePagesList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Novel'),
      ),
      body: GestureDetector(
        onDoubleTapDown: _handleDoubleTapDown,
        onDoubleTap: _handleDoubleTap,
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    dropdownvalue = (value + 9).toString();
                  });
                },
                itemCount: novelViewProvider.pages.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Image.asset('assets/pages/page${index + 9}.png');
                }),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.redAccent,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropdownvalue,
                menuMaxHeight: size.height * .4,
                iconEnabledColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                style: const TextStyle(color: Colors.white, fontSize: 20),
                dropdownColor: Colors.redAccent,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: novelViewProvider.pages.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Page No: $items',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  pageController.jumpToPage(
                    int.parse(dropdownvalue!) - 9,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;

      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * .5, -position.dy * .5)
        ..scale(1.5);
    }
  }
}
