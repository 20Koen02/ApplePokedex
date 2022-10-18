#  Apple Pokedex

### General
- [x] The app must have an iOS look and feel by using native components in a logical way
- [x] The app must have error handling implemented. This means the app should not crash when for example a network error occurs.
- [x] When creating your project, the bundle id of your app must be: nl.<lastname>.<firstname> (e.g. nl.vanwijngaarden.koen)
- [x] When creating your project the app name must include your student number (e.g. student512345)

### Tab bar
- [x] The app must use a tab bar containing the following pages:
    - [x] Main page
    - [x] Favorites page
- [x] The pages must be named in the tab bar

### Main page
- [x] The main page of the application must show a list or grid of Pokémon.
- [x] The list of Pokémon must be implemented using one of the following views: List, Lazy Stack or Grid.
- [x] The Pokémon cells must have a NavigationLink that will show a detail page for the specific Pokémon
- [x] A loading spinner or placeholder should be visible for each image that is being fetched from the back-end
- [x] Each Pokémon has various properties, at least the image and name must be shown within the list or grid
- [x] Add icons to the tabbed pages.
    - [x] If implementing this, you can leave out the page name if you prefer the look if just an icon.
- [x] Show some indicator (ProgressView or Text) when the app is communicating with the back-end, so the user knows that the app is doing something

### Detail page
- [x] The details page shows at least these details of a Pokémon: image, name, type(s), id/number.
- [x] The details page shows a loading indicator while the details are loading.
- [x] The page must implement scrolling, in case the details of the Pokémon don’t fit the screen of the devices (ScrollView)

### Favorites page
- [x] The favourites page should show only Pokémon that the user has favourited.
- [x] The favourites should show the same detail page as the main page when tapping a Pokémon
- [x] When there are no favourites, show a message explaining no favourites have been added.

### Optional features
- [x] Add animations to bring your app to life
- [x] Add either the about, the stats or the evolution section to the bottom of the detail page
- [x] Add a section selector (at the bottom) of the detail page that can show all different sections (about, stats, and evolution)
- [x] Persist favourites after closing the app
- [x] Allow the user to share a Pokémon (i.e. image or name), using the iOS sharing functionality
- [ ] Localise the app for another language (when you only know english, Google translating words is allowed)
- [x] Create a nice app icon and splash screen
- [x] Create a way for the user to refresh the articles manually, with a Button for instance or pull to refresh
- [ ] When the user scrolls near the end of the list or grid, the next 20 Pokémon must be retrieved from the back-end
