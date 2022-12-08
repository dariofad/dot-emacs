;; default environment options
(setenv "PATH"
  (concat
   "/usr/local/go/bin" ":"
   "/home/dariofad/go/bin" ":"
   (getenv "PATH")
  )
  )
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/home/dariofad/go/bin")

;; major mode
(use-package go-mode
  :ensure t)

;; from the official documentation
(add-hook 'go-mode-hook #'lsp-deferred)
;; auto-format on save
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
