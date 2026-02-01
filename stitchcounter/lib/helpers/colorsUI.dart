import 'package:flutter/material.dart';
import 'package:stitchcounter/services/theme.dart';

class ColorHelperScreen extends StatelessWidget {
  const ColorHelperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    
    // Get all colors from the color scheme
    final colors = [
      _ColorInfo('Primary', colorScheme.primary, colorScheme.onPrimary),
      _ColorInfo('Primary Container', colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
      _ColorInfo('Secondary', colorScheme.secondary, colorScheme.onSecondary),
      _ColorInfo('Secondary Container', colorScheme.secondaryContainer, colorScheme.onSecondaryContainer),
      _ColorInfo('Tertiary', colorScheme.tertiary, colorScheme.onTertiary),
      _ColorInfo('Tertiary Container', colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer),
      _ColorInfo('Surface', colorScheme.surface, colorScheme.onSurface),
      _ColorInfo('Surface Variant', colorScheme.surfaceVariant, colorScheme.onSurfaceVariant),
      _ColorInfo('Background', colorScheme.background, colorScheme.onBackground),
      _ColorInfo('Error', colorScheme.error, colorScheme.onError),
      _ColorInfo('Error Container', colorScheme.errorContainer, colorScheme.onErrorContainer),
      _ColorInfo('Outline', colorScheme.outline, colorScheme.onSurface),
      _ColorInfo('Outline Variant', colorScheme.outlineVariant, colorScheme.onSurface),
      _ColorInfo('Shadow', colorScheme.shadow, Colors.white),
      _ColorInfo('Scrim', colorScheme.scrim, Colors.white),
      _ColorInfo('Inverse Surface', colorScheme.inverseSurface, colorScheme.onInverseSurface),
      _ColorInfo('Inverse Primary', colorScheme.inversePrimary, colorScheme.onPrimaryContainer),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Scheme Helper'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Container(
        color: colorScheme.background,
        child: Column(
          children: [
            // Theme info header
            Container(
              padding: const EdgeInsets.all(16),
              color: colorScheme.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme Mode: ${brightness.name.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Seed Color: ${_colorToHex(AppTheme.forestGreen)}',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.forestGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Colors grid
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final colorInfo = colors[index];
                  return _ColorCard(colorInfo: colorInfo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorInfo {
  final String name;
  final Color color;
  final Color onColor;
  
  _ColorInfo(this.name, this.color, this.onColor);
}

class _ColorCard extends StatelessWidget {
  final _ColorInfo colorInfo;
  
  const _ColorCard({required this.colorInfo});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      color: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Color preview section
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorInfo.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    colorInfo.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorInfo.onColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _colorToHex(colorInfo.color),
                    style: TextStyle(
                      fontSize: 12,
                      color: colorInfo.onColor.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Info section
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RGB values
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ColorDetailRow(
                      label: 'RGB',
                      value: '${colorInfo.color.red}, ${colorInfo.color.green}, ${colorInfo.color.blue}',
                    ),
                    const SizedBox(height: 4),
                    _ColorDetailRow(
                      label: 'Opacity',
                      value: '${(colorInfo.color.opacity * 100).toStringAsFixed(1)}%',
                    ),
                  ],
                ),
                
                // Color swatches
                Row(
                  children: [
                    // Main color
                    _ColorSwatch(
                      color: colorInfo.color,
                      size: 24,
                      borderColor: colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    
                    // Lighter variant
                    _ColorSwatch(
                      color: colorInfo.color.withOpacity(0.7),
                      size: 24,
                      borderColor: colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    
                    // Darker variant
                    _ColorSwatch(
                      color: colorInfo.color.withOpacity(0.4),
                      size: 24,
                      borderColor: colorScheme.outline,
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
}

class _ColorDetailRow extends StatelessWidget {
  final String label;
  final String value;
  
  const _ColorDetailRow({
    required this.label,
    required this.value,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final double size;
  final Color borderColor;
  
  const _ColorSwatch({
    required this.color,
    required this.size,
    required this.borderColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
    );
  }
}

String _colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}