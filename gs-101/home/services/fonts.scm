(define-module (gs-101 home services fonts)
  #:use-module (gnu home services)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu packages fonts)
  #:use-module (gnu services)
  #:use-module (selected-guix-works packages fonts)
  #:export (home-fonts-services))

(define (home-fonts-profile-service config)
  (list font-alcarin-tengwar
        font-aporetic
        font-google-noto
        font-google-noto-emoji
        font-google-noto-sans-cjk
        font-google-noto-serif-cjk
        font-microsoft-cascadia
        font-nerd-fonts-symbols))

(define home-fonts-service-type
  (service-type (name 'home-fonts)
                (description "Service containing font packages.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-fonts-profile-service)))
                (default-value #f)))

(define home-fonts-services
  (list (service home-fonts-service-type)
        (simple-service 'home-fontconfig-service
                        home-fontconfig-service-type
                        ;; Includes suggestions from
                        ;; https://fontconfig.pages.freedesktop.org/fontconfig/fontconfig-user.html
                        (list
                         ;; Alias deprecated mono to monospace.
                         '(match (@ (target "pattern"))
                            (test (@ (qual "any") (name "family"))
                                  (string "mono"))
                            (edit (@ (name "family") (mode "assign"))
                                  (string "monospace")))
                         ;; Not recognized aliases default to the sans-serif font.
                         '(match (@ (target "pattern"))
                            (test (@ (qual "all") (name "family") (compare "not_eq"))
                                  (string "sans-serif"))
                            (test (@ (qual "all") (name "family") (compare "not_eq"))
                                  (string "serif"))
                            (test (@ (qual "all") (name "family") (compare "not_eq"))
                                  (string "monospace"))
                            (edit (@ (name "family") (mode "append_last"))
                                  (string "sans-serif")))
                         '(alias
                           (family "monospace")
                           (prefer
                            (family "Cascadia Mono")
                            ;; General fallback.
                            (family "Noto Sans Mono")
                            ;; Simplified Chinese.
                            (family "Noto Sans Mono CJK SC")
                            ;; Japanese.
                            (family "Noto Sans Mono CJK JP")
                            ;; Korean.
                            (family "Noto Sans Mono CJK KR")
                            ;; The Lord of the Rings language font.
                            (family "Alcarin Tengwar")
                            ;; Nerd Fonts Symbols.
                            (family "Symbols Nerd Font Mono")))
                         '(alias
                           (family "serif")
                           (prefer
                            (family "Aporetic Serif")
                            ;; General fallback.
                            (family "Noto Serif")
                            ;; Simplified Chinese.
                            (family "Noto Serif CJK SC")
                            ;; Japanese.
                            (family "Noto Serif CJK JP")
                            ;; Korean.
                            (family "Noto Serif CJK KR")
                            ;; The Lord of the Rings language font.
                            (family "Alcarin Tengwar")
                            ;; Nerd Fonts Symbols.
                            (family "Symbols Nerd Font")))
                         '(alias
                           (family "sans-serif")
                           (prefer
                            (family "Aporetic Sans")
                            ;; General fallback.
                            (family "Noto Sans")
                            ;; Simplified Chinese.
                            (family "Noto Sans CJK SC")
                            ;; Japanese.
                            (family "Noto Sans CJK JP")
                            ;; Korean.
                            (family "Noto Sans CJK KR")
                            ;; The Lord of the Rings language font.
                            (family "Alcarin Tengwar")
                            ;; Nerd Fonts Symbols.
                            (family "Symbols Nerd Font")))
                         '(alias
                           (family "emoji")
                           (prefer
                            (family "Noto Color Emoji")))))))
