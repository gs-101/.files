# General.

all: update system-reconfigure home-reconfigure

.PHONY: all

# Updating.

update:
	@echo "-------------"
	@echo "Updating Guix"
	@guix pull --channels=${DOTFILES}/guix/channels-list.scm
	@guix describe --format=channels > ${DOTFILES}/guix/channels.scm
	@cd ${DOTFILES} && git add guix/channels.scm && git commit -m "chore(channels.scm): update channels"
	@guix pull --news
	@echo "-------------"
	@echo "Updating Nix"
	@nix flake \update --flake ${DOTFILES}/nix/home/ --commit-lock-file --commit-lockfile-summary "chore(flake.lock): update flake"
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

nuke:
	@echo "-----------------"
	@echo "Nuking Guix Store"
	@guix gc -d
	@echo "-----------------"
	@echo "Nuking Nix Store"
	@nix-collect-garbage -d
	@echo "-----------------"

.PHONY: nuke

# REPL.

ares:
	guix shell guile-next guile-ares-rs -- guile -L ${DOTFILES}/guix/modules -c "(begin (use-modules (guix gexp)) ((@ (ares server) run-nrepl-server)))"

.PHONY: ares

# System.

system-reconfigure:
	@echo "--------------------"
	@echo "Reconfiguring System"
	@sudo guix system reconfigure -L ${DOTFILES}/guix/modules ${DOTFILES}/guix/modules/system/`hostname`.scm --fallback
	@echo "--------------------"

.PHONY: system-reconfigure

system-edit:
	@${EDITOR} "${DOTFILES}/guix/modules/system/`hostname`.scm"

.PHONY: system-edit

# Run after setting hostname:
# $ hostname NAME
init:
	guix system -L ${DOTFILES}/guix/modules init ${DOTFILES}/guix/modules/system/`hostname`.scm /mnt --fallback

.PHONY: init

# Home.

home-reconfigure:
	@echo "-----------------------"
	@echo "Reconfiguring Guix Home"
	@guix home reconfigure -L ${DOTFILES}/guix/modules ${DOTFILES}/guix/modules/home/`hostname`.scm --fallback
	@echo "-----------------------"
	@echo "Reconfiguring Nix Home"
	@home-manager switch --no-write-lock-file
	# Reload Hyprland environment.
	@if [ ${XDG_CURRENT_DESKTOP} = Hyprland ]; then hyprctl reload; fi
	@echo "-----------------------"

.PHONY: home-reconfigure

home-edit:
	@${EDITOR} ${DOTFILES}/guix/modules/home/`hostname`.scm

.PHONY: home-edit

reload:
	@guix home reconfigure -L ${DOTFILES}/guix/modules ${DOTFILES}/guix/modules/home/`hostname`.scm --no-substitutes
	@home-manager switch --no-write-lock-file --no-substitute

.PHONY: reload

# Distribution

image:
	guix system image --image-type=iso9660 --root='image.iso' -L ${DOTFILES}/guix/modules ${DOTFILES}/guix/modules/image/base.scm --fallback -c

.PHONY: image
