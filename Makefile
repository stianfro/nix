.PHONY: switch

HOSTNAME=$(shell hostname)

switch:
	darwin-rebuild switch --flake .#${HOSTNAME}
