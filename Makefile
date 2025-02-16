.PHONY: all rubocop rspec check

all: check

rubocop:
	bundle exec rubocop -A

rspec:
	bundle exec rspec

check: rubocop rspec
