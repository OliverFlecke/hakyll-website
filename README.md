# Personal page

This project contains my personal page for notes and other work, which can be found [here!](http://www.oliverflecke.github.io)

The page is build using [Hakyll](https://jaspervdj.be/hakyll/index.html), a Haskell library to build static web pages.

## Build the site

To build the site, install stack and execute:

```bash
stack build
stack exec site clean
stack exec site build
```

The `build` folder contains different scripts for creating and publishing the content.