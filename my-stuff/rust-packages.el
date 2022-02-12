(use-package rust-mode
  :ensure t)

;; start lsp when in rust mode
(add-hook 'rust-mode-hook #'lsp-deferred)
