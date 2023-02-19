;; always kill current buffer
(defun ddkcb/Kill-Curr-Buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'ddkcb/Kill-Curr-Buffer)

;; kill current word
(defun ddkiw/Kill-Inner-Word ()
  "Kill the word where the point is located."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'ddkiw/Kill-Inner-Word)

;; insert line in the ring buffer
(defun ddcwl/Copy-Whole-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'ddcwl/Copy-Whole-Line)

;; copy the current line from the point to the end
(defun ddcteol/Copy-To-End-Of-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point)
      (point-at-eol)))))
(global-set-key (kbd "C-c w e") 'ddcteol/Copy-To-End-Of-Line)

;; set the focus to the new window after an horizonal split
(defun ddsfh/Split-and-Follow-Horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'ddsfh/Split-and-Follow-Horizontally)

;; set the focus to the new window after a vertical split
(defun ddsfv/Split-and-Follow-Vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'ddsfv/Split-and-Follow-Vertically)

;; clear kill-ring
(defun ddckr/Clear-Kill-Ring ()
  (interactive)
  (setq kill-ring nil)
  (message "kill-ring cleared")
  )

;; kill slack
(defun ddksla/Kill-SLAck ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'slack' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill skype
(defun ddksky/Kill-SKYpe ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'skype' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill teams
(defun ddktea/Kill-microsoft-TEAms ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'teams' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill zoom
(defun ddkzoo/Kill-ZOOm ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'zoom' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; start vpn connection
(defun ddsvpn/Start-VPN ()
  (interactive)
  (let ((default_vpn "unibgonly"))
    (let (
	  (vpn_name
	   (read-from-minibuffer "Input vpn name: " default_vpn)))
      (let (( start_command
	      (concat "sudo systemctl enable openvpn-client@" vpn_name
		      ".service; sudo systemctl start openvpn-client@" vpn_name ".service")))
	(async-shell-command start_command)
	(sleep-for 1)
	(switch-to-buffer-other-window "*Async Shell Command*")
	(delete-window)
	)))
  )

;; stop and disable vpn connection
(defun ddkvpn/Kill-VPN ()
  (interactive)
  (let ((default_vpn "unibgonly"))
    (let (
	  (vpn_name
	   (read-from-minibuffer "Input vpn name: " default_vpn)))
      (let (( start_command
	      (concat "sudo systemctl stop openvpn-client@" vpn_name
		      ".service; sudo systemctl disable openvpn-client@" vpn_name ".service")))
	(async-shell-command start_command)
	(sleep-for 1)
	(switch-to-buffer-other-window "*Async Shell Command*")	
	(delete-window)
	)))
  )

;; kill all messaging apps
(defun ddkama/Kill-All-Messaging-Apps()
  (interactive)
  (ddckr/Clear-Kill-Ring)
  (ddksky/Kill-SKYpe)
  (ddksla/Kill-SLAck)
  (ddktea/Kill-microsoft-TEAms)
  )

;; open eshell in the directory associated with the current buffer
(defun ddoeh/Open-Eshell-Here ()
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input))
  )

;; quickly close eshell
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;; top-to-bottom jump
(defun ddttbj/Top-To-Bottom-Jump ()
  (interactive)
  (point-to-register ?t)
  (jump-to-register ?b))
(global-set-key (kbd "C-<f7>") 'ddttbj/Top-To-Bottom-Jump)

;; bottom-to-top jump
(defun ddbttj/Bottom-To-Top-Jump ()
  (interactive)  
  (point-to-register ?b)
  (jump-to-register ?t))
(global-set-key (kbd "M-<f7>") 'ddbttj/Bottom-To-Top-Jump)

;; enable minor mode if finename matches regexp
;; `binding` is a cons cell (regexp . minor-mode)
(defun ddemm/Enable-Minor-Mode (new-binding)
  (interactive)
  (if (buffer-file-name)
      (if (string-match (car new-binding) buffer-file-name)
	  (funcall (cdr new-binding)))))

;; placeholder to execute a function by name
(defvar callable-function-placeholder "initialize function name"
  "Name of a function callable with dd/ utility.
   Use only functions with 0 arguments.")

(defun ddschn/Set-Callable-Hook-Name ()
  "Sets the value of the variable callable-hook-placeholder."
  (interactive)
  (setq callable-hook-placeholder
	(ivy-read "Set callable hook name: " obarray)))

(defun ddcch/Call-Callable-Hook ()
  "Calls the function name saved in the callable-hook-placeholder variable."
  (interactive)
  (funcall (intern callable-hook-placeholder)))
(global-set-key (kbd "C-~") 'ddcch/Call-Callable-Hook)

(defun ddvf/DDVimish-Fold ()
  "Do vimish-fold for all the regions containing the meta
attributes (e.g., '#+attr:...') in the current buffer. Folds only
regions longer than 1 line.

Run vimish-fold-delete-all to remove folding."
  (interactive)
  (goto-char (point-min))
  ;; search for the beginning of a region to be vimish-fold(ed)
  (while (re-search-forward "^[ ]*#\+[a-z]*.*:.*$"
			    nil
			    t)
    ;; detect the end of the region, do vimish-fold, go ahead scanning
    (progn
      (beginning-of-line)
      (set-mark (point))
      (end-of-line)
      (beginning-of-line)
      (next-line) ;; terminates gracefully when eobp is reached (no
		  ;; more need to vimish-fold)
      (let* ((vimished-region-len 1))
	(while (if (not (eobp))
		   (string-match "^[ ]*#\+[a-z]*.*:.*$" (thing-at-point 'line t))
		 nil)
	  (next-line)
	  (beginning-of-line)
	  (cl-incf vimished-region-len)
	  )
	;; vimish-fold the region only when there is more than 1 line,
	;; go ahead scanning otherwise
	(if (> vimished-region-len 1)
	    (progn
	      ;; do not fold last line, which could be used to open a
	      ;; source block
	      (previous-line)
	      (end-of-line)
	      ;; vimish fold
	      (vimish-fold (mark) (point)))
	  (deactivate-mark))
	(end-of-line)
	(next-line)	
	)
      )
    )
  )

(defun ddbepdf/Beamer-Export-to-PDF()
  "Insert the beamer export template in the current org buffer and export to pdf.
 The function is particularly useful to avoid visual problems with org-latex-preview,
 which keeps rendering math equations with preamble command (fonts, hyperref setup...)

Where is my template? ~/git/notes/lapec/slide_template.org
"
  (interactive)
  (let ((l_checker (boundp' EMACS_PACKAGES_LOADED)))
    (progn
      ;; do not execute this function at load time for the current buffer
      (if (not (eq nil l_checker))
	  (save-excursion
	    (goto-line 0)
	    (setq file-len (nth 1 (insert-file-contents "~/git/notes/lapec/slide_template.org")))
	    ;; remove the insertion even when compilation fails
	    (ignore-errors
	      (org-beamer-export-to-pdf))
	    (forward-char file-len)
	    (set-mark (point))
	    (goto-line 0)
	    (delete-active-region)))
      )
    )
  )
