import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String>? onSubmitted;
  final String initialValue;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onClear,
    this.onSubmitted,
    this.initialValue = '',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _hasText = widget.initialValue.isNotEmpty;
  }

  @override
  void didUpdateWidget(covariant SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
      setState(() {
        _hasText = widget.initialValue.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F2942),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.secondary,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              style: AppTypography.bodyLarge(
                color: AppColors.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search city name...',
                hintStyle: AppTypography.bodyLarge(
                  color: AppColors.outline,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (val) {
                setState(() {
                  _hasText = val.isNotEmpty;
                });
                widget.onChanged(val);
              },
              onSubmitted: widget.onSubmitted,
            ),
          ),
          if (_hasText)
            IconButton(
              icon: const Icon(Icons.close, size: 20, color: AppColors.onSurfaceVariant),
              splashRadius: 18,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () {
                _controller.clear();
                setState(() {
                  _hasText = false;
                });
                widget.onClear();
              },
            ),
        ],
      ),
    );
  }
}
