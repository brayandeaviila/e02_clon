import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const ExplorarApp());

// ---------------------------------------------------------------------------
// TOKENS - Medidas de espacio y radio de bordes
// (dadas por el profesor en el curso)
// ---------------------------------------------------------------------------
class Space {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppRadius {
  static const double sm = 8;
  static const double md = 14;
  static const double pill = 999;
}

// ---------------------------------------------------------------------------
// APP + TEMA
// ---------------------------------------------------------------------------
class ExplorarApp extends StatelessWidget {
  const ExplorarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = const ColorScheme.dark(
      surface: Color(0xFF000000),
      surfaceContainerHighest: Color(0xFF1C1C1E),
      primary: Color(0xFFE10E1A),
      secondary: Color(0xFF3B82F6), // azul de los precios
      tertiary: Color(0xFFF5A623), // naranja "GRATIS"
      outline: Color(0xFF2A2A2C),
      onSurface: Colors.white,
      onSurfaceVariant: Color(0xFF9A9A9E),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
        splashFactory: NoSplash.splashFactory,
      ),
      home: const ExplorarScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// DATOS de ejemplo
// ---------------------------------------------------------------------------
class ProductoDemo {
  final String imagen;
  final bool gratis;
  final String precio;
  final String tag; // 'ANUNCIO' o vacío
  final String titulo;
  final String autor;
  final bool verificado;

  const ProductoDemo({
    required this.imagen,
    required this.gratis,
    required this.precio,
    this.tag = '',
    required this.titulo,
    required this.autor,
    this.verificado = false,
  });
}

const nuevosDestacables = [
  ProductoDemo(
    imagen: 'assets/images/cover1.png',
    gratis: true,
    precio: 'COP\$ 95.000',
    tag: 'ANUNCIO',
    titulo: '\'Afrodita\' RnB ambient type beat',
    autor: 'klauzinho',
  ),
  ProductoDemo(
    imagen: 'assets/images/cover2.png',
    gratis: true,
    precio: 'COP\$ 120.000',
    titulo: '\'Moneyyy\' Trap Drill UK TYPE BEAT',
    autor: 'g4ngSTAR',
  ),
  ProductoDemo(
    imagen: 'assets/images/cover3.png',
    gratis: true,
    precio: 'COP\$ 95.000',
    titulo: 'LAST RIDE - H1p H0p Type Beat',
    autor: 'imNotLilNasX',
  ),
];

const masPopulares = [
  ProductoDemo(
    imagen: 'assets/images/cover4.png',
    gratis: true,
    precio: 'COP\$ 320.000',
    tag: 'ANUNCIO',
    titulo: '\'RIDIN\' - Travis Scott Type Beat',
    autor: 'g4ngSTAR',
  ),
  ProductoDemo(
    imagen: 'assets/images/cover5.png',
    gratis: false,
    precio: 'COP\$ 95.000',
    titulo: 'HYPERPOP \'SUGAR RUSH\' TYPE BEAT',
    autor: 'APOLLO',
  ),
  ProductoDemo(
    imagen: 'assets/images/cover6.png',
    gratis: false,
    precio: 'COP\$ 120.000',
    titulo: '\'Aoi Bara\' - Feid Reggaeton Type Beat 2026',
    autor: 'Brayan De Aviila',
    verificado: true,
  ),
];

// ---------------------------------------------------------------------------
// PANTALLA
// ---------------------------------------------------------------------------
class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            const _SearchBar(),
            const SizedBox(height: Space.lg),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: Space.lg),
                children: const [
                  _SectionHeader(title: 'Nuevos y destacables'),
                  SizedBox(height: Space.md),
                  _HorizontalProductList(productos: nuevosDestacables),
                  SizedBox(height: Space.xl),
                  _SectionHeader(title: 'Más populares'),
                  SizedBox(height: Space.md),
                  _HorizontalProductList(productos: masPopulares),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP BAR
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(Space.md, Space.sm, Space.md, Space.md),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 32, height: 32),
          const Spacer(),
          Text('Explorar', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          Icon(Icons.notifications_none, color: theme.colorScheme.onSurface, size: 26),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BARRA DE BÚSQUEDA
// ---------------------------------------------------------------------------
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.md),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.sm),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: Space.sm),
            Text('¿Qué estás buscando?', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ENCABEZADO DE SECCIÓN
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              Text('Buscar', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary)),
            ],
          ),
        ),
        const SizedBox(height: Space.sm),
        Container(
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: Space.md),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF3B82F6)]),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// LISTA HORIZONTAL — ListView.builder, como pide la regla del curso
// ---------------------------------------------------------------------------
class _HorizontalProductList extends StatelessWidget {
  final List<ProductoDemo> productos;
  const _HorizontalProductList({required this.productos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Space.md),
        itemCount: productos.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(right: Space.md),
          child: _ProductCard(producto: productos[i]),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TARJETA DE PRODUCTO
// ---------------------------------------------------------------------------
class _ProductCard extends StatelessWidget {
  final ProductoDemo producto;
  const _ProductCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductCover(imagen: producto.imagen),
          const SizedBox(height: Space.sm),
          _ProductPriceRow(producto: producto),
          const SizedBox(height: Space.xs),
          _ProductTitleRow(producto: producto),
          _ProductAuthor(producto: producto),
        ],
      ),
    );
  }
}

class _ProductCover extends StatelessWidget {
  final String imagen;
  const _ProductCover({required this.imagen});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(imagen, fit: BoxFit.cover),
      ),
    );
  }
}

class _ProductPriceRow extends StatelessWidget {
  final ProductoDemo producto;
  const _ProductPriceRow({required this.producto});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: Space.xs,
      runSpacing: Space.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (producto.gratis)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Space.sm, vertical: 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiary,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('GRATIS', style: theme.textTheme.labelSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.w700)),
                const Icon(Icons.file_download_outlined, size: 12, color: Colors.black),
              ],
            ),
          ),
        Text(producto.precio, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _ProductTitleRow extends StatelessWidget {
  final ProductoDemo producto;
  const _ProductTitleRow({required this.producto});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (producto.tag.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Space.xs, vertical: 1),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(producto.tag, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
          const SizedBox(width: Space.xs),
        ],
        Expanded(
          child: Text(
            producto.titulo,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ProductAuthor extends StatelessWidget {
  final ProductoDemo producto;
  const _ProductAuthor({required this.producto});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(producto.autor, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        if (producto.verificado) ...[
          const SizedBox(width: Space.xs),
          Icon(Icons.verified, size: 13, color: theme.colorScheme.secondary),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// BARRA INFERIOR — custom, no BottomNavigationBar de Material
// ---------------------------------------------------------------------------
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Space.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.play_circle_outline, color: theme.colorScheme.onSurfaceVariant),
            _ActiveNavIcon(icon: Icons.search),
            Icon(Icons.shopping_bag_outlined, color: theme.colorScheme.onSurfaceVariant),
            Icon(Icons.favorite_border, color: theme.colorScheme.onSurfaceVariant),
            Icon(Icons.menu, color: theme.colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _ActiveNavIcon extends StatelessWidget {
  final IconData icon;
  const _ActiveNavIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(Space.sm),
      decoration: BoxDecoration(color: theme.colorScheme.onSurface, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.black, size: 20),
    );
  }
}