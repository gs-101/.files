;;; -*- lexical-binding: t -*-

(defcustom gs-101/modules-directory (expand-file-name "modules" user-emacs-directory)
  "Path for this configuration's modules."
  :type 'directory)

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

(with-eval-after-load 'package
  (dolist (archive '(("melpa" . "https://melpa.org/packages/")))
    (add-to-list 'package-archives archive)))
