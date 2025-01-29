// reaction_button.dart
import 'package:flutter/material.dart';

import '../../utils/asset_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';

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

  const ReactionButton({
    Key? key,
    required this.onReactionSelected,
    this.isReacted = false,
  }) : super(key: key);

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _showReactions = false;
  int? _selectedReactionIndex;

  final List<Reaction> reactions = [
    Reaction(
      id: 'like',
      name: 'Like',
      icon: AssetImage(AssetConfig.like_icon),
    ),
    Reaction(
      id: 'love',
      name: 'Love',
      icon: AssetImage(AssetConfig.love_icon),
    ),
    Reaction(
      id: 'haha',
      name: 'Haha',
      icon: AssetImage(AssetConfig.haha_icon),
    ),
    // Add more reactions as needed
  ];

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

  void _toggleReactions() {
    setState(() {
      _showReactions = !_showReactions;
      if (_showReactions) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleReactionSelected(Reaction reaction) {
    widget.onReactionSelected(reaction);
    _toggleReactions();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleReactions,
      onTapDown: (_) => _toggleReactions(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Container(
                width: getProportionateScreenWidth(22),
                height: getProportionateScreenHeight(22),
                padding: const EdgeInsets.only(right: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.isReacted
                        ? reactions[0].icon
                        : AssetImage(AssetConfig.like_icon),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                StringConfig.like,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.isReacted
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              ),
            ],
          ),
          if (_showReactions)
            Positioned(
              bottom: 40,
              left: -16,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: reactions.map((reaction) {
                        return GestureDetector(
                          onTap: () => _handleReactionSelected(reaction),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image(
                              image: reaction.icon,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}