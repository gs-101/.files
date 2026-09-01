;;; -*- lexical-binding: t -*-

(use-package agent-shell
  :vc (:url "https://github.com/xenodium/agent-shell")
  :ensure t
  :bind
  ("C-c a " . agent-shell)
  :config
  (setq agent-shell-antigravity-environment (agent-shell-make-environment-variables :inherit-env t))
  :custom
  (agent-shell-preferred-agent-config 'antigravity))

(use-package agent-shell-permission-transient
  :vc (:url "https://github.com/Jamie-Cui/agent-shell-permission-transient")
  :ensure t
  :after agent-shell
  :bind (:map agent-shell-mode-map
              ("C-c C-p" . agent-shell-permission-transient-menu))
  :config
  (agent-shell-permission-transient-mode))

(provide 'gs-llm)
