# Payments Test

This just saves you doing a laborious manual test, but it still requires some manual setup:

1. Switch this app to use dev config with `ln -sf _config.dev.yml _config.yml`
2. Start this app in another shell with `jekyll serve`
3. Start the customers app on port 9292 (again, using dev config)
4. Run this test `make test`
