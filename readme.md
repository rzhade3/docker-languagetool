
# Introduction

[LanguageTool](https://www.languagetool.org/) is an Open Source proof­reading software for English, French,
German, Polish, and more than 20 other languages.

This is a GitHub Action to run against your own repository, and works by bundling the entirety of LanguageTool into GitHub Actions. The primary use case envisioned for this Action is for private repositories containing sensitive material, which one wouldn't want leaving their own repository. If you want less overhead, LanguageTool also has an API, or you could spin up your own server and point an Action to: http://wiki.languagetool.org/public-http-api.

# Attribution

This image is heavily based off of [docker-languagetool](https://github.com/silvio/docker-languagetool). The core language tool project can be found at https://github.com/languagetool-org/languagetool.

# Usage

Check out the [`workflow/test.yml`](https://github.com/rzhade3/languagetool-github-action/blob/master/.github/workflows/test.yml) to look at a working workflow file.
