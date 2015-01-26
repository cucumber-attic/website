## cucumber.pro

This is the source of https://cucumber.pro/

### Building site locally

You need Ruby and Node.js to build the site.

Install dependencies:

    bundle install
    npm install

Serve the files:

    jekyll serve --watch --drafts

Rebuild assets whenever they are saved:

    while true; do NOCOMPRESS=true make --silent assets; sleep 1; done

### Authoring

CSS and JavaScript live under `assets`.

Regular contents are the `.html` and `.md` files in the root directory. We'll try to use Markdown as much
as possible, and only resort to HTML when we need special layout.

### Hacking on the payments page

If you need to test payments locally, set the config to use the development settings:

    rm _config.yml
    ln -sf _config.dev.yml _config.yml

To make sure you don't commit this to git, use this:

    git update-index --assume-unchanged _config.yml

You can save the effort of a manual payment test with:

    jekyll serve --watch --drafts
    make test

See the docs in features/readme.md for setup details.
