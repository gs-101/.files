(define-module (utils)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:export (dotfiles-file
            comment
            file-command
            string-append-n))

;; Return a file from the dotfiles directory.
;; This function was created because local-file doesn't support the use
;; of "~" or even environment variables, which is fair because the root
;; user might not have access to them.
;; FILE is a file located under the "~/.files/" directory. Note how
;; ".files" is suffixed with "/".  That makes a better exprerience when
;; referring to files.
;; If the FILE NAME starts with ".", the character will be removed from
;; the name, as the store doesn't support hidden files or directories.
(define* (dotfiles-file file #:optional (name (basename file))
                        #:key (recursive? #f))
  (let ((DOTFILES (string-append "/home/" (getlogin) "/.files/")))
    (local-file (string-append DOTFILES file)
                (if (string-prefix? "." name)
                    (string-drop name 1)
                    name)
                #:recursive? recursive?)))

;; Just adds a newline after the string.
(define (string-append-n . args)
  (let ((result (map (lambda (arg) (string-append arg "\n"))
                     args)))
    (string-join result "")))

;; Use package's PACKAGE binary for a command call.  An optional BINARY argument
;; can be passed, in case the package's binary has a different name to the
;; source package.
(define* (file-command package #:optional (binary package))
  (file-append (specification->package package) (string-append "/bin/" binary)))
