.PHONY: features

dependencies:
	bin/setup

outdated-dependencies:
	bundle outdated --only-explicit

specs:
	bundle exec rspec -r rspec_junit_formatter --format documentation --format RspecJunitFormatter -o reports/junit.xml

analysis:
	bundle exec rubocop

cleanup-analysis:
	bundle exec rubocop -A
