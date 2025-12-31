;;; Modus Themes Colors --- Generated with Matugen -*- lexical-binding: t; -*-

(use-package modus-themes
  :custom
  (modus-operandi-palette-overrides
    `((bg-main "{{colors.surface.light.hex}}")
       (bg-dim "{{colors.surface_dim.light.hex}}")
       (fg-main "{{colors.on_surface.light.hex}}")
       (fg-dim "{{colors.on_surface_variant.light.hex}}")
       (fg-alt "{{colors.outline.light.hex | set_lightness: -20.0}}")
       (bg-active "{{colors.primary.light.hex}}")
       (fg-active "{{colors.on_primary.light.hex}}")
       (bg-inactive bg-dim)
       (fg-inactive fg-dim)
       (border bg-main)
       (bg-completion bg-main)
       (fg-completion "{{colors.shadow.light.hex}}")
       (bg-hover "{{colors.primary.light.hex}}")
       (fg-hover "{{colors.on_primary.light.hex}}")
       (bg-region bg-hover)
       (fg-region fg-hover)
       (bg-mode-line-active bg-dim)
       (fg-mode-line-active fg-dim)
       (border-mode-line-active bg-main)
       (border-mode-line-inactive bg-main)
       (bg-mode-line-inactive bg-main)
       (fg-mode-line-inactive fg-main)
       (modeline-err red)
       (modeline-warning warning)
       (modeline-info info)
       (bg-tab-bar "{{colors.surface_container.light.hex}}")
       (bg-tab-bar-current bg-main)
       (bg-tab-other bg-dim)
       (accent-0 "{{colors.primary.light.hex}}")
       (accent-1 "{{colors.secondary.light.hex}}")
       (accent-2 "{{colors.tertiary.light.hex}}")
       (accent-3 "{{colors.tertiary.light.hex | set_lightness: -20.0}}")
       (fg-line-number-active fg-active)
       ;; Colors from Catppuccin Mocha.
       (rainbow-0 "#f2cdcd") ; Flamingo.
       (rainbow-1 "#f38ba8") ; Red.
       (rainbow-2 "#eba0ac") ; Maroon.
       (rainbow-3 "#fab387") ; Peach.
       (rainbow-4 "#f9e2af") ; Yellow.
       (rainbow-5 "#a6e3a1") ; Green.
       (rainbow-6 "#89dceb") ; Sky.
       (rainbow-7 "#1e66f5") ; Blue.
       (rainbow-8 "#cba6f7") ; Mauve.
       (fg-heading-0 rainbow-0)
       (fg-heading-1 rainbow-1)
       (fg-heading-2 rainbow-2)
       (fg-heading-3 rainbow-3)
       (fg-heading-4 rainbow-4)
       (fg-heading-5 rainbow-5)
       (fg-heading-6 rainbow-6)
       (fg-heading-7 rainbow-7)
       (fg-heading-8 rainbow-8)
       (bg-paren-match unspecified)))
  (modus-vivendi-palette-overrides
    `((bg-main "{{colors.surface.dark.hex}}")
       (bg-dim "{{colors.surface_dim.dark.hex}}")
       (fg-main "{{colors.on_surface.dark.hex}}")
       (fg-dim "{{colors.on_surface_variant.dark.hex}}")
       (fg-alt "{{colors.outline.dark.hex | set_lightness: -20.0}}")
       (bg-active "{{colors.primary.dark.hex}}")
       (fg-active "{{colors.on_primary.dark.hex}}")
       (bg-inactive bg-dim)
       (fg-inactive fg-dim)
       (border bg-main)
       (bg-completion bg-main)
       (fg-completion "{{colors.shadow.dark.hex}}")
       (bg-hover "{{colors.primary.dark.hex}}")
       (fg-hover "{{colors.on_primary.dark.hex}}")
       (bg-region bg-hover)
       (fg-region fg-hover)
       (bg-mode-line-active bg-dim)
       (fg-mode-line-active fg-dim)
       (border-mode-line-active bg-main)
       (border-mode-line-inactive bg-main)
       (bg-mode-line-inactive bg-main)
       (fg-mode-line-inactive fg-main)
       (modeline-err red)
       (modeline-warning warning)
       (modeline-info info)
       (bg-tab-bar "{{colors.surface_container.dark.hex}}")
       (bg-tab-bar-current bg-main)
       (bg-tab-other bg-dim)
       (accent-0 "{{colors.primary.dark.hex}}")
       (accent-1 "{{colors.secondary.dark.hex}}")
       (accent-2 "{{colors.tertiary.dark.hex}}")
       (accent-3 "{{colors.tertiary.dark.hex | set_lightness: -20.0}}")
       (fg-line-number-active fg-active)
       ;; Colors from Catppuccin Mocha.
       (rainbow-0 "#f2cdcd") ; Flamingo.
       (rainbow-1 "#f38ba8") ; Red.
       (rainbow-2 "#eba0ac") ; Maroon.
       (rainbow-3 "#fab387") ; Peach.
       (rainbow-4 "#f9e2af") ; Yellow.
       (rainbow-5 "#a6e3a1") ; Green.
       (rainbow-6 "#89dceb") ; Sky.
       (rainbow-7 "#1e66f5") ; Blue.
       (rainbow-8 "#cba6f7") ; Mauve.
       (fg-heading-0 rainbow-0)
       (fg-heading-1 rainbow-1)
       (fg-heading-2 rainbow-2)
       (fg-heading-3 rainbow-3)
       (fg-heading-4 rainbow-4)
       (fg-heading-5 rainbow-5)
       (fg-heading-6 rainbow-6)
       (fg-heading-7 rainbow-7)
       (fg-heading-8 rainbow-8)
       (bg-paren-match unspecified))))
