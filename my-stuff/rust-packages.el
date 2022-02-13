;; editing rust files
(use-package rust-mode
  :ensure t
  :config

  ;; enable auto formatting on save
  (setq rust-format-on-save t)
  )

;; start lsp when in rust mode
(add-hook 'rust-mode-hook #'lsp-deferred)
