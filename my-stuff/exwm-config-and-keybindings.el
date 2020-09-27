;; enable exwm systemtray
(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; set default workspace number
(setq exwm-workspace-number 5)

;; workspace jump (avoiding interactive minibuffer keypad problem: <kp-N> not <N>, as I'm using an Ergodox EZ)
;; (NOTE: using exwm-input-set-key does not invalidate super as prefix key for X application buffers)
(exwm-input-set-key (kbd "<s-kp-0>") (lambda() (interactive)(exwm-workspace-switch 0)))
(exwm-input-set-key (kbd "<s-kp-1>") (lambda() (interactive)(exwm-workspace-switch 1)))
(exwm-input-set-key (kbd "<s-kp-2>") (lambda() (interactive)(exwm-workspace-switch 2)))
(exwm-input-set-key (kbd "<s-kp-3>") (lambda() (interactive)(exwm-workspace-switch 3)))
(exwm-input-set-key (kbd "<s-kp-4>") (lambda() (interactive)(exwm-workspace-switch 4)))

;; move the current X window to the nth workspace
(exwm-input-set-key (kbd "C-c 0") (lambda() (interactive)(exwm-workspace-move-window 0)))
(exwm-input-set-key (kbd "C-c 1") (lambda() (interactive)(exwm-workspace-move-window 1)))
(exwm-input-set-key (kbd "C-c 2") (lambda() (interactive)(exwm-workspace-move-window 2)))
(exwm-input-set-key (kbd "C-c 3") (lambda() (interactive)(exwm-workspace-move-window 3)))
(exwm-input-set-key (kbd "C-c 4") (lambda() (interactive)(exwm-workspace-move-window 4)))

;; window resizing
;; horizontal
(exwm-input-set-key (kbd "s-[") (lambda() (interactive)(exwm-layout-shrink-window-horizontally 15)))
(exwm-input-set-key (kbd "s-{") (lambda() (interactive)(exwm-layout-shrink-window 15)))
;; vertical
(exwm-input-set-key (kbd "s-]") (lambda() (interactive)(exwm-layout-enlarge-window-horizontally 15)))
(exwm-input-set-key (kbd "s-}") (lambda() (interactive)(exwm-layout-enlarge-window 15)))

;; global window switching (also working for X application windows)
(exwm-input-set-key (kbd "M-o") 'ace-window)

;; rotations
(use-package rotate
  :ensure t
  :config
  ;; (working for X application windows)
  (exwm-input-set-key (kbd "s-b") 'rotate-window) ;; blend
  (exwm-input-set-key (kbd "s-d") 'rotate-layout) ;; dislocate
  )

;; posframe
(use-package ivy-posframe
  :after (ivy)
  :ensure t
  :config
  ;; detach from parent
  (setq ivy-posframe-parameters '((parent-frame nil)))
  ;; fix multi-monitor frame positioning issues
  (if (or (string= host-name "greymon")(string= host-name "bukamon"))
      (progn
	;; fix positioning 
	(defun dariofad/ivy-posframe-display-exwm (str)
	  (ivy-posframe--display str
				 (lambda (info)
				   (let* ((workarea (elt exwm-workspace--workareas exwm-workspace-current-index))
					  (x (aref workarea 0))
					  (y (aref workarea 1))

					  (fw (aref workarea 2))
					  (fh (aref workarea 3))

					  (pw (plist-get info :posframe-width))
					  (ph (plist-get info :posframe-height)))
				     
				     (cons (+ x (/ (- fw pw) 2)) (+ y (/ (- fh ph) 2)))))))

	(setq ivy-posframe-display-functions-alist
	      '((t . dariofad/ivy-posframe-display-exwm))

	      ivy-posframe-parameters '((parent-frame nil)
					(z-group . above)))

	;; force set frame-position on every posframe display
	(advice-add 'posframe--set-frame-position :before
		    (lambda (&rest args)
		      (setq-local posframe--last-posframe-pixel-position nil)))
	)
    )
  (ivy-posframe-enable))

;; define exwm simulation keys to prevent local remappping
(setq exwm-input-simulation-keys
      '(
	;; micro movement
	([?\C-b] . [left])
	([?\C-f] . [right])
	([?\C-p] . [up])
	([?\C-n] . [down])
	;; line movement
	([?\C-e] . [end])
	;; screen movement
	([?\M-v] . [prior])
	([?\C-v] . [next])
	;; deletion
	([?\C-d] . [delete])
	([?\C-k] . [S-end delete])
	;; cut/paste.
	([?\C-w] . [?\C-x])
	([?\M-w] . [?\C-c])
	([?\C-y] . [?\C-v])
	))
