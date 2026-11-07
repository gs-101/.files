;;; init.el --- Gabriel Santos's Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Personal Emacs configuration.

;;; Code:

;;; ============================================================================
;;; System & Package Setup
;;; ============================================================================

(defcustom dw/current-distro
  (or (and (eq system-type 'gnu/linux)
           (file-exists-p "/etc/os-release")
           (with-temp-buffer
             (insert-file-contents "/etc/os-release")
             (search-forward-regexp "^ID=\"?\\(.*\\)\"?$")
             (intern (or (match-string 1)
                         "unknown"))))
      'unknown)
  "Current GNU/Linux distro being used."
  :type 'symbol)

(defvar dw/guix-p
  (eql dw/current-distro 'guix))

(defvar gs-101/nixos-p
  (eql dw/current-distro 'nixos))

(require 'package)
(dolist (archive '(("melpa" . "https://melpa.org/packages/")))
  (add-to-list 'package-archives archive))

;;; ============================================================================
;;; General Settings
;;; ============================================================================

(use-package auth-source
  :config
  (add-to-list 'auth-sources "~/.config/sops-nix/secrets/authinfo"))

(use-package comp-run
  :custom
  (native-comp-async-query-on-exit t)
  (native-comp-async-report-warnings-errors 'silent))

(use-package ediff-wind
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package editorconfig
  :init
  (editorconfig-mode))

(use-package emacs
  :bind
  ("<WakeUp>" . gs-101/greeter)
  (:map emacs-lisp-mode-map
        ("C-c C-c" . gs-101/eval-dwim)
        ("C-c m e b" . eval-buffer)
        ("C-c m e r" . eval-region)
        ("C-c C-p" . ielm))
  :config
  (defun gs-101/eval-dwim (arg)
    "Evaluate region if it is active; if not, evaluate the buffer.
If the region is active, this function calls `eval-region'.
Otherwise, it calls `eval-buffer'.

If the character before point is a closed parenthesis,
this calls `eval-last-sexp'.

ARG is used for `eval-last-sexp'."
    (interactive "P")
    (cond
     ((use-region-p) (eval-region (region-beginning) (region-end) t)
      (message "Region evaluated"))
     ((eq (char-before) ?\)) (eval-last-sexp arg)
      (message "Sexp evaluated"))
     (t (eval-buffer nil nil)
        (message "Buffer evaluated"))))
  (defun gs-101/greeter ()
    "Print a \"Welcome back!\" message after waking up from suspend."
    (interactive)
    (message "Welcome back!"))
  :custom
  (auto-save-include-big-deletions t)
  (auto-window-vscroll nil) ; 3
  (bidi-inhibit-bpa t) ; 3
  (bidi-paragraph-direction 'left-to-right)
  (completion-ignore-case t) ; 4
  (cursor-in-non-selected-windows nil) ; 3
  (debugger-stack-frame-as-list t) ; 5
  (delete-by-moving-to-trash t)
  (enable-recursive-minibuffers t)
  (fast-but-imprecise-scrolling t) ; 3
  (focus-follows-mouse t)
  (font-use-system-font t)
  (frame-resize-pixelwise t) ; 1
  (frame-title-format "GNU Emacs")
  (history-delete-duplicates t) ; 5
  (hscroll-margin 2) ; 3
  (hscroll-step 1) ; 3
  (inhibit-compacting-font-caches t) ; 3
  (load-prefer-newer t) ; 2
  (menu-bar-mode nil)
  ;; Disable the cursor in the minibuffer prompt
  ;; 4
  (minibuffer-prompt-properties
   '(cursor-intangible t read-only t face minibuffer-prompt))
  (mouse-autoselect-window t)
  (read-buffer-completion-ignore-case t) ; 4
  (redisplay-skip-fontification-on-input t)
  (ring-bell-function #'ignore)
  (scroll-conservatively 100000)
  (scroll-margin 2)
  (scroll-preserve-screen-position t)
  (scroll-step 1)
  (text-mode-ispell-word-completion nil)
  (tool-bar-mode nil)
  (tooltip-mode nil)
  ;; 64 mb
  (undo-limit 67108864)
  ;; 96 mb
  (undo-strong-limit 100663296)
  ;; 960 mb
  (undo-outer-limit 1006632960)
  (use-dialog-box nil)
  (use-file-dialog nil)
  (user-full-name "Gabriel Santos")
  (visible-bell nil)
  (window-resize-pixelwise nil) ; 1
  (word-wrap t)
  (words-include-escapes t)
  (x-stretch-cursor t)
  (x-underline-at-descent-line nil)
  :hook
  ;; 4
  (minibuffer-setup . cursor-intangible-mode))

(use-package epg-config
  :custom
  (epg-pinentry-mode 'loopback))

(use-package files
  :bind
  ("C-c f r" . recover-this-file)
  :config
  (add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p) ; 3
  :custom
  (auto-mode-case-fold nil)
  (backup-by-copying t) ; 2
  (backup-by-copying-when-linked t) ; 2
  (delete-old-versions t)
  (find-file-suppress-same-file-warnings t)
  (find-file-visit-truename t)
  (kept-new-versions 5) ; 2
  (kept-old-versions 5) ; 2
  (trusted-content `(,user-emacs-directory
                     "~/Projects/"))
  (version-control t) ; 2
  ;; 3
  (view-read-only t))

(use-package flymake
  :bind
  (:map prog-mode-map
        ([remap previous-error] . flymake-goto-prev-error)
        ([remap next-error] . flymake-goto-next-error))
  :custom
  (flymake-indicator-type 'margins)
  (flymake-margin-indicators-string '((error "󰃤" compilation-error)
                                      (warning "" compilation-warning)
                                      (note "󰎚" compilation-info))))

(use-package frame
  :bind
  ("C-z" . nil)
  :config
  (with-eval-after-load 'mode-local
    (setq-mode-local doc-view-mode blink-cursor-mode nil))
  :custom
  (window-divider-default-bottom-width 1)
  (window-divider-default-places t)
  (window-divider-default-right-width 1)
  :init
  (window-divider-mode))

(use-package grep
  :bind
  ("M-s g g" . grep)
  ("M-s g l" . lgrep)
  ("M-s g r" . rgrep)
  :custom
  (grep-use-headings t))

(use-package vc-git
  :bind
  ("M-s g v" . vc-git-grep))

(use-package help
  :bind
  ("C-h C-b" . describe-prefix-bindings)
  :custom
  (help-window-select t))

(use-package ibuf-ext
  :hook
  (ibuffer-mode . ibuffer-auto-mode))

(use-package image-mode
  :custom
  (image-animate-loop t))

(use-package imenu
  :custom
  (imenu-flatten 'annotation)
  (imenu-space-replacement nil))

(use-package indent
  :custom
  (tab-always-indent 'complete)
  :defer t)

(use-package isearch
  :custom
  (isearch-allow-scroll t)
  (isearch-lazy-count t)
  (lazy-count-prefix-format "(%s/%s) ")
  (lazy-count-suffix-format nil)
  (lazy-highlight-initial-delay 0.0))

(use-package minibuffer
  :custom
  (completion-pcm-leading-wildcard t)
  (completions-detailed t) ; 1
  (completions-format 'vertical)
  (completions-group t) ; 1
  (completion-styles '(flex partial-completion basic))
  (read-file-name-completion-ignore-case t) ; 2
  (resize-mini-windows t)
  :init
  (minibuffer-depth-indicate-mode)
  (minibuffer-electric-default-mode))

(use-package mode-local)

(use-package mouse
  :custom
  (mouse-drag-and-drop-region-cross-program t)
  (mouse-yank-at-point t)
  :init
  (when (display-graphic-p)
    (context-menu-mode)))

(use-package mule
  :config
  (prefer-coding-system 'utf-8))

(use-package newcomment
  :custom
  (comment-empty-lines t))

(use-package paren
  :config
  (custom-set-faces
   '(show-paren-match ((t :background unspecified
                          :foreground unspecified
                          :box (:line-width (-1 . -1))))))
  :custom
  (show-paren-delay 0)
  :init
  (show-paren-mode))

(use-package repeat
  :init
  (repeat-mode))

(use-package replace
  :custom
  (query-replace-show-preview 'replacement-only))

(use-package savehist
  :custom
  (history-length 300)
  :init
  (savehist-mode))

(use-package secrets)

(use-package sendmail
  :custom
  (sendmail-program (executable-find "msmtp")))

(use-package server
  :demand t
  :ensure nil
  :init
  (defun positron-solutions/server ()
    "Start the Emacs server if it's not running."
    (unless (bound-and-true-p server-process)
      (server-start)))
  :init
  (positron-solutions/server))

(use-package simple
  :bind
  ("C-x M-h" . captainflasmr/copy-buffer-to-kill-ring)
  ("M-g M-c" . gs-101/switch-to-minibuffer-dwim)
  ("M-\\" . nil) ;; unbind `delete-horizontal-space', use `cycle-spacing' instead
  ([remap capitalize-word] . capitalize-dwim)
  ([remap upcase-word] . upcase-dwim)
  ([remap downcase-word] . downcase-dwim)
  :config
  (defun gs-101/switch-to-minibuffer-dwim ()
    "Switch to minibuffer in a regular window. In minibuffer, switch to previous window.
If currently in the minibuffer, this function calls `previous-window-any-frame'.
Otherwise, it calls `switch-to-minibuffer'."
    (interactive)
    (if (minibufferp)
        (previous-window-any-frame)
      (switch-to-minibuffer)))
  :custom
  (blink-matching-paren nil)
  (column-number-mode t)
  (completion-auto-select 'second-tab) ; 1
  (indent-tabs-mode nil)
  (kill-do-not-save-duplicates t) ; 5
  (kill-read-only-ok t) ; 5
  (kill-region-dwim 'emacs-word)
  (kill-whole-line t) ; 5
  ;; Hides commands in completion that are not usable in the current mode
  (read-extended-command-predicate #'command-completion-default-include-p) ; 4
  (save-interprogram-paste-before-kill t)
  (set-mark-command-repeat-pop t) ; 5
  :config
  ;; 6
  (defun captainflasmr/copy-buffer-to-kill-ring (arg)
    "Mark the whole buffer, then copy it to the kill-ring without moving point.
With a ARG prefix argument, copy the buffer to the other window."
    (interactive "P")
    (if arg
        (save-window-excursion
          (kill-ring-save (point-min) (point-max))
          (other-window 1)
          (erase-buffer)
          (yank))
      (progn
        (save-excursion
          (kill-ring-save (point-min) (point-max)))
        (message "Buffer copied to kill-ring"))))
  :demand t)

(use-package startup
  :config
  (advice-add #'display-startup-echo-area-message :override #'ignore)
  (advice-add #'display-startup-screen :override #'ignore)
  :custom
  (inhibit-startup-echo-area-message t)
  (inhibit-startup-message t)
  (inhibit-startup-screen t)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message nil)
  (user-mail-address "gabrielsantosdesouza@disroot.org")
  :defer t)

(use-package text-mode
  :hook
  (text-mode . visual-line-mode))

(use-package transient
  :custom
  (transient-mode-line-format nil))

(use-package uniquify
  :custom
  (uniquify-buffer-name-style 'forward))

(use-package use-package
  :custom
  (use-package-compute-statistics t)
  (use-package-enable-imenu-support t)
  (use-package-vc-prefer-newest t))

(use-package vc-hooks
  :init
  (vc-auto-revert-mode))

(use-package warnings
  :custom
  (warning-suppress-log-types '((comp) (bytecomp))))

(use-package xref
  :config
  (when (executable-find "rg")
    (setopt xref-search-program 'ripgrep)))

(use-package diredfl
  :vc (:url "https://github.com/purcell/diredfl")
  :ensure t
  :unless (member 'noctalia custom-enabled-themes)
  :hook
  (dired-mode . diredfl-mode))

(use-package kkp
  :vc (:url "https://github.com/benotn/kkp")
  :ensure t
  :init
  (global-kkp-mode))

(use-package nil-mode
  :vc (:url "https://git.gs-101.dev/gs-101/nil-mode")
  :ensure t)

(use-package no-littering
  :vc (:url "https://github.com/emacscollective/no-littering")
  :ensure t
  :config
  ;; https://github.com/emacscollective/no-littering#lock-files
  (let ((dir (no-littering-expand-var-file-name "lock-files/")))
    (make-directory dir t)
    (setq lock-file-name-transforms `((".*" ,dir t))))
  (when (file-exists-p custom-file)
    (load-file custom-file))
  :custom
  (custom-file (no-littering-expand-etc-file-name "custom.el"))
  :init
  (no-littering-theme-backups))

(use-package recentf
  :after no-littering
  :custom
  (recentf-max-saved-items 1000)
  :config
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory)
               (recentf-expand-file-name no-littering-var-directory))
  :config
  (recentf-mode))

(use-package system-packages
  :vc (:url "https://gitlab.com/jabranham/system-packages")
  :config
  :ensure t)

(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll")
  :custom
  (scroll-conservatively 101)
  (scroll-margin 0)
  :init
  (ultra-scroll-mode)
  :ensure t)

(use-package with-editor
  :vc (:url "https://github.com/magit/with-editor")
  :init
  (shell-command-with-editor-mode)
  :ensure t)

(use-package xdg-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher")
  :ensure t)

;;; ============================================================================
;;; File Management
;;; ============================================================================

(use-package dired
  :bind
  (:map dired-mode-map
        ("b" . dired-up-directory))
  :custom
  (dired-dwim-target t)
  (dired-listing-switches "-ahlH --author --group-directories-first")
  (dired-maybe-use-globstar t)
  (dired-mouse-drag-files t)
  (dired-recursive-copies 'always))

(use-package dired-aux
  :after dired
  :custom
  (dired-create-destination-dirs 'always)
  (dired-create-destination-dirs-on-trailing-dirsep t)
  (dired-isearch-filenames 'dwim))

(use-package dired-clipboard
  :vc (:url "https://github.com/kn66/dired-clipboard.el")
  :ensure t
  :hook
  (dired-mode . dired-clipboard-mode))

(use-package dired-gitignore
  :vc (:url "https://github.com/johannes-mueller/dired-gitignore.el")
  :ensure t
  :init
  (dired-gitignore-global-mode t))

(use-package pale
  :vc (:url "https://codeberg.org/pale/pale")
  :ensure t)

(use-package reader
  :vc (:url "https://codeberg.org/MonadicSheep/emacs-reader")
  :ensure-system-package
  (mupdf-gl . mupdf)
  :ensure t)

(use-package ready-player
  :vc (:url "https://github.com/xenodium/ready-player")
  :ensure-system-package
  (ffmpeg mpv)
  :custom
  (ready-player-set-global-bindings nil)
  :ensure t
  :hook
  (dired-mode . ready-player-mode))

;;; ============================================================================
;;; Citar & Citations
;;; ============================================================================

(use-package citar
  :ensure-system-package
  zotero
  :bind
  (:map bibtex-mode-map
        ("C-c m q" . citar-insert-bibtex))
  :custom
  (citar-bibliography "~/Documents/bibliography.bib")
  (citar-citeproc-csl-styles-dir "~/Documents/zotero/styles/")
  (citar-citeproc-csl-style "harvard-cite-them-right.csl")
  (citar-format-reference-function #'citar-citeproc-format-reference)
  (citar-library-paths '("~/Documents/zotero/storage/"))
  (citar-open-entry-function #'citar-open-entry-in-zotero)
  (citar-templates '((main . "${author editor:30%sn}     ${date year issued:4}     ${title:48}")
                     (suffix . "          ${=key= id:15}    ${tags keywords keywords:*}    ${abstract abstract:*}")
                     (preview . "${author editor:%etal} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.")
                     (note . "Notes on ${author editor:%etal}, ${title}")))
  :hook
  (markdown-ts-mode . citar-capf-setup)
  :ensure t)

(use-package citar-embark
  :after embark
  :config 
  (add-to-list 'embark-keymap-alist '(bib-reference . citar-map))
  :custom
  (citar-at-point-function #'embark-act)
  :hook
  (text-mode . citar-embark-mode)
  :ensure t)

;;; ============================================================================
;;; Development
;;; ============================================================================

(use-package envrc
  :vc (:url "https://github.com/purcell/envrc")
  :ensure-system-package
  direnv
  :ensure t
  :custom
  (envrc-async t)
  :init
  (envrc-global-mode))

(use-package treesit
  :custom
  (treesit-font-lock-level 4))

(use-package treesit-auto
  :config
  (global-treesit-auto-mode)
  (treesit-auto-add-to-auto-mode-alist 'all)
  :custom
  (treesit-auto-install t)
  :ensure t)

(use-package expreg
  :vc (:url "https://github.com/casouri/expreg")
  :bind
  ("M-h" . expreg-expand)
  :ensure t)

(use-package git-commit-ts-mode
  :vc (:url "https://github.com/danilshvalov/git-commit-ts-mode")
  :ensure t
  :custom
  (git-commit-major-mode 'git-commit-ts-mode))

(use-package compile
  :bind
  ("C-c c" . compile)
  ("C-c C" . recompile)
  (:map compilation-mode-map
        ("p" . previous-error-no-select))
  :custom
  (compilation-ask-about-save nil)
  (compilation-max-output-line-length nil)
  (compilation-scroll-output t)
  (compilation-skip-threshold 2)
  :hook
  (compilation-mode . goto-address-mode)
  (compilation-filter . ansi-color-compilation-filter))

(use-package rmsbolt
  :vc (:url "https://gitlab.com/jgkamat/rmsbolt")
  :ensure t)

(use-package devcontainer
  :vc (:url "https://github.com/johannes-mueller/devcontainer.el")
  :ensure t
  :custom
  (devcontainer-engine 'podman))

(use-package devdocs
  :vc (:url "https://github.com/astoff/devdocs.el")
  :ensure t
  :bind
  (("C-h D" . devdocs-lookup)))

(use-package diff-mode
  :custom
  (diff-add-log-use-relative-names t))

(use-package diff-hl
  :vc (:url "https://github.com/dgutov/diff-hl")
  :ensure t
  :custom
  (diff-hl-update-async t)
  :init
  (global-diff-hl-mode)
  :hook
  (dired-mode . diff-hl-dired-mode)
  (magit-post-refresh . diff-hl-magit-post-refresh))

(use-package eglot
  :bind
  (:map prog-mode-map
        ("C-c t e" . eglot))
  (:map eglot-mode-map
        ("C-c e a" . eglot-code-actions)
        ("C-c e o" . eglot-code-action-organize-imports)
        ("C-c e i" . eglot-find-implementation)
        ("C-c e t" . eglot-find-typeDefinition)
        ("C-c e f" . eglot-format)
        ("C-c e r" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs
               '((c-ts-mode c++-ts-mode) . ("clangd"
                                            "--all-scopes-completion"
                                            "--background-index"
                                            "--clang-tidy"
                                            "--completion-style=detailed"))))

(use-package eglot-codelens
  :vc (:url "https://github.com/Gavinok/eglot-codelens")
  :hook
  (eglot-managed-mode . eglot-codelens-mode)
  :ensure t)

(use-package eglot-hover
  :vc (:url "https://codeberg.org/slotThe/eglot-hover")
  :after eglot
  :ensure t)

(use-package eglot-inactive-regions
  :vc (:url "https://github.com/fargiolas/eglot-inactive-regions")
  :ensure t
  :custom
  (eglot-inactive-regions-style 'darken-foreground)
  (eglot-inactive-regions-opacity 0.3)
  :hook
  (eglot-connect . eglot-inactive-regions-mode))

(use-package eglotx
  :vc (:url "https://github.com/cxa/eglotx")
  :ensure t)

(use-package eldoc
  :custom
  (eldoc-echo-area-use-multiline-p nil))

(use-package eglot-signature-eldoc-talkative
  :vc (:url "https://codeberg.org/mekeor/eglot-signature-eldoc-talkative")
  :after eglot
  :config
  (advice-add #'eglot-signature-eldoc-function :override #'eglot-signature-eldoc-talkative)
  :ensure t)

(use-package elec-pair
  :hook
  (minibuffer-mode . electric-pair-local-mode)
  (prog-mode . electric-pair-local-mode))

(use-package arduino-mode
  :vc (:url "https://repo.or.cz/arduino-mode.git")
  :ensure t)

(use-package astro-ts-mode
  :vc (:url "https://git.isincredibly.gay/srxl/astro-ts-mode")
  :ensure t)

(use-package clojure-ts-mode
  :vc (:url "https://github.com/clojure-emacs/clojure-ts-mode")
  :custom
  (clojure-ts-comment-macro-font-lock-body t)
  (clojure-ts-indent-style 'fixed)
  (clojure-ts-toplevel-inside-comment-form t)
  :ensure t)

(use-package cider
  :vc (:url "https://github.com/clojure-emacs/cider")
  :after clojure-ts-mode
  :bind
  (:map cider-mode-map
        ("C-c C-p" . cider-jack-in-clj))
  :ensure t
  :hook
  (clojure-ts-mode . cider-mode))

(use-package css-mode
  :custom
  ;; It's two everywhere, really.
  (css-indent-offset 2))

(use-package dart-ts-mode
  :vc (:url "https://github.com/50ways2sayhard/dart-ts-mode")
  :ensure t)

(use-package flutter
  :bind
  (:map dart-ts-mode-map
        ([remap compile] . flutter-run-or-hot-reload)
        ("C-c C-c" . flutter-run-or-hot-reload))
  :config
  (defcustom gs-101/flutter-hot-reload-mode-lighter " Flutter Hot Reload"
    "Lighter for `gs-101/flutter-hot-reload-mode'."
    :type '(choice :tag "Lighter" (const :tag "No lighter" nil) string)
    :group 'flutter)

  (define-minor-mode gs-101/flutter-hot-reload-mode
    "Minor mode for running hot reload on save.

Only runs if a `flutter' buffer already exits."
    :lighter gs-101/flutter-hot-reload-mode-lighter
    (if (and gs-101/flutter-hot-reload-mode (get-buffer "*Flutter*"))
        (add-hook 'after-save-hook #'flutter-hot-reload nil 'local)
      (remove-hook 'after-save-hook #'flutter-hot-reload 'local)))
  :ensure t
  :hook
  (dart-ts-mode . gs-101/flutter-hot-reload-mode))

(use-package go-ts-mode
  :bind
  (:map go-ts-mode-map
        ("C-c m t f" . go-ts-mode-test-this-file)
        ("C-c m t p" . go-ts-mode-test-this-package)
        ("C-c m t ." . go-ts-mode-test-this-function-at-point)))

(use-package haskell-ts-mode
  :vc (:url "https://codeberg.org/pranshu/haskell-ts-mode")
  :ensure t)

(use-package hyprlang-ts-mode
  :vc (:url "https://github.com/Nathan-Melaku/hyprlang-ts-mode")
  :ensure t)

(use-package just-ts-mode
  :vc (:url "https://github.com/leon-barrett/just-ts-mode.el")
  :ensure t)

(use-package kdl-mode
  :vc (:url "https://github.com/taquangtrung/emacs-kdl-mode")
  :ensure t)

(use-package kotlin-ts-mode
  :vc (:url "https://gitlab.com/bricka/emacs-kotlin-ts-mode")
  :ensure t)

(use-package auctex
  :ensure t
  :custom
  (reftex-plug-into-AUCTeX t)
  :hook
  (LaTeX-mode . turn-on-reftex))

(use-package tex
  :custom
  (TeX-auto-local ".auto")
  (TeX-auto-save t)
  (TeX-master 'dwim)
  (TeX-parse-self t))

(use-package lisp
  :bind
  ("C-M-z" . delete-pair)
  ("C-M-r" . raise-sexp)
  (:map lisp-mode-map
        ("C-c C-p" . run-lisp))
  :custom
  (delete-pair-blink-delay 0)
  (delete-pair-push-mark t)
  (inferior-lisp-program "sbcl")
  (narrow-to-defun-include-comments t))

(use-package slime
  :vc (:url "https://github.com/slime/slime")
  :bind (:map slime-mode-map
              ("C-h f" . slime-describe-function)
              ("C-h v" . slime-describe-symbol))
  :ensure t)

(use-package cmuscheme
  :bind
  (:map scheme-mode-map
        ("C-c C-p" . "run-scheme")))

(use-package arei
  :when dw/guix-p
  :vc (:url "https://git.sr.ht/~abcdw/emacs-arei")
  :after scheme
  :ensure t)

(use-package meson-mode
  :vc (:url "https://github.com/wentasah/meson-mode")
  :ensure t)

(use-package nix-ts-mode
  :vc (:url "https://github.com/nix-community/nix-ts-mode")
  :ensure t)

(use-package qml-ts-mode
  :vc (:url "https://github.com/xhcoding/qml-ts-mode")
  :ensure t)

(use-package python
  :custom
  (python-indent-guess-indent-offset-verbose nil)
  (python-shell-completion-native-enable nil))

(use-package r-ts-mode
  :vc (:url "https://codeberg.org/R-for-emacs/r-ts-mode")
  :ensure t)

(use-package cargo-transient
  :vc (:url "https://github.com/peterstuart/cargo-transient")
  :after rust-ts-mode
  :bind
  (:map rust-ts-mode-map
        ("C-c C-c" . compile)
        ("C-c C-p" . cargo-transient))
  :ensure t
  :custom
  (cargo-transient-buffer-name-function #'project-prefixed-buffer-name))

(use-package sh-script
  :bind
  (:map bash-ts-mode-map
        ("C-c C-p" . ansi-shell))
  (:map sh-mode-map
        ("C-c C-p" . ansi-shell)))

(use-package spice-mode
  :vc (:url "https://github.com/emacsmirror/spice-mode")
  :ensure t)

(use-package svelte-ts-mode
  :vc (:url "https://github.com/leafOfTree/svelte-ts-mode")
  :ensure t)

(use-package verilog-ts-mode
  :vc (:url "https://github.com/gmlarumbe/verilog-ts-mode")
  :ensure t)

(use-package vue-ts-mode
  :vc (:url "https://github.com/8uff3r/vue-ts-mode")
  :ensure t)

(use-package zig-ts-mode
  :vc (:url "https://codeberg.org/meow_king/zig-ts-mode")
  :ensure t)

(use-package apheleia
  :vc (:url "https://github.com/radian-software/apheleia")
  :ensure t
  :hook
  (prog-mode . apheleia-mode))

(use-package cov
  :vc (:url "https://github.com/AdamNiederer/cov")
  :ensure t)

(use-package dape
  :vc (:url "https://github.com/svaante/dape")
  :ensure t
  :hook
  (dape-display-source . pulse-momentary-highlight-one-line))

(use-package debbugs
  :ensure t)

(use-package git-modes
  :vc (:url "https://github.com/magit/git-modes")
  :ensure t)

(use-package leetcode
  :vc (:url "https://github.com/kaiwk/leetcode.el")
  :custom
  (leetcode-directory "~/Projects/study/leetcode-solutions/")
  (leetcode-save-solutions t)
  :ensure t)

(use-package magit
  ;; Requires perl for some rebasing commands.
  :ensure-system-package
  perl
  :bind
  ("C-c v" . magit-dispatch)
  (:map project-prefix-map
        ("v" . magit))
  :config
  (magit-add-section-hook 'magit-status-sections-hook #'magit-insert-worktrees nil t)
  :custom
  (magit-diff-fontify-hunk t)
  (magit-diff-refine-hunk t)
  (magit-diff-use-indicator-faces t)
  :ensure t
  :hook
  (magit-process-find-password-functions . magit-process-password-auth-source)
  :preface
  (setq magit-diff-specify-hunk-foreground nil))

(use-package forge
  :after magit
  :ensure t
  :config
  (remove-hook 'forge-post-mode-hook #'turn-on-flyspell))

(use-package magit-git-toolbelt
  :vc (:url "https://github.com/jonathanchu/magit-git-toolbelt")
  :after magit
  :ensure t)

(use-package package-lint
  :ensure t)

(use-package package-lint-flymake
  :after package-lint flymake
  :ensure t
  :hook
  (emacs-lisp-mode . package-lint-flymake-setup))

(use-package wakatime-mode
  :ensure-system-package
  (wakatime-cli . wakatime)
  :vc (:url "https://github.com/wakatime/wakatime-mode")
  :ensure t
  :init
  (global-wakatime-mode))

;;; ============================================================================
;;; Completion
;;; ============================================================================

(use-package cape
  :vc (:url "https://github.com/minad/cape")
  :ensure t
  :custom
  (cape-file-prefix "/")
  :hook
  (completion-at-point-functions . cape-dabbrev)
  (completion-at-point-functions . cape-file))

(use-package tempel
  :vc (:url "https://github.com/minad/tempel")
  :ensure t
  :hook
  (completion-at-point-functions . tempel-complete))

(use-package lsp-snippet
  :after tempel eglot
  :vc (:url "https://github.com/svaante/lsp-snippet")
  :config
  (lsp-snippet-tempel-eglot-init))

(use-package tempel-snippets
  :vc (:url "https://git.gs-101.dev/gs-101/tempel-snippets")
  :after tempel
  :ensure t)

(use-package vertico
  :custom
  (vertico-cycle t)
  :ensure t
  :init
  (vertico-mode)
  (vertico-multiform-mode))

(use-package vertico-directory
  :after vertico
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char)
        ("M-DEL" . vertico-directory-delete-word))
  :hook
  (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package vertico-multiform
  :after vertico
  :config
  :custom
  (vertico-multiform-categories
   '((symbol (vertico-sort-function . vertico-sort-alpha))
     (file (vertico-sort-function . vertico-sort-directories-first)))))

(use-package marginalia
  :vc (:url "https://github.com/minad/marginalia")
  :ensure t
  :init
  (marginalia-mode))

;;; ============================================================================
;;; Utilities
;;; ============================================================================

(use-package consult
  :vc (:url "https://github.com/minad/consult")
  :bind
  (([remap bookmark-jump] . consult-bookmark)
   ([remap flymake-start] . consult-flymake)
   ([remap goto-line] . consult-goto-line)
   ([remap grep] . consult-grep)
   ([remap imenu] . consult-imenu)
   ([remap info] . consult-info)
   ([remap info-search] . consult-info)
   ([remap kmacro-menu] . consult-kmacro)
   ([remap list-buffers] . consult-buffer)
   ([remap load-theme] . consult-theme)
   ([remap locate] . consult-locate)
   ([remap man] . consult-man)
   ([remap pop-global-mark] . consult-global-mark)
   ([remap pop-to-mark-command] . consult-mark)
   ([remap project-find-regexp] . consult-grep)
   ([remap project-list-buffers] . consult-project-buffer)
   ([remap project-switch-to-buffer] . consult-project-buffer)
   ([remap recentf] . consult-recent-file)
   ([remap rgrep] . consult-ripgrep)
   ([remap switch-to-buffer] . consult-buffer)
   ([remap switch-to-buffer-other-frame] . consult-buffer-other-frame)
   ([remap switch-to-buffer-other-tab] . consult-buffer-other-tab)
   ([remap switch-to-buffer-other-window] . consult-buffer-other-window)
   ([remap vc-git-grep] . consult-git-grep)
   ([remap yank-from-kill-ring] . consult-yank-from-kill-ring)
   ([remap yank-pop] . consult-yank-pop)
   ([remap execute-extended-command-for-buffer] . consult-mode-command)
   ("M-g I" . consult-imenu-multi))
  :config
  (defun oantolin/choose-completion-in-region ()
    "Use default `completion--in-region' unless we are not completing."
    (when minibuffer-completion-table
      (setq-local completion-in-region-function #'completion--in-region)))

  (advice-add #'register-preview :override #'consult-register-window)

  (setf (alist-get 'log-edit-mode consult-mode-histories)
        'log-edit-comment-ring)

  (defvar-keymap minad/consult-line-map
    :doc "History keymap which is added to the local `consult-line' map."
    "C-s" #'previous-history-element)

  (consult-customize consult-line :keymap minad/consult-line-map)
  :custom
  (register-preview-function #'consult-register-format)
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  (completion-in-region-function 'consult-completion-in-region)
  :ensure t
  :hook
  (minibuffer-setup . oantolin/choose-completion-in-region))

(use-package ast-grep
  :vc (:url "https://github.com/SunskyXH/ast-grep.el")
  :ensure-system-package
  ast-grep
  :ensure t
  :bind
  ("M-s g a" . ast-grep-search))

(use-package consult-notmuch
  :vc (:url "https://codeberg.org/jao/consult-notmuch")
  :after notmuch
  :ensure t)

(use-package consult-xref-stack
  :vc (:url "https://github.com/brett-lempereur/consult-xref-stack")
  :bind
  ([remap xref-go-back] . consult-xref-stack-backward)
  ([remap xref-go-forward] . consult-xref-stack-forward)
  :ensure t)

(use-package bluetooth
  :vc (:url "https://codeberg.org/rstocker/emacs-bluetooth")
  :ensure t
  :custom
  (bluetooth-battery-display-warning nil))

(use-package embark
  :vc (:url "https://github.com/oantolin/embark")
  :bind
  ([remap describe-bindings]. embark-bindings)
  ("C-;" . embark-act)
  (:map embark-collect-mode-map
        ("j" . goto-char))
  :custom
  (embark-indicators
       '(embark-minimal-indicator
         embark-highlight-indicator
         embark-isearch-highlight-indicator)
  (embark-prompter 'embark-completing-read-prompter)
  (prefix-help-command #'embark-prefix-help-command)
  ;; Disable quitting after killing a buffer in an action
  (embark-quit-after-action '((kill-buffer . nil)))
  :ensure t))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package dwim-shell-command
  :vc (:url "https://github.com/xenodium/dwim-shell-command")
  :ensure t
  :bind
  (([remap shell-command] . dwim-shell-command)
   :map dired-mode-map
   ([remap dired-do-async-shell-command] . dwim-shell-command)
   ([remap dired-do-shell-command] . dwim-shell-command)
   ([remap dired-smart-shell-command] . dwim-shell-command)))

(use-package dwim-shell-commands
  :ensure-system-package
  (atool unzip)
  :after dwim-shell-command)

(use-package ghostel
  :vc (:url "https://github.com/dakra/ghostel")
  :ensure t
  :bind
  ("C-c c" . ghostel-compile)
  ("C-c C" . ghostel-recompile)
  ("C-c t s" . ghostel)
  (:map project-prefix-map
        ("c" . ghostel-compile)
        ("s" . ghostel-project))
  :custom
  (ai-code-backends-infra-terminal-backend 'ghostel))

(use-package popper
  :vc (:url "https://github.com/karthink/popper")
  :bind
  ("C-z <prior>" . popper-toggle)
  ("C-z <next>" . popper-cycle)
  ("C-z <home>" . popper-toggle-type)
  :custom
  (popper-display-control t)
  (popper-reference-buffers '(cider-repl-mode
                              compilation-mode
                              eat-mode
                              eshell-mode
                              flutter-mode
                              geiser-repl-mode
                              (lambda (buf)
                                (with-current-buffer buf
                                  (and (derived-mode-p 'ghostel-mode)
                                       (not
                                        (string-match-p "\\*antigravity.*"
                                                        (buffer-name buf))))))
                              vterm-mode
                              inferior-emacs-lisp-mode
                              inferior-ess-r-mode
                              inferior-lisp-mode
                              inferior-python-mode
                              inferior-scheme-mode
                              shell-mode
                              slime-repl-mode
                              arei-connection-mode
                              "\\*ansi-term\\*"
                              "\\*Async Shell Command\\*"
                              "\\*Backtrace\\*"
                              "\\*compilation\\*"
                              "\\*Dtache Shell Command\\*"
                              "\\*eldoc\\*"
                              "\\*Ement Notifications\\*"
                              "*Flymake diagnostics.*"
                              "\\*GDB.*out\\*"
                              "\\*Messages\\*"
                              "\\*mu4e-update\\*"
                              "Output\\*$"
                              "^*tex"
                              "\\*Warnings\\*"
                              "\\*xref\\*"))
  :ensure t
  :demand t
  :init
  (popper-mode)
  (popper-echo-mode))

(use-package uniline
  :vc (:url "https://github.com/tbanel/uniline")
  :bind
  ("C-z i l" . uniline-mode)
  :ensure t)

;;; ============================================================================
;;; Chat & Mail
;;; ============================================================================

(use-package message
  :custom
  (message-kill-buffer-on-exit t)
  (message-mail-user-agent t)
  (message-send-mail-function #'message-send-mail-with-sendmail))

(use-package smtpmail
  :custom
  (smtpmail-local-domain "gabrielsantosdesouza")
  (smtpmail-smtp-service 465)
  (smtpmail-stream-type 'ssl)
  (smtpmail-smtp-server "disroot.org"))

(use-package notmuch
  :ensure t
  :custom
  (notmuch-show-logo nil))

(use-package notmuch-transient
  :vc (:url "https://github.com/tarsius/notmuch-transient")
  :ensure t)

;;; ============================================================================
;;; Elfeed
;;; ============================================================================

(use-package elfeed
  :vc (:url "https://github.com/skeeto/elfeed")
  :bind
  (:map elfeed-search-mode-map
        ("R" . kaushal-modi/elfeed-search-mark-all-as-read)
        ("B" . karthinks/elfeed-search-eww-open))
  (:map elfeed-show-mode-map
        ("C-c C-o" . shr-browse-url)
        ("B" . karthinks/elfeed-show-eww-open))
  :config
  ;; https://emacs.stackexchange.com/a/2441
  (defun kaushal-modi/elfeed-search-mark-all-as-read ()
    "Call `mark-whole-buffer' and `elfeed-search-untag-all-undead' in unison,
marking all current messages as read."
    (interactive)
    (mark-whole-buffer)
    (elfeed-search-untag-all-unread))

  (defun karthinks/elfeed-show-eww-open (&optional use-generic-p)
    "Open elfeed show entry with \\[eww]."
    (interactive "P")
    (let ((browse-url-browser-function #'eww-browse-url))
      (elfeed-show-visit use-generic-p)))

  (defun karthinks/elfeed-search-eww-open (&optional use-generic-p)
    "Open elfeed search entry with \\[eww]."
    (interactive "P")
    (let ((browse-url-browser-function #'eww-browse-url))
      (elfeed-search-browse-url use-generic-p)))
  :ensure t)

(use-package elfeed-protocol
  :vc (:url "https://github.com/fasheng/elfeed-protocol")
  :ensure t
  :after elfeed
  :config
  (elfeed-protocol-enable)
  :custom
  (elfeed-feeds
   '(("fever+https://gabriel@miniflux.gs-101.dev/"
      :api-url "https://miniflux.gs-101.dev/fever/"
      :use-authinfo t))))

;;; ============================================================================
;;; LLMs & AI
;;; ============================================================================

(use-package agent-shell
  :vc (:url "https://github.com/xenodium/agent-shell")
  :ensure t
  :bind
  ("C-c a " . agent-shell)
  :init
  (with-eval-after-load 'envrc
    (advice-add 'agent-shell :around #'envrc-propagate-environment))
  :custom
  (agent-shell-prefer-viewport-interaction t)
  (agent-shell-preferred-agent-config 'antigravity)
  (agent-shell-show-cost-indicator 't))

(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el")
  :ensure t
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :custom
  (copilot-indent-offset-warning-disable t))

;;; ============================================================================
;;; User Interface & Themes
;;; ============================================================================

(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'relative)
  :hook
  (prog-mode . display-line-numbers-mode))

(use-package scroll-bar
  :custom
  (scroll-bar-mode nil))

(use-package window
  :custom
  (recenter-positions '(top middle bottom)) ; 2
  (scroll-error-top-bottom t) ; 1
  (split-height-threshold nil) ;1
  (split-width-threshold 170) ; 1
  ;; 2
  (switch-to-buffer-obey-display-actions t))

(use-package auto-dark
  :vc (:url "https://github.com/LionyxML/auto-dark-emacs")
  :unless (or dw/guix-p gs-101/nixos-p)
  :ensure t
  :custom
  (auto-dark-themes '((modus-vivendi) (modus-operandi)))
  :init
  (auto-dark-mode))

(use-package modus-themes
  :unless (or dw/guix-p gs-101/nixos-p)
  :custom
  (modus-themes-bold-constructs t)
  (modus-themes-italic-constructs t)
  (modus-themes-mixed-fonts t)
  (modus-themes-variable-pitch-ui t)
  (modus-themes-completions
   '((matches . (semibold))
     (selection . (extrabold underline)))))

(when (or dw/guix-p gs-101/nixos-p)
  (add-to-list 'custom-theme-load-path (expand-file-name "themes/" user-emacs-directory))
  (load-theme 'noctalia t))

(use-package nerd-icons
  :vc (:url "https://github.com/rainstormstudio/nerd-icons.el")
  :bind
  ("C-z i n" . nerd-icons-insert)
  :config
  (with-eval-after-load 'citar
    (defvar citar-indicator-cited-icons
      (citar-indicator-create
       :symbol (nerd-icons-mdicon
                "nf-md-record"
                :face 'nerd-icons-lgreen)
       :function #'citar-is-cited
       :padding "  "
       :tag "is:cited"))

    (defvar citar-indicator-files-icons
      (citar-indicator-create
       :symbol (nerd-icons-mdicon
                "nf-md-file"
                :face 'nerd-icons-blue
                :v-adjust -0.1)
       :function #'citar-has-files
       :padding "  " ; need this because the default padding is too low for these icons
       :tag "has:files"))

    (defvar citar-indicator-links-icons
      (citar-indicator-create
       :symbol (nerd-icons-mdicon
                "nf-md-link"
                :face 'nerd-icons-lblue
                :v-adjust 0.01)
       :function #'citar-has-links
       :padding "  "
       :tag "has:links"))

    (defvar citar-indicator-notes-icons
      (citar-indicator-create
       :symbol (nerd-icons-mdicon
                "nf-md-text"
                :face 'nerd-icons-blue
                :v-adjust -0.3)
       :function #'citar-has-notes
       :padding "    "
       :tag "has:notes"))
    (setq citar-indicators
          (list citar-indicator-cited-icons
                citar-indicator-files-icons
                citar-indicator-links-icons
                citar-indicator-notes-icons)))

  (with-eval-after-load 'eglot
    (setq eglot-code-action-indicator "󰌵"))

  (with-eval-after-load 'go-ts-mode
    (add-hook 'go-ts-mode-hook #'prettify-symbols-mode)
    (add-hook 'go-ts-mode-hook
              (lambda ()
                (push '(":=" . ?) prettify-symbols-alist)
                (push '("go" . ?󰟓) prettify-symbols-alist))))

  (with-eval-after-load 'magit
    (setq magit-format-file-function #'magit-format-file-nerd-icons))

  (with-eval-after-load 'ready-player
    (setq ready-player-autoplay-icon "󰼛"
          ready-player-help-icon "󰋖"
          ready-player-next-icon "󰒭"
          ready-player-open-externally-icon "󰒖"
          ready-player-open-my-media-collection-icon "󰋜"
          ready-player-play-icon "󰐊"
          ready-player-previous-icon "󰒮"
          ready-player-repeat-icon "󰑖"
          ready-player-search-icon "󰍉"
          ready-player-shuffle-icon "󰒝"
          ready-player-stop-icon "󰓛"))
  :demand t
  :ensure t)

(use-package nerd-icons-completion
  :vc (:url "https://github.com/rainstormstudio/nerd-icons-completion")
  :after nerd-icons
  :ensure t
  :config
  (nerd-icons-completion-mode)
  :hook
  (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :vc (:url "https://github.com/rainstormstudio/nerd-icons-dired")
  :after nerd-icons
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-grep
  :vc (:url "https://github.com/hron/nerd-icons-grep")
  :after nerd-icons
  :ensure t
  :hook
  (grep-mode . nerd-icons-grep-mode))

(use-package nerd-icons-ibuffer
  :vc (:url "https://github.com/seagle0128/nerd-icons-ibuffer")
  :after nerd-icons
  :ensure t
  :hook
  (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package prism
  :vc (:url "https://github.com/alphapapa/prism.el")
  :ensure t
  :hook
  (prog-mode . prism-mode))

(provide 'init)
;;; init.el ends here
