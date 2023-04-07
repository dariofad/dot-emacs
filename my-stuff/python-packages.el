;; set default to python3
(setq python-shell-interpreter "python3")

;; major mode
(use-package python
  :ensure t)

;; dedicated server
;; prerequisite: npm
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

;; hook lsp to python mode
(add-hook 'python-mode-hook 'ddslsp/dariofad-Start-LSP-mode)

;; auto-sort-imports on save
;; prerequisite: isort (installed globally with pip)
(defun dd-lsp-py-isort-buffer ()
  (when (and (executable-find "isort") buffer-file-name)
    (call-process "isort" nil nil nil "-i" buffer-file-name)))
(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'dd-lsp-py-isort-buffer nil 'local)))

;; auto-format on save
;; prerequisite: yapf (installed globally with pip)
(defun dd-lsp-py-format-buffer ()
  (when (and (executable-find "yapf") buffer-file-name)
    (call-process "yapf" nil nil nil "-i" buffer-file-name)))
(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'dd-lsp-py-format-buffer nil 'local)))
