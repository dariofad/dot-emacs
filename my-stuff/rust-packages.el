;; major mode
(use-package rust-mode
  :ensure t
  :config

  ;; auto-format on save
  (setq rust-format-on-save t)
  )

;; hook lsp to rust mode
(add-hook 'rust-mode-hook #'lsp-deferred)
