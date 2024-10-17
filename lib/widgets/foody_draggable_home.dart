library draggable_home;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyDraggableHome extends HookWidget {
  /// Leading: A widget to display before the toolbar's title.
  final Widget? leading;

  /// Title: A Widget to display title in AppBar
  final Widget title;

  /// Center Title: Allows toggling of title from the center. By default title is in the center.
  final bool centerTitle;

  /// Action: A list of Widgets to display in a row after the title
  final List<Widget>? actions;

  /// Always Show Leading And Action : This make Leading and Action always visible. Default value is false.
  final bool alwaysShowLeadingAndAction;

  /// Always Show Title : This make Title always visible. Default value is false.
  final bool alwaysShowTitle;

  /// Drawer: Drawers are typically used with the Scaffold.drawer property.
  final Widget? drawer;

  /// Header Expanded Height : Height of the header  The height is a double between 0.0 and 1.0. The default value of height is 0.35 and should be less than stretchMaxHeigh
  final double headerExpandedHeight;

  /// Header Widget: A widget to display Header above body.
  final Widget headerWidget;

  /// backgroundColor: The color of the Material widget that underlies the entire DraggableHome body.
  final Color? backgroundColor;

  /// appBarColor: The color of the scaffold app bar.
  final Color? appBarColor;

  /// curvedBodyRadius: Creates a border top left and top right radius of body, Default radius of the body is 20.0. For no radius simply set value to 0.
  final double curvedBodyRadius;

  /// body: A widget to Body
  final List<Widget> body;

  /// stretchTriggerOffset: The offset of overscroll required to fully expand the header.
  final double stretchTriggerOffset;

  /// expandedBody: A widget to display when fully expanded as header or expandedBody above body.
  final Widget? expandedBody;

  /// stretchMaxHeight: Height of the expandedBody  The height is a double between 0.0 and 0.95. The default value of height is 0.9 and should be greater than headerExpandedHeight
  final double stretchMaxHeight;

  /// bottomSheet: A persistent bottom sheet shows information that supplements the primary content of the app. A persistent bottom sheet remains visible even when the user interacts with other parts of the app.
  final Widget? bottomSheet;

  /// physics: How the scroll view should respond to user input. For example, determines how the scroll view continues to animate after the user stops dragging the scroll view.
  final ScrollPhysics? physics;

  /// scrollController: An object that can be used to control the position to which this scroll view is scrolled.
  final ScrollController? scrollController;

  final bool startWithExpandedBody;

  /// This will create DraggableHome.
  const FoodyDraggableHome({
    super.key,
    this.leading,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.alwaysShowLeadingAndAction = false,
    this.alwaysShowTitle = false,
    this.headerExpandedHeight = 0.35,
    required this.headerWidget,
    this.backgroundColor,
    this.appBarColor,
    this.curvedBodyRadius = 20,
    required this.body,
    this.drawer,
    this.stretchTriggerOffset = 200,
    this.expandedBody,
    this.stretchMaxHeight = 0.8,
    this.bottomSheet,
    this.physics,
    this.scrollController,
    this.startWithExpandedBody = false,
  })  : assert(headerExpandedHeight > 0.0 &&
            headerExpandedHeight < stretchMaxHeight),
        assert((stretchMaxHeight > headerExpandedHeight) &&
            (stretchMaxHeight < .95));

  @override
  Widget build(BuildContext context) {
    final double appBarHeight =
        AppBar().preferredSize.height + curvedBodyRadius;

    final double topPadding = MediaQuery.of(context).padding.top;

    final double expandedHeight =
        MediaQuery.of(context).size.height * headerExpandedHeight;

    final double fullyExpandedHeight =
        MediaQuery.of(context).size.height * stretchMaxHeight;

    final isFullyExpanded = useState(false);
    final isFullyCollapsed = useState(false);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final animation = useListenable(
        Tween<double>(begin: expandedHeight, end: fullyExpandedHeight)
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
    )));

    useEffect(() {
      if(startWithExpandedBody) {
        isFullyExpanded.value = true;
        animationController.forward(from: 1);
      }
      return null;
    }, []);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.depth == 0 &&
            notification.metrics.axis == Axis.vertical) {
          // base -> expanded
          if (expandedBody != null &&
              !isFullyExpanded.value &&
              notification.metrics.pixels < -100) {
            isFullyExpanded.value = true;
            scrollController?.jumpTo(0);
            animationController.forward();
          }

          // expanded -> base
          else if (isFullyExpanded.value && notification.metrics.pixels > 100) {
            isFullyExpanded.value = false;
            scrollController?.jumpTo(0);
            animationController.reverse();
          }

          // base -> collapsed
          else if (animation.status.isDismissed) {
            final isCollapsed = notification.metrics.pixels >
                expandedHeight - AppBar().preferredSize.height - 21;

            if (isFullyCollapsed.value != isCollapsed) {
              isFullyCollapsed.value = isCollapsed;
            }
          }
        }
        return false;
      },
      child: CustomScrollView(
        physics: physics ?? const BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return SliverAppBar(
                scrolledUnderElevation: 0,
                backgroundColor: appBarColor,
                /*automaticallyImplyLeading:
                    isFullyCollapsed.value || isFullyExpanded.value,*/
                leading: alwaysShowLeadingAndAction
                    ? leading
                    : isFullyCollapsed.value || isFullyExpanded.value
                        ? leading
                        : const SizedBox.shrink(),
                actions: alwaysShowLeadingAndAction
                    ? actions
                    : isFullyCollapsed.value || isFullyExpanded.value
                        ? actions
                        : [],
                elevation: 0,
                pinned: true,
                stretch: true,
                centerTitle: centerTitle,
                title: alwaysShowTitle
                    ? title
                    : isFullyCollapsed.value
                        ? FadeInDown(
                            animate: true,
                            //opacity: fullyCollapsed ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: title,
                          )
                        : null,
                collapsedHeight: appBarHeight,
                expandedHeight: animation.value,
                flexibleSpace: Stack(
                  children: [
                    FlexibleSpaceBar(
                      background: Container(
                        child:
                            isFullyExpanded.value ? expandedBody : headerWidget,
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      left: 0,
                      right: 0,
                      child: roundedCorner(context),
                    ),
                  ],
                ),
              );
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height -
                          appBarHeight +
                          topPadding,
                      color: backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    Column(
                      children: [
                        if (expandedBody != null)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 25,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: isFullyExpanded.value
                                  ? IconButton(
                                      onPressed: () {
                                        isFullyExpanded.value = false;
                                        scrollController?.jumpTo(0);
                                        animationController.reverse();
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        PhosphorIconsRegular.caretUp,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        isFullyExpanded.value = true;
                                        scrollController?.jumpTo(0);
                                        animationController.forward();
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        PhosphorIconsRegular.caretDown,
                                      ),
                                    ),
                            ),
                          ),
                        ...body,
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container roundedCorner(BuildContext context) {
    return Container(
      height: curvedBodyRadius,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(curvedBodyRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
    );
  }
}
