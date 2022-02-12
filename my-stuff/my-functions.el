;; always kill current buffer
(defun ddkcb/Kill-Curr-Buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'ddkcb/Kill-Curr-Buffer)

;; kill current word (inner-to-word cursor pointing)
(defun ddkiw/Kill-Inner-Word ()
  "Kills the entire word your cursor is in."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'ddkiw/Kill-Inner-Word)

;; copy current line without killing it
(defun ddcwl/Copy-Whole-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'ddcwl/Copy-Whole-Line)

;; copy current line from point to the endo of the line
(defun ddcteol/Copy-To-End-Of-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point)
      (point-at-eol)))))
(global-set-key (kbd "C-c w e") 'ddcteol/Copy-To-End-Of-Line)

;; change focus to new window when there is an horizonal split
(defun ddsfh/Split-and-Follow-Horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'ddsfh/Split-and-Follow-Horizontally)

;; change focus to new window when there is a vertical split
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

;; start redshift when available
(defun ddsred/Start-REDshift ()
  (interactive)
  (call-process-shell-command "redshift -O 5000 & disown $(ps -aux | grep -i 'redshift'| grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill redshift
(defun ddkred/Kill-REDshift ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'redshift'| grep -v 'grep' | awk '{ print $2 }') & redshift -x")
  )

;; kill gnome-panel
(defun ddkgp/Kill-Gnome-Panel ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'gnome-panel' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
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

;; stop and disable a vpn connection with openvpn
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
    (eshell-send-input)))

;; globally defined
(global-set-key (kbd "C-!") 'ddoeh/Open-Eshell-Here)

;; function to close eshell quickly from eshell
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;; enable minor mode if finename matches regexp
;; `binding` is a cons cell (regexp . minor-mode)
(defun ddemm/Enable-Minor-Mode (new-binding)
  (interactive)
  (if (buffer-file-name)
      (if (string-match (car new-binding) buffer-file-name)
	  (funcall (cdr new-binding)))))
