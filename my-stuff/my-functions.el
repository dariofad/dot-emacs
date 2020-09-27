;; always kill current buffer
(defun kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

;; kill current word (inner-to-word cursor pointing)
(defun dariofad/kill-inner-word ()
  "Kills the entire word your cursor is in."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'dariofad/kill-inner-word)

;; copy current line without killing it
(defun dariofad/copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'dariofad/copy-whole-line)

;; copy current line from point to the end of the line
(defun dariofad/copy-to-end-of-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point)
      (point-at-eol)))))
(global-set-key (kbd "C-c w e") 'dariofad/copy-to-end-of-line)

;; change focus to new window after an horizonal split
(defun dariofad/split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'dariofad/split-and-follow-horizontally)

;; change focus to new window when after a vertical split
(defun dariofad/split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'dariofad/split-and-follow-vertically)
