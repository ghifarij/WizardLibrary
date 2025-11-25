# 🧙‍♂️ WizardLibrary

WizardLibrary is a SwiftUI iOS app that browses data from the [Potter DB API](https://docs.potterdb.com/) – including books, characters, movies, potions, and spells from the Harry Potter universe. It’s built with a modern MVVM architecture, Combine networking, and lazy-loading lists & grids. :contentReference[oaicite:0]{index=0}  

---

## ✨ Features

### 📚 Books
- List of books from the wizarding world.
- Simple, clean list layout that shows title and optional author. :contentReference[oaicite:1]{index=1}  
- Uses a shared `BooksViewModel` injected via `@EnvironmentObject` from `ContentView`. :contentReference[oaicite:2]{index=2}  

### 🧍‍♀️ Characters
- Grid layout of characters with images and names. :contentReference[oaicite:3]{index=3}  
- Lazy loading with infinite scroll: automatically loads more characters as you reach the end of the grid. :contentReference[oaicite:4]{index=4}  
- Uses `CharacterGridView` for the card UI with a cached image + placeholder. :contentReference[oaicite:5]{index=5}  

### 🎬 Movies
- Vertical scroll of large movie cards using `MovieCardView`. :contentReference[oaicite:6]{index=6}  
- Shows poster image, title, and a chevron for future navigation to details. :contentReference[oaicite:7]{index=7}  

### 🧪 Potions
- 2-column grid of potions using `PotionGridView`. :contentReference[oaicite:8]{index=8}  
- Infinite scroll: loads more potions when the last item appears. :contentReference[oaicite:9]{index=9}  
- Cached network images with a `flask` SF Symbol placeholder. :contentReference[oaicite:10]{index=10}  

### 🪄 Spells
- 2-column grid of spells using `SpellGridView`. :contentReference[oaicite:11]{index=11}  
- Infinite scroll and lazy loading similar to potions. :contentReference[oaicite:12]{index=12}  
- Placeholder SF Symbol `wand.and.stars` for spells without an image. :contentReference[oaicite:13]{index=13}  

### 🧭 Tab-based Navigation
All resources are accessible through a `TabView`:

- **Books** – `book`
- **Characters** – `person`
- **Movies** – `camera`
- **Potions** – `flask`
- **Spells** – `wand.and.sparkles` :contentReference[oaicite:14]{index=14}  

---

## 🏗 Architecture & Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (View + ViewModel per domain screen)
- **Networking**: Custom `NetworkService` (Combine-based `Publisher` pipeline)
- **Image Loading**: `CachedImage` wrapper for remote images with placeholders. :contentReference[oaicite:15]{index=15}  
- **Async UI**:
  - `@StateObject`/`@EnvironmentObject` for state.
  - `ProgressView` for loading, and error text for failures. :contentReference[oaicite:16]{index=16}  

---

## 🧩 Potter DB API

WizardLibrary uses the public [Potter DB API](https://docs.potterdb.com/) for all data.

Key details:

- **Base URL**: `https://api.potterdb.com/` :contentReference[oaicite:17]{index=17}  
- **Authentication**: Free to use, **no auth required**. :contentReference[oaicite:18]{index=18}  
- **REST Endpoints Used (examples)**: :contentReference[oaicite:19]{index=19}  
  - `GET /v1/books`
  - `GET /v1/characters`
  - `GET /v1/movies`
  - `GET /v1/potions`
  - `GET /v1/spells`
- Follows **JSON:API** format (resources with `type`, `id`, `attributes`).
- Supports pagination via `page[number]` and `page[size]` query parameters.

You can switch to GraphQL if you ever want more flexible queries, via the `/graphql` endpoint. :contentReference[oaicite:20]{index=20}  

---

## 🚀 Getting Started

### Prerequisites

- Xcode 16+ (or a version that supports Swift 5.10+ & iOS 18 SDK)
- iOS 18+ deployment target (adjust as needed in your project settings)
- An internet connection for API calls

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/WizardLibrary.git
cd WizardLibrary
