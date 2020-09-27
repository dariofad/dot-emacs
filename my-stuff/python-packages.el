 (use-package python
   :ensure t)

;; setting default python interpreter 
(setq python-shell-interpreter "python3")

(use-package elpy
  :after (company)
  :ensure t
  :defer t
  :bind (:map elpy-mode-map
	      ("C-c C-f" . elpy-find-file)
	      ("C-c C-s" . elpy-rgrep-symbol)
	      ("M-." . elpy-goto-definition)
	      ("M-*" . pop-tag-mark)
	      ("C-." . elpy-goto-assignment)
	      ("C-c C-o" . elpy-occur-definitions)
	      ("C-c C-z" . elpy-shell-switch-to-shell)
	      ("C-c C-k" . elpy-shell-kill)
	      ("C-c C-r f" . elpy-format-code)
	      ("C-c C-d" . elpy-doc)
	      )
  :config
  (setq elpy-rpc-python-command "python3")
  (setq elpy-autodoc-delay 0)
  (setq elpy-rpc-virtualenv-path 'current)
  :init
  (advice-add 'python-mode :before 'elpy-enable))
