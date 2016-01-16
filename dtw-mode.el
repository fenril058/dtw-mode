;; dtw-mode.el
;; Last modified : 2012-06-27 22:12:15

(defvar dtw-disable-modes '(mew-draft-mode fundamental-mode)
  "Major modes `dtw-mode' can not run on.")

;; (define-minor-mode dtw-mode
;;   "Tggle dtw-mode.

;; Dtw-mode is a minor mode. When enable,
;; every time the buffer saved, auto matically run delete-trailing-whitespace"
;;   :lighter " dtw"
;;   :group 'dtw-mode
;;   (funcall (if dtw-mode 'add-hook 'remove-hook)
;;            'local-write-file-hooks 'delete-trailing-whitespace)
;;   )

(define-minor-mode dtw-mode
  "Tggle dtw-mode.

Dtw-mode is a minor mode. When enable,
every time the buffer saved, auto matically run delete-trailing-whitespaceace"
  :lighter " dtw"
  :group 'dtw-mode
  (if dtw-mode
      (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)
    (remove-hook 'before-save-hook 'delete-trailing-whitespace t))
  )

(defun dtw-mode-maybe ()
  "What buffer `dtw-mode' prefers."
  (when (and (not (minibufferp (current-buffer)))
             (not (memq major-mode dtw-disable-modes))
             (dtw-mode 1)
             )))

(define-global-minor-mode global-dtw-mode
  dtw-mode dtw-mode-maybe
  :group 'dtw-mode)

(provide 'dtw-mode)
