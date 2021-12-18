(message "Bootstrapping emacs")

;; reading host-name
(setq host-name
      (substring 
       (shell-command-to-string "hostname") 
       0 -1))

;; set t_checker to 1 if EMACS_BOOTED is defined, nil otherwise
(setq t_checker (boundp' EMACS_BOOTED))

;; (executed only at emacs startup)
(if (eq nil t_checker)
      ;; this program installs use-package if it's not
      ;; available. use-package is used to configure and install
      ;; everything else
    (progn
      (package-initialize)

      ;; use ahead-of-time native compilation if available
      (setq package-native-compile t)

      (add-to-list 'package-archives
		   '("melpa-stable" . "https://stable.melpa.org/packages/"))
      (add-to-list 'package-archives
		   '("melpa" . "https://melpa.org/packages/"))

      (unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
      
      (setq use-package-verbose t)      
      )
  )

;; set successful emacs bootstrap
(setq EMACS_BOOTED 1)   

;; base setup done, now switching to a support loader
(load-file "~/.emacs.d/init-helper.el")

(setq inhibit-startup-echo-area-message "Startup finished")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(add-hook 'cmake-mode-hook t)
 '(auth-source-save-behavior nil)
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-enabled-themes '(tango-dark))
 '(exwm-systemtray-height 30)
 '(package-selected-packages
   '(rust-mode lsp-pyright lsp-treemacs lsp-ui lsp-mode envrc go-mode go-mode-hook rotate counsel-projectile yasnippet direnv flycheck which-key visual-regexp treemacs emacs-rotate ivy-posframe company-reftex latex-extra company-math company-auctex latex tex-site multiple-cursors jedi company-quickhelp company-box company-jedy company-jedi anaconda free-keys counsel ace-link exwm xelb use-package smex ido-vertical-mode hindent haskell-mode expand-region company ace-window))
 '(safe-local-variable-values
   '((TeX-master . main\.tex)
     (reftex-default-bibliography . "../../bib/biblio.bib")
     (reftex-default-bibliography . "../../../../bib/biblio.bib")
     (reftex-default-bibliography . "../../../bib/biblio.bib")
     (reftex-default-bibliography . "../../biblio.bib")
     (reftex-default-bibliography . "./biblio.bib")
     (reftex-default-bibliography . "../biblio.bib")
     (reftex-default-bibliography . "../../bibliof.bib")
     (reftex-default-bibliography . "bibliof.bib")
     (reftex-default-bibliography . "../bibliof.bib")
     (reftex-default-bibliography . "biblio.bib")
     (reftex-default-bibliography . "../bib/biblio.bib")
     (reftex-default-bibliography . "./bib/biblio.bib")))
 '(tramp-default-method "scp")
 '(tramp-encoding-shell "/bin/bash"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "deep sky blue" :bold t :height 3.0))))
 '(company-tooltip ((t (:background "black" :foreground "white"))))
 '(company-tooltip-common ((t (:hinerit))))
 '(company-tooltip-common-selection ((t (:hinerit))))
 '(company-tooltip-scrollbar-thumb ((t (:background "white"))))
 '(company-tooltip-scrollbar-track ((t (:background "yellow"))))
 '(company-tooltip-selection ((t (:backgroud "red" :foreground "red")))))
(put 'upcase-region 'disabled nil)
