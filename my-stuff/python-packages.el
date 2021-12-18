 (use-package python
   :ensure t)

(setq python-shell-interpreter "python3")

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

(add-hook 'python-mode-hook 'ddslsp/dariofad-Start-LSP-mode)
