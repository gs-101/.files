# Updating.

update:
	@echo "-------------"
	@echo "Updating Guix"
	@guix pull --channels=${DOTFILES}/guix/channels-list.scm || guix pull --channels=${DOTFILES}/guix/channels-list.scm --url="https://codeberg.org/guix/guix-mirror"
	@guix describe --format=channels > ${DOTFILES}/guix/channels.scm
	@cd ${DOTFILES} && git add guix/channels.scm && git commit -m "chore(channels.scm): update channels"
	@echo "-------------"
	@echo "Updating Nix"
	@nix flake \update ${DOTFILES}/nix/home/ --commit-lock-file --commit-lockfile-summary "chore(flake.lock): update flake"
	@echo "-------------"

.PHONY: update

# Cleaning.

gc:
	@echo "-----------------------"
	@echo "Collecting Guix Garbage"
	@guix gc
	@echo "-----------------------"
	@echo "Collecting Nix Garbage"
	@nix-collect-garbage
	@echo "-----------------------"

.PHONY: gc

# REPL.

ares:
	guix shell guile-next guile-ares-rs -- guile -L ${DOTFILES}/guix -c "(begin (use-modules (guix gexp)) ((@ (ares server) run-nrepl-server)))"

.PHONY: ares

# System.

system-reconfigure:
	@echo "--------------------"
	@echo "Reconfiguring System"
	@sudo guix system reconfigure ${DOTFILES}/guix/system/`hostname`.scm --fallback
	@echo "--------------------"

.PHONY: system-reconfigure

system-edit:
	@${EDITOR} "${DOTFILES}/guix/system/`hostname`.scm"

.PHONY: system-edit

# Home.

home-reconfigure:
	@echo "-----------------------"
	@echo "Reconfiguring Guix Home"
	@guix home reconfigure ${DOTFILES}/guix/home/`hostname`.scm --fallback
	@echo "-----------------------"
	@echo "Reconfiguring Nix Home"
	@home-manager switch --no-write-lock-file
	# Reload Hyprland environment.
	if [ ${XDG_CURRENT_DESKTOP} = Hyprland ]; then \
		hyprctl reload; \
	fi
	@echo "-----------------------"

.PHONY: home-reconfigure

home-edit:
	@${EDITOR} ${DOTFILES}/guix/home/`hostname`.scm

.PHONY: home-edit

# General.

all: update system-reconfigure home-reconfigure

.PHONY: all
