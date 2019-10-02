.PHONY: features

dependencies:
	bin/setup

specs:
	bundle exec rspec -r rspec_junit_formatter --format documentation --format RspecJunitFormatter -o reports/junit.xml

analysis:
	bundle exec rubocop
