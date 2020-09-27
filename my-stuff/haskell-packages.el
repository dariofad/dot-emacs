;; haskell-mode
(use-package haskell-mode
  :ensure t)
;; the following could be useful
;; stack install happy
;; stack install hindent
;; stack install hlint
;; stack install hoogle
;; stack install hasktags
;; stack install stylish-haskell
;; stack instal cabal-install
;; and run
;; hoogle data

;; proper code indentation
(use-package hindent
  :ensure t
  :hook (haskell-mode . hindent-mode))

;; haskell-mode related keybindings
(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
;; setting cabal command when using stack
(setq haskell-compile-cabal-build-command "stack build")
