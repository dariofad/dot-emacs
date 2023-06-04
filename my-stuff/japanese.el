;; prerequisite: emacs-mozc

;; also check the japanese language is available

;; input Japanese
(use-package mozc
  :ensure t
  :config
  
  ;; set kana map type
  (setq mozc-keymap-kana mozc-keymap-kana-101us)

  ;; set overlay style to default
  (setq mozc-candidate-style 'echo-area)
  )

(defun dd/toggle-mozc-mode ()
  (interactive)
  (mozc-mode)
  (dd/toggle-cursor-color))
