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

(use-package agent-recall
  :vc (:url "https://github.com/mrx-xo/agent-recall")
  :ensure t
  :custom
  (agent-recall-search-paths '("~/.files" "~/Projects"))
  :hook
  (agent-shell-mode . agent-recall-track-sessions))

(use-package agent-recall
  :after agent-recall consult
  :custom
  (agent-recall-search-function 'consult-ripgrep))

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
