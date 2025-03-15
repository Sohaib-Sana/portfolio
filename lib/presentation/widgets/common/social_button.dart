import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';

class SocialButton extends StatefulWidget {
  final SocialPlatform platform;
  final String? url;
  final VoidCallback? onTap;
  final double size;
  final Color? color;
  final Color? hoverColor;
  final bool showBackground;

  const SocialButton({
    Key? key,
    required this.platform,
    this.url,
    this.onTap,
    this.size = 24,
    this.color,
    this.hoverColor,
    this.showBackground = true,
  }) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.onBackground;
    final hoverColor = widget.hoverColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap ??
            (widget.url != null ? () => _launchURL(widget.url!) : null),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: widget.showBackground
                ? (_isHovered
                    ? hoverColor.withOpacity(0.1)
                    : Colors.transparent)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: FaIcon(
            _getIconForPlatform(widget.platform),
            size: widget.size,
            color: _isHovered ? hoverColor : color,
          ),
        ),
      ),
    );
  }

  IconData _getIconForPlatform(SocialPlatform platform) {
    switch (platform) {
      case SocialPlatform.github:
        return FontAwesomeIcons.github;
      case SocialPlatform.linkedin:
        return FontAwesomeIcons.linkedin;
      case SocialPlatform.facebook:
        return FontAwesomeIcons.facebook;
      case SocialPlatform.twitter:
        return FontAwesomeIcons.twitter;
      case SocialPlatform.instagram:
        return FontAwesomeIcons.instagram;
      case SocialPlatform.email:
        return Icons.email;
      case SocialPlatform.whatsapp:
        return FontAwesomeIcons.whatsapp;
      case SocialPlatform.telegram:
        return FontAwesomeIcons.telegram;
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle error
      debugPrint('Could not launch $url');
    }
  }
}

enum SocialPlatform {
  github,
  linkedin,
  facebook,
  twitter,
  instagram,
  email,
  whatsapp,
  telegram,
}
