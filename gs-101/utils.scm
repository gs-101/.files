(define-module (gs-101 utils)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:export (string-append-n
            file-command
            file-command*))

;; Just adds a newline after a string.
(define (string-append-n . args)
  (let ((result (map (lambda (arg) (string-append arg "\n"))
                     args)))
    (string-join result "")))

;; Use package's PACKAGE binary for a command call.  An optional BINARY argument
;; can be passed, in case the package's binary has a different name to the
;; source package.
(define* (file-command package #:optional (binary package))
  (file-append (specification->package package) (string-append "/bin/" binary)))

;; Like file-command, but adds a space after the command so we can comfortably
;; use commands with subcommands.
(define* (file-command* package #:optional (binary package))
  (file-append (specification->package package) (string-append "/bin/" binary " ")))
