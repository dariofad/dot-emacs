;; setting the environment (default options)
;; path
(setenv "PATH"
  (concat
   "/usr/local/go/bin" ":"
   "/home/dariofad/go/bin" ":"
   (getenv "PATH")
  )
)
;; exec-path
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/home/dariofad/go/bin")

;; client
(use-package go-mode
  :ensure t)

;; from the official gopls documentation
;; start lsp when in go mode
(add-hook 'go-mode-hook #'lsp-deferred)
;; format the file when the buffer is saved
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
