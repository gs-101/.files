update:
	guix pull --channels=${DOTFILES}/guix/channels-list.scm
	guix describe --format=channels > ${DOTFILES}/guix/channels.scm
	nix-channel --update

system-reconfigure:
	sudo -E guix system reconfigure ${DOTFILES}/guix/systems/`hostname`.scm --fallback

.PHONY: system-reconfigure

system-edit:
	${EDITOR} "${DOTFILES}/guix/systems/`hostname`.scm"

.PHONY: system-edit

home-reconfigure:
	guix home reconfigure ${DOTFILES}/guix/home/`hostname`.scm --fallback

.PHONY: home-reconfigure

home-edit:
	${EDITOR} ${DOTFILES}/guix/home/`hostname`.scm

home-reconfigure-nix:
	home-manager switch --flake ${DOTFILES}/nix/home/#gabriel

.PHONY: home-reconfigure-nix

garbage-collect:
	guix gc
	nix-collect-garbage

.PHONY: garbage-collect
