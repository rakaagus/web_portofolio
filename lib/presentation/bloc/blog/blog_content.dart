import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/widget/empty_data_widget.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BlogItem {
  final String title;
  final String date;
  final String category;
  final String description;
  final List<String> tags;
  final String slug;

  BlogItem({
    required this.title,
    required this.date,
    required this.category,
    required this.description,
    required this.tags,
    required this.slug,
  });
}

class BlogContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;
  const BlogContent({
    super.key,
    required this.scrollController,
    required this.onNavigate
  });

  @override
  State<BlogContent> createState() => _BlogContentState();
}

class _BlogContentState extends State<BlogContent> {
  final List<BlogItem> blogs = [

  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height; // Mengambil tinggi layar aktif
    final isMobile = screenWidth < 650;
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        // 1. Background Mesh Gradient
        const Positioned.fill(
          child: MeshGradientBackground(style: 3),
        ),

        // 2. Main Scrollable Content
        SingleChildScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            // Memaksa tinggi minimal kontainer setinggi layar browser/desktop
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Otomatis dorong Footer ke bawah
              children: [
                // --- KONTEN ATAS & MIDDLE ---
                Padding(
                  padding: EdgeInsets.only(
                    top: isMobile ? 80 : 120,
                    bottom: 60,
                    left: isMobile ? 24 : screenWidth * 0.1,
                    right: isMobile ? 24 : screenWidth * 0.1,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title Screen
                          Text(
                            l10n.postTitle,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : 40,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),

                          // Deskripsi Title
                          Text(
                            l10n.postSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 48),

                          if (blogs.isEmpty)
                            EmptyDataCardWidget(
                              title: l10n.emptyData(l10n.footerLinkBlogs),
                              description: l10n.emptyBlogSub,
                              isHaveButton: false,
                              iconTitle: "",
                              onPressButton: () {},
                            )
                          else
                            Column(
                              children: blogs.map((blog) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _buildBlogCard(context, colorScheme, blog),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- GLOBAL FOOTER ---
                GlobalFooter(
                  onNavigate: (String url) {
                    widget.onNavigate(url);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget Card Item Blog
  Widget _buildBlogCard(BuildContext context, ColorScheme colorScheme, BlogItem blog) {
    return HoverSolidCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category, Date & Arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${blog.category} • ${blog.date}",
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            blog.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              height: 1.3,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),

          // Description Excerpt
          Text(
            blog.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
              height: 1.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),

          // Tag Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: blog.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.onSurface.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
