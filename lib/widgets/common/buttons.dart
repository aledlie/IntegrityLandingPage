import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Primary gradient button with accessibility support
///
/// Features:
/// - Gradient background (blue to indigo)
/// - Loading state with spinner
/// - Disabled state with gray gradient
/// - Focus indicator for keyboard navigation
/// - Semantic label for screen readers
/// - Hover lift effect
///
/// Usage:
/// ```dart
/// GradientButton(
///   text: 'Start Free Trial',
///   onPressed: () => scrollTo('pricing'),
///   icon: LucideIcons.arrowRight,
/// )
/// ```
class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final String? semanticLabel;
  final bool fullWidth;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.semanticLabel,
    this.fullWidth = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.isLoading || widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: !_isDisabled,
      label: widget.semanticLabel ?? widget.text,
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _isDisabled ? null : widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: _isHovered && !_isDisabled
                  ? Matrix4.translationValues(0.0, -2.0, 0.0)
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                gradient: _isDisabled
                    ? AppColors.disabledGradient
                    : AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                boxShadow: _isDisabled
                    ? []
                    : [
                        BoxShadow(
                          color: AppColors.shadowBlue,
                          blurRadius: _isHovered ? 24 : 16,
                          offset: Offset(0, _isHovered ? 6 : 4),
                        ),
                      ],
                border: _isFocused
                    ? Border.all(color: AppColors.blue400, width: 2)
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isDisabled ? null : widget.onPressed,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  hoverColor: Colors.white.withValues(alpha: 0.1),
                  focusColor: Colors.white.withValues(alpha: 0.1),
                  child: Container(
                    width: widget.fullWidth ? double.infinity : null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      mainAxisSize:
                          widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else
                          Text(
                            widget.text,
                            style: AppTypography.buttonText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        if (widget.icon != null && !widget.isLoading) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Icon(
                            widget.icon,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Secondary outline button
///
/// Features:
/// - Transparent background with border
/// - Hover state with blue border
/// - Focus indicator
/// - Semantic accessibility
///
/// Usage:
/// ```dart
/// OutlineButton(
///   text: 'View Demo',
///   onPressed: () => openDemo(),
/// )
/// ```
class OutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final String? semanticLabel;
  final bool fullWidth;

  const OutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.semanticLabel,
    this.fullWidth = false,
  });

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.isLoading || widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: !_isDisabled,
      label: widget.semanticLabel ?? widget.text,
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _isDisabled ? null : widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: _isHovered && !_isDisabled
                    ? AppColors.gray800
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                border: Border.all(
                  color: _isFocused
                      ? AppColors.blue400
                      : _isHovered && !_isDisabled
                          ? AppColors.blue500
                          : AppColors.gray700,
                  width: _isFocused ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isDisabled ? null : widget.onPressed,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  hoverColor: Colors.transparent,
                  child: Container(
                    width: widget.fullWidth ? double.infinity : null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      mainAxisSize:
                          widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.textPrimary,
                              ),
                            ),
                          )
                        else
                          Text(
                            widget.text,
                            style: AppTypography.buttonText.copyWith(
                              color: _isDisabled
                                  ? AppColors.gray500
                                  : AppColors.textPrimary,
                            ),
                          ),
                        if (widget.icon != null && !widget.isLoading) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Icon(
                            widget.icon,
                            size: 20,
                            color: _isDisabled
                                ? AppColors.gray500
                                : AppColors.textPrimary,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Text button for inline actions
///
/// Usage:
/// ```dart
/// AppTextButton(
///   text: 'Learn more',
///   onPressed: () => navigateTo('/docs'),
/// )
/// ```
class AppTextButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool iconLeading;
  final String? semanticLabel;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconLeading = false,
    this.semanticLabel,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: widget.semanticLabel ?? widget.text,
      child: MouseRegion(
        cursor: isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null && widget.iconLeading) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: isDisabled ? AppColors.gray500 : AppColors.textLink,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                widget.text,
                style: AppTypography.link.copyWith(
                  color: isDisabled ? AppColors.gray500 : AppColors.textLink,
                  decoration:
                      _isHovered ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
              if (widget.icon != null && !widget.iconLeading) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  widget.icon,
                  size: 16,
                  color: isDisabled ? AppColors.gray500 : AppColors.textLink,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Icon button with tooltip
///
/// Usage:
/// ```dart
/// AppIconButton(
///   icon: LucideIcons.menu,
///   onPressed: () => openMenu(),
///   tooltip: 'Open menu',
/// )
/// ```
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? color;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      icon: Icon(
        icon,
        size: size,
        color: color ?? AppColors.textSecondary,
      ),
      onPressed: onPressed,
      hoverColor: AppColors.gray700,
      focusColor: AppColors.gray700,
      splashRadius: size,
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
