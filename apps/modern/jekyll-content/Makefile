assets: css/style.css js/main.js

assets-watch:

css/style.css: assets/css/style.less \
	assets/css/layout.less \
	assets/css/pricing.less \
	assets/css/pygments.less \
	assets/css/variables.less \
	css/community-nav.css \
	bower_components/ladda/dist/ladda.min.css

ifdef NOCOMPRESS
	node_modules/.bin/lessc --strict-imports assets/css/style.less $@
else
	node_modules/.bin/lessc --strict-imports --compress assets/css/style.less $@
endif


js/main.js: bower_components/jquery/jquery.js \
	bower_components/jquery-cookie/jquery.cookie.js \
	bower_components/bootstrap/dist/js/bootstrap.js \
	assets/js/one-column-img-responsive.js \
	bower_components/ladda/js/spin.js \
	bower_components/ladda/js/ladda.js
ifdef NOCOMPRESS
	cat $^ > $@
else
	node_modules/.bin/uglifyjs $^ --output $@
endif

assets/css/variables.less: bower_components/bootstrap/less/variables.less
	cp bower_components/bootstrap/less/variables.less $@

bower:
	node_modules/.bin/bower install

#   Modify Bootstrap to point to our own (modified) copy of variables.less. Perl is more cross platform than sed.
	perl -i -pe's|"variables.less"|"../../../assets/css/variables.less"|' bower_components/bootstrap/less/bootstrap.less

test:
	bundle exec cucumber

clean:
	rm -rf css/style.css js/main.js _site

.PHONY: bower clean test
