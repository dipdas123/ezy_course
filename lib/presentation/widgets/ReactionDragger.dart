import 'package:audioplayers/audioplayers.dart';
import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/utils/audio_constants.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../utils/asset_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';
import 'common_widgets.dart';

class Reaction {
  final String id;
  final String name;
  final AssetImage icon;

  Reaction({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class ReactionButton extends StatefulWidget {
  final Function(Reaction) onReactionSelected;
  final bool isReacted;
  final Feed? feed;

  const ReactionButton({
    super.key,
    required this.onReactionSelected,
    this.isReacted = false,
    this.feed,
  });

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _showReactions = false;
  double _dragOffset = 0.0;
  int? _hoveredReactionIndex;

  // Constants for drag calculations
  final double _reactionWidth = 41.0; // 25 (icon) + 16 (padding)
  final double _maxDragOffset = 246.0; // 41 * 6 (total width of reactions)


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showReactionsOnLongPressList(LongPressStartDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    HapticFeedback.lightImpact();
    playReactionSoundOnLongPress();
    setState(() {
      _showReactions = true;
      _dragOffset = 0.0;
      _controller.forward();
    });
  }

  void _hideReactionsList() {
    // playReactionSoundOnFingerDown();
    setState(() {
      _showReactions = false;
      _dragOffset = 0.0;
      _hoveredReactionIndex = null;
      _controller.reverse();
    });
  }

  void _handleDragUpdate(LongPressMoveUpdateDetails details) {
    if (!_showReactions) return;
    setState(() {
      _dragOffset += details.offsetFromOrigin.dx * 0.05;
      _dragOffset = _dragOffset.clamp(-_maxDragOffset, 0);

      int hoveredIndex = (-_dragOffset / _reactionWidth).floor();
      hoveredIndex = hoveredIndex.clamp(0, reactionsList.length - 1);
      _hoveredReactionIndex = hoveredIndex;
    });
  }

  void _handleDragEnd(LongPressEndDetails details) {
    playReactionSoundOnFingerDown();
    if (_hoveredReactionIndex != null) {
      _handleReactionSelected(reactionsList[_hoveredReactionIndex!]);
    }
    _hideReactionsList();
  }

  void _handleReactionSelected(Reaction reaction) {
    HapticFeedback.lightImpact();
    if (widget.feed?.likeTypeList?.any((reaction) => reaction.reactionType == widget.feed?.like?.reactionType) == false) {
      playReactionSoundOnlyLike();
    } else {

    }
    _hideReactionsList();
    widget.onReactionSelected(reaction);
    print("Reaction selected: ${reaction.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: _showReactionsOnLongPressList,
          onLongPressMoveUpdate: _handleDragUpdate,
          onLongPressEnd: _handleDragEnd,
          onTap: () {
            if (!_showReactions) {
              _handleReactionSelected(reactionsList[0]);
            }
          },
          child: Row(
            children: [

              widget.feed?.likeTypeList?.any((reaction) => reaction.feedId == widget.feed?.like?.feedId) ?? false
                  ?
              Image(
                image: getReaction(widget.feed?.like?.reactionType ?? ""),
                width: getProportionateScreenWidth(25),
                height: getProportionateScreenHeight(35),
                fit: BoxFit.contain,
              )
                  :
              Container(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenHeight(30),
                padding: const EdgeInsets.only(right: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.isReacted ? reactionsList[0].icon : AssetImage(AssetConfig.like_unclicked),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Text(widget.isReacted ? StringConfig.liked : StringConfig.like,
                style: textSize14w500.copyWith(color: widget.isReacted ? Theme.of(context).primaryColor : ColorConfig.greyColor),
              ),
            ],
          )
        ),

        if (_showReactions)
          Positioned(
            bottom: 35,
            left: 10,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Transform.translate(
                    offset: Offset(_dragOffset, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: reactionsList.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final Reaction reaction = entry.value;
                          final bool isHovered = index == _hoveredReactionIndex;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            transform: Matrix4.identity()..scale(isHovered ? 1.5 : 1.0),
                            child: Image(
                              image: reaction.icon,
                              width: getProportionateScreenWidth(25),
                              height: getProportionateScreenHeight(35),
                              fit: BoxFit.contain,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}