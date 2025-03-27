(define-module (utils)
  #:use-module (guix gexp)
  #:export (dotfiles-file))

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
