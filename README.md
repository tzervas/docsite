# DocSite - Documentation Site Generator (Rust)

A powerful documentation site generator written in Rust that creates beautiful, searchable, and maintainable documentation websites. Supports multiple documentation frameworks and provides automated deployment and hosting capabilities.

## Features

- **Multiple Frameworks**: MkDocs, Sphinx, Docusaurus, Hugo support
- **Automated Deployment**: GitHub Pages, Netlify, Vercel integration
- **Search Functionality**: Full-text search across documentation
- **Version Management**: Multi-version documentation support
- **Theme Customization**: Custom themes and branding
- **SEO Optimization**: Meta tags, sitemaps, structured data
- **Mobile Responsive**: Optimized for all device sizes
- **Rust Performance**: High-performance document processing and generation
- **WASM Support**: WebAssembly components for interactive features

## Architecture

DocSite is built with Rust for maximum performance and reliability:

- **Core Engine**: Rust-based document processing and site generation
- **WASM Components**: Interactive search and navigation components
- **Template Engine**: High-performance Tera template rendering
- **Asset Optimization**: Automatic image compression and optimization
- **Parallel Processing**: Concurrent document processing and rendering

## Quick Start

```bash
# Install DocSite
cargo install docsite

# Initialize a new documentation site
docsite init mkdocs --config docs/mkdocs.yaml

# Build and serve locally
docsite build
docsite serve --port 3000

# Deploy to GitHub Pages
docsite deploy --target gh-pages --cname docs.example.com
```

## Configuration Example

```yaml
# docsite.yaml
site:
  name: "Bootdisk Documentation"
  description: "Automated Debian workstation setup documentation"
  author: "Documentation Agent"
  url: "https://docs.bootdisk.dev"

  repository:
    url: "https://github.com/agentic/bootdisk"
    branch: "main"

  theme:
    name: "material"
    palette:
      primary: "blue"
      accent: "light blue"
    features:
      - navigation.tabs
      - navigation.sections
      - search.suggest
      - search.highlight

  plugins:
    - search
    - minify:
        minify_html: true
    - git_revision_date
    - docsnap_integration:
        config: screenshots.yaml

  nav:
    - Home: index.md
    - Installation: installation.md
    - Configuration: configuration.md
    - API Reference: api/
    - Contributing: contributing.md

deployment:
  github_pages:
    enabled: true
    cname: docs.bootdisk.dev
    branch: gh-pages

  netlify:
    enabled: false

analytics:
  google_analytics:
    enabled: true
    id: "G-XXXXXXXXXX"

  plausible:
    enabled: false
```

## Supported Frameworks

### MkDocs Integration
- **Material Theme**: Beautiful, responsive design
- **Plugins**: Search, versioning, screenshot integration
- **Extensions**: Math, code highlighting, diagrams
- **Rust Processing**: High-performance markdown processing

### Sphinx Integration
- **Themes**: Alabaster, Read the Docs, custom themes
- **Extensions**: API docs, autodoc, intersphinx
- **Output**: HTML, PDF, ePub formats
- **Parallel Building**: Concurrent document processing

### Docusaurus Integration
- **React-based**: Modern, interactive documentation
- **Versioning**: Automatic version management
- **Search**: Algolia integration
- **Blog**: Integrated blog functionality

### Hugo Integration
- **Static Site**: Fast, secure documentation sites
- **Themes**: Beautiful, customizable themes
- **Shortcodes**: Reusable content components
- **Taxonomies**: Tag and category system

## WASM Components

DocSite includes WebAssembly components for enhanced interactivity:

### Search Component
```rust
// WASM search implementation
#[wasm_bindgen]
pub fn search_documents(query: &str, documents: JsValue) -> JsValue {
    // High-performance search implementation
    // Returns search results as JSON
}
```

### Navigation Component
```rust
// Interactive navigation tree
#[wasm_bindgen]
pub fn render_navigation(nav_data: JsValue) -> String {
    // Generate interactive navigation HTML
}
```

### Theme Switcher
```rust
// Dynamic theme switching
#[wasm_bindgen]
pub fn switch_theme(theme_name: &str) {
    // Apply theme dynamically without page reload
}
```

## Advanced Features

### Multi-Version Support
```yaml
versions:
  - version: "1.0"
    url: "https://v1.docs.example.com"
  - version: "latest"
    url: "https://docs.example.com"
```

### Automated Screenshots Integration
```yaml
plugins:
  - docsnap_integration:
      config: docs/screenshots.yaml
      output: assets/screenshots/
      on_build: true
```

### Search Integration
```yaml
search:
  engine: "algolia"
  index_name: "bootdisk-docs"
  api_key: "${ALGOLIA_API_KEY}"
```

## Performance Features

### Build Optimization
- **Incremental Builds**: Only rebuild changed content
- **Parallel Processing**: Concurrent document processing using Rayon
- **Memory Efficient**: Zero-copy string processing where possible
- **Caching**: Intelligent caching of processed content

### Runtime Performance
- **Fast Loading**: Optimized bundle sizes
- **WASM Acceleration**: Hardware-accelerated search and rendering
- **Lazy Loading**: Progressive content loading
- **CDN Ready**: Optimized for global content delivery

## Deployment Options

### GitHub Pages
```bash
docsite deploy github-pages --cname docs.example.com
```

### Netlify
```yaml
# netlify.toml
[build]
  command = "docsite build"
  publish = "dist/"

[build.environment]
  DOCSITE_CONFIG = "docsite.yaml"
```

### Vercel
```json
{
  "buildCommand": "docsite build",
  "outputDirectory": "dist/",
  "framework": null
}
```

## Development

### Building from Source
```bash
git clone https://github.com/agentic/docsite
cd docsite
cargo build --release
```

### Running Tests
```bash
cargo test
cargo test --doc  # Documentation tests
```

### WASM Development
```bash
# Build WASM components
wasm-pack build --target web

# Serve for development
cargo run -- serve --dev
```

## Integration

### CI/CD Pipeline
```yaml
- name: Setup Rust
  uses: actions-rust-lang/setup-rust-toolchain@v1

- name: Build DocSite
  run: cargo build --release

- name: Generate Documentation Site
  run: |
    ./target/release/docsite init mkdocs
    ./target/release/docsite build

- name: Deploy
  run: ./target/release/docsite deploy github-pages
```

### GitHub Actions
```yaml
- name: Deploy Documentation
  uses: docsite/action@v1
  with:
    framework: mkdocs
    deploy_target: gh-pages
    cname: docs.example.com
```

## Use Cases

- **Product Documentation**: Comprehensive product guides
- **API Documentation**: Interactive API references
- **Developer Guides**: Onboarding and development documentation
- **User Manuals**: End-user product documentation
- **Knowledge Bases**: Internal documentation sites
- **Project Documentation**: Open source project docs
    features:
      - navigation.tabs
      - navigation.sections
      - search.suggest
      - search.highlight

  plugins:
    - search
    - minify:
        minify_html: true
    - git-revision-date-localized
    - docsnap:
        config: screenshots.yaml

  nav:
    - Home: index.md
    - Installation: installation.md
    - Configuration: configuration.md
    - API Reference: api/
    - Contributing: contributing.md

  extra:
    version:
      provider: mike
    social:
      - icon: fontawesome/brands/github
        link: https://github.com/agentic/bootdisk

deployment:
  github_pages:
    enabled: true
    cname: docs.bootdisk.dev

  netlify:
    enabled: false

analytics:
  google_analytics:
    enabled: true
    id: "G-XXXXXXXXXX"

  plausible:
    enabled: false
```

## Supported Frameworks

### MkDocs
- **Material Theme**: Beautiful, responsive design
- **Plugins**: Search, versioning, screenshots
- **Extensions**: Math, code highlighting, diagrams
- **SEO**: Meta tags, sitemaps, structured data

### Sphinx
- **Themes**: Alabaster, Read the Docs, custom themes
- **Extensions**: API docs, autodoc, intersphinx
- **Output**: HTML, PDF, ePub formats
- **Integration**: Breathe for Doxygen, MyST for Markdown

### Docusaurus
- **React-based**: Modern, interactive documentation
- **Versioning**: Automatic version management
- **Search**: Algolia integration
- **Blog**: Integrated blog functionality

### Hugo
- **Static Site**: Fast, secure documentation sites
- **Themes**: Beautiful, customizable themes
- **Shortcodes**: Reusable content components
- **Taxonomies**: Tag and category system

## Advanced Features

### Multi-Version Support
```yaml
versions:
  - version: "1.0"
    url: "https://v1.docs.example.com"
  - version: "latest"
    url: "https://docs.example.com"
```

### Automated Screenshots
```yaml
plugins:
  - docsnap:
      config: docs/screenshots.yaml
      output: assets/screenshots/
      on_build: true
```

### Search Integration
```yaml
search:
  engine: "algolia"
  index_name: "bootdisk-docs"
  api_key: "${ALGOLIA_API_KEY}"
```

## Deployment Options

### GitHub Pages
```bash
docsite deploy gh-pages --cname docs.example.com
```

### Netlify
```yaml
# netlify.toml
[build]
  command = "docsite build"
  publish = "build/"

[build.environment]
  NODE_VERSION = "18"
```

### Vercel
```json
{
  "buildCommand": "docsite build",
  "outputDirectory": "build/",
  "framework": null
}
```

## Integration

### CI/CD Pipeline
```yaml
- name: Setup Documentation
  run: |
    pip install docsite docsnap apidocgen
    docsite init mkdocs

- name: Generate Content
  run: |
    docsnap generate docs/screenshots.yaml
    apidocgen fastapi --app main:app --output docs/api/

- name: Build and Deploy
  run: |
    docsite build
    docsite deploy gh-pages
```

### GitHub Actions
```yaml
- name: Deploy Documentation
  uses: docsite/action@v1
  with:
    framework: mkdocs
    deploy_target: gh-pages
    cname: docs.example.com
```

## Use Cases

- **Product Documentation**: Comprehensive product guides
- **API Documentation**: Interactive API references
- **Developer Guides**: Onboarding and development documentation
- **User Manuals**: End-user product documentation
- **Knowledge Bases**: Internal documentation sites
- **Project Documentation**: Open source project docs