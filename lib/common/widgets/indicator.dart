import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const String buildingImageUrl =
    'https://images.unsplash.com/photo-1616263676018-e558e270427a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80';

class MyPageViewWithIndicators extends StatelessWidget {
  const MyPageViewWithIndicators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myContent = [
      Image.network(
        buildingImageUrl,
        fit: BoxFit.cover,
      ),
      const Center(
        child: Text(
          'Any content can go here!',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const Center(
        child: Text(
          'Yep, even here...',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const Center(
        child: Text(
          'Still going...',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const Center(
        child: Text(
          'Is anyone reading this?',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('With dotted indicators', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Container(
            // Our PageViewWithIndicators will expand to fill available space. Give it a container specifying your size!
            height: 200,
            color: Colors.black,
            child: PageViewWithIndicators(
              children: myContent,
            ),
          ),
          const SizedBox(height: 64),
          const Text('With numbered indicators',
              style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Container(
            height: 200,
            color: Colors.black,
            child: PageViewWithIndicators(
              type: IndicatorType.numbered,
              children:
              myContent, // Indicators are numbered in the bottom right instead of dots.
            ),
          )
        ],
      ),
    );
  }
}

enum IndicatorType { dots, numbered }

class PageViewWithIndicators extends StatefulWidget {
  const PageViewWithIndicators(
      {required this.children,
        this.dotColor = Colors.white,
        this.type = IndicatorType.dots,
        this.pageController,
        this.onPageChanged,
        Key? key})
      : super(key: key);

  final List<Widget> children;
  final Color dotColor;
  final IndicatorType type;
  final Function(int)? onPageChanged;
  final PageController? pageController;

  @override
  State<PageViewWithIndicators> createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  late int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  _buildDottedIndicators() {
    List<Widget> dots = [];
    const double radius = 8;

    for (int i = 0; i < widget.children.length; i++) {
      dots.add(
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == activeIndex
                ? widget.dotColor
                : widget.dotColor.withOpacity(.6),
          ),
        ),
      );
    }
    dots = intersperse(const SizedBox(width: 6), dots)
        .toList(); // Add spacing between dots

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ),
    );
  }

  _buildNumberedIndicators() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.33),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            '${(activeIndex + 1).toString()} / ${widget.children.length.toString()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          scrollBehavior:
          ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          onPageChanged: (value) {
            setActiveIndex(value);
            widget.onPageChanged!(value);
          },
          controller: widget.pageController,
          children: widget.children,
        ),
        widget.type == IndicatorType.dots
            ? _buildDottedIndicators()
            : _buildNumberedIndicators(),
      ],
    );
  }
}

// Util

// Copied from https://github.com/modulovalue/dart_intersperse/blob/master/lib/src/intersperse.dart
/// Puts [element] between every element in [list].
Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}