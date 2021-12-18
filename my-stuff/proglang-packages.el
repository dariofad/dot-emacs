(use-package flycheck
  :ensure t
  )

(use-package yasnippet
  :ensure t
  )

;; company for autocompletion
(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (company-mode))))
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  :diminish company-mode
  :defines
  (company-dabbrev-ignore-case company-dabbrev-downcase)
  :bind
  (:map company-active-map
	("C-n" . company-select-next)
	("C-p" . company-select-previous)
	("<tab>" . company-complete-common-or-cycle)
	("M-<digit>" . company-complete-number)
	:map company-search-map
	("C-p" . company-select-previous)
	("C-n" . company-select-next))
  :config
  ;; function to disable company mode for all remote buffers
  (defun dariofad/disable-company-mode-for-remote-buffers () 
    (when (and (fboundp 'company-mode)
	       (file-remote-p default-directory))
      (company-mode -1)))
  
  ;; adjust garbage collection size
  (setq gc-cons-threshold 100000000)
  ;; increase the amount of data which Emacs reads from the process 
  (setq read-process-output-max (* 1024 4096)) ;; 4mb
  
  ;; use icons by default
  (setq company-format-margin-function #'company-vscode-dark-icons-margin)
  
  ;; utility to have company support
  (use-package company-quickhelp
    :after (company)
    :ensure t
    :init
    (company-quickhelp-mode)
    :config
    (setq company-quickhelp-delay 0.3)
    ;; avoid being blinded when using a dark theme
    (setq company-quickhelp-color-background "black")
    (setq company-quickhelp-color-foreground "yellow")
    (setq pos-tip-foreground-color "yellow")
    (setq pos-tip-background-color "black")

    ;; avoid being blinded when using a dark theme
    (let ((bg (face-attribute 'default :background)))
      (custom-set-faces
       `(company-tooltip ((t (:background "black" :foreground "white"))))
       `(company-scrollbar-bg ((t (:background "yellow"))))
       `(company-scrollbar-fg ((t (:background "white"))))
       `(company-tooltip-selection((t (:backgroud "red" :foreground "red"))))
       `(company-tooltip-common ((t (:hinerit))))
       `(company-tooltip-common-selection ((t (:hinerit))))
       ))
    );; package company-quickhelp
  );; package company

;; I use envrc to create dedicated per project environment settings
;; NB: requires to install direnv at system level (dependency, if
;; missing is a problem)
(use-package envrc
  :ensure t
  :config
  (envrc-global-mode)
  )

;; util useful to show lsp server actions
(use-package which-key
  :ensure t
  )

;; language server protocol
(use-package lsp-mode
  :ensure t
  :after (which-key)
  :commands (lsp lsp-deferred)
  :hook ((lsp-enable-which-key-integration counsel-projectile) . lsp-mode)
  :config
  
  ;; show workspace-relative file path
  (setq lsp-headerline-breadcrumb-enable '(project file symbols))
  (setq lsp-prefer-capf t)
  (setq lsp-completion-show-detail t)
  (setq lsp-completion-show-kind t)
  
  ;; util to ease the development when using lsp-mode
  (use-package lsp-ui
    :ensure t
    :commands (lsp-ui-mode)
    )

  ;; tree-like workspace navigation (available but not enabled by
  ;; default, I do not know if this is really useful yet)
  (use-package lsp-treemacs
    ;; at the moment treemacs is not working, the problem is that the
    ;; workspace is not correctly configured, and also that treemacs is
    ;; not synchronized
    :ensure t
    :commands (lsp-treemacs-errors-list)
    :config (lsp-treemacs-sync-mode 1)
    )

  ;; utility to activate lsp-server with the correct configuration
  ;; (configuration comes from direnv's .envrc settings)
  (defun ddslsp/dariofad-Start-LSP-mode ()
    (interactive)
    (direnv-update-environment)
    (lsp)
    (yas-global-mode)
    (which-key-mode 1)
    ;(counsel-projectile-mode 1)
    (lsp-signature-activate)
    )

  );; package lsp-mode

(use-package counsel-projectile
  :ensure t
  )
(define-key projectile-mode-map (kbd "M-n") 'projectile-command-map)





