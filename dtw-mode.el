;; dtw-mode.el
;; Last modified : 2016-01-17 02:10:40

(defgroup dtw nil
  "Show searched position in mode-line"
  :group 'whitespace)

(defcustom dtw-mode-lighter " dtw"
  "Lighter of dtw-mode"
  :type 'string)

(defvar dtw-disable-modes '(mew-draft-mode fundamental-mode)
  "Major modes `dtw-mode' can not run on.")

;;;###autoload
(define-minor-mode dtw-mode
  "Tggle dtw-mode.

Dtw-mode is a minor mode. When enable,
every time the buffer saved, auto matically run delete-trailing-whitespaceace"
  :lighter dtw-mode-lighter
  :group 'dtw
  (if dtw-mode
      (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)
    (remove-hook 'before-save-hook 'delete-trailing-whitespace t))
  )
;;; write-file-functions と before-save-hook どちらがいいか

(defun dtw-mode-maybe ()
  "What buffer `dtw-mode' prefers."
  (when (and (not (minibufferp (current-buffer)))
             (not (memq major-mode dtw-disable-modes))
             (dtw-mode 1)
             )))

;;;###autoload
(define-global-minor-mode global-dtw-mode
  dtw-mode dtw-mode-maybe
  :group 'dtw)

(provide 'dtw-mode)
