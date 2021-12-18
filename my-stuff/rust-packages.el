(use-package rust-mode
  :ensure t)

(add-hook 'rust-mode-hook #'lsp-deferred)
