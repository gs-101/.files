update:
	guix pull --channels=${DOTFILES}/guix/channels-list.scm
	guix describe --format=channels > ${DOTFILES}/guix/channels.scm
    nix flake \update ${DOTFILES}/nix/home/ --commit-lock-file --commit-lockfile-summary "chore(flake.lock): update flake"

.PHONY: update

system-reconfigure:
	sudo guix system reconfigure ${DOTFILES}/guix/system/`hostname`.scm --fallback

.PHONY: system-reconfigure

system-edit:
	${EDITOR} "${DOTFILES}/guix/system/`hostname`.scm"

.PHONY: system-edit

home-reconfigure:
	guix home reconfigure ${DOTFILES}/guix/home/`hostname`.scm --fallback
	home-manager switch --no-write-lock-file

.PHONY: home-reconfigure

home-edit:
	${EDITOR} ${DOTFILES}/guix/home/`hostname`.scm

.PHONY: home-edit

gc:
	guix gc
	nix-collect-garbage

.PHONY: gc
