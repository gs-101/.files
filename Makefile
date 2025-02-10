update:
	guix pull --channels=${DOTFILES}/guix/channels-list.scm
	guix describe --format=channels > ${DOTFILES}/guix/channels.scm
	nix-channel --update

system-reconfigure:
	sudo guix system reconfigure ${DOTFILES}/guix/system/`hostname`.scm --fallback

.PHONY: system-reconfigure

system-edit:
	${EDITOR} "${DOTFILES}/guix/system/`hostname`.scm"

.PHONY: system-edit

home-reconfigure:
	guix home reconfigure ${DOTFILES}/guix/home/`hostname`.scm --fallback
	home-manager switch --flake ${DOTFILES}/nix/home/#gabriel

.PHONY: home-reconfigure

home-edit:
	${EDITOR} ${DOTFILES}/guix/home/`hostname`.scm

.PHONY: home-edit

gc:
	guix gc
	nix-collect-garbage

.PHONY: gc
