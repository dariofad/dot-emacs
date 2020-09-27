;; company for autocompletion
(use-package company
  :ensure t
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
  :hook
  (prog-mode . company-mode)
  (after-init . global-company-mode)
  )

;; always print company support
(use-package company-quickhelp
  :after (company)
  :ensure t
  :custom
  (company-quickhelp-mode 1)
  )   
