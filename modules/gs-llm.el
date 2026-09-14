;;; -*- lexical-binding: t -*-

(use-package agent-shell
  :vc (:url "https://github.com/xenodium/agent-shell")
  :ensure t
  :bind
  ("C-c a " . agent-shell)
  :config
  (setq agent-shell-antigravity-environment (agent-shell-make-environment-variables :inherit-env t))
  :custom
  (agent-shell-prefer-viewport-interaction t)
  (agent-shell-preferred-agent-config 'antigravity))

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

(provide 'gs-llm)
