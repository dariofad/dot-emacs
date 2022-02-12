;; set default to python3
(setq python-shell-interpreter "python3")

;; built-in utilities
(use-package python
  :ensure t)

;; to install the dedicated server
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

;; start lsp when in python mode
(add-hook 'python-mode-hook 'ddslsp/dariofad-Start-LSP-mode)
