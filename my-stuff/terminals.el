;; set emacs default interactive shell
(setq explicit-shell-file-name "/bin/bash")

;; shell prompt regexp
(setq shell-prompt-pattern '"^[^#$%>\n]*~?[#$%>]")

;; disable company mode when in shell mode and in eshell mode
(add-hook 'shell-mode-hook (lambda () (company-mode -1)) 'append)

;; set comint faces for shell mode (colors)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; open buffers in the current window
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))

;; emacs shell
(use-package eshell
  :ensure t
  :init
  (setq 
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t
   eshell-save-history-on-exit t
   eshell-prefer-lisp-functions nil
   eshell-destroy-buffer-when-process-dies t
   eshell-banner-message "")
  :after (tramp company)
  :config
  (add-hook 'eshell-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "ssh")
              (add-to-list 'eshell-visual-commands "tail")
              (add-to-list 'eshell-visual-commands "top")
	      (add-to-list 'eshell-visual-commands "htop")))
  ;; use tramp to connect to the host (useful to make sudo persistent)
  (add-to-list 'eshell-modules-list 'eshell-tramp)
  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)) 'appbend)
  )

