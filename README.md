<table>
<tr>
<td width="140">

<img width="128" height="128" alt="WizardLibrary Icon-iOS-Default-1024x1024@1x" src="https://github.com/user-attachments/assets/657abd4a-1f5d-4130-81ca-90926959f7c1" />


</td>
<td>

# 🧙‍♂️ WizardLibrary

WizardLibrary is a SwiftUI iOS app that browses data from the [Potter DB API](https://docs.potterdb.com/) – including books, characters, movies, potions, and spells from the Harry Potter universe. It’s built with a modern MVVM architecture, Combine networking, and lazy-loading lists & grids.

</td>
</tr>
</table>

---

## ✨ Features

### 📚 Books
- List of books from the wizarding world.
- Simple, clean list layout that shows title and optional author.
- Uses a shared `BooksViewModel` injected via `@EnvironmentObject` from `ContentView`.

### 🧍‍♀️ Characters
- Grid layout of characters with images and names.
- Lazy loading with infinite scroll: automatically loads more characters as you reach the end of the grid.  
- Uses `CharacterGridView` for the card UI with a cached image + placeholder.

### 🎬 Movies
- Vertical scroll of large movie cards using `MovieCardView`.
- Shows poster image, title, and a chevron for future navigation to details.

### 🧪 Potions
- 2-column grid of potions using `PotionGridView`.
- Infinite scroll: loads more potions when the last item appears.
- Cached network images with a `flask` SF Symbol placeholder.

### 🪄 Spells
- 2-column grid of spells using `SpellGridView`.
- Infinite scroll and lazy loading similar to potions.
- Placeholder SF Symbol `wand.and.stars` for spells without an image.

### 🧭 Tab-based Navigation
All resources are accessible through a `TabView`:

- **Books** – `book`
- **Characters** – `person`
- **Movies** – `camera`
- **Potions** – `flask`
- **Spells** – `wand.and.sparkles`

---

## 🏗 Architecture & Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (View + ViewModel per domain screen)
- **Networking**: Custom `NetworkService` (Combine-based `Publisher` pipeline)
- **Image Loading**: `CachedImage` wrapper for remote images with placeholders.
- **Async UI**:
  - `@StateObject`/`@EnvironmentObject` for state.
  - `ProgressView` for loading, and error text for failures.

---

## 🧩 Potter DB API

WizardLibrary uses the public [Potter DB API](https://docs.potterdb.com/) for all data.

Key details:

- **Base URL**: `https://api.potterdb.com/`
- **Authentication**: Free to use, **no auth required**. 
- **REST Endpoints Used (examples)**:
  - `GET /v1/books`
  - `GET /v1/characters`
  - `GET /v1/movies`
  - `GET /v1/potions`
  - `GET /v1/spells`
- Follows **JSON:API** format (resources with `type`, `id`, `attributes`).
- Supports pagination via `page[number]` and `page[size]` query parameters.

You can switch to GraphQL if you ever want more flexible queries, via the `/graphql` endpoint.

---

## 🚀 Getting Started

### Prerequisites

- Xcode 16+ (or a version that supports Swift 5.10+ & iOS 18 SDK)
- iOS 18+ deployment target (adjust as needed in your project settings)
- An internet connection for API calls

### 1. Clone the Repository

```bash
git clone https://github.com/ghifarij/WizardLibrary.git
cd WizardLibrary
