;; set Emacs default shell
(setq explicit-shell-file-name "/bin/bash")

;; shell prompt regexp
(setq shell-prompt-pattern '"^[^#$%>\n]*~?[#$%>]")

;; disable company mode in shell mode and eshell mode
(add-hook 'shell-mode-hook (lambda () (company-mode -1)) 'append)

;; set comint faces for shell mode (colors)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; always open buffer with shell in their name in current window
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))

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
  ;; use tramp to connect to host (useful to make sudo session persistent)
  (add-to-list 'eshell-modules-list 'eshell-tramp)
  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)) 'appbend)
  )

