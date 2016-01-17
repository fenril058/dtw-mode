;;; dtw-mode.el --- delete trailing whitespace automatically -*- lexical-binding: t; -*-

;; Copyright (C) 2016  ril

;; Author: ril
;; Created: 2016-01-15 23:00:00
;; Last Modified: 2016-01-17 10:21:40
;; Version: 1.0
;; Keywords: whitespace, convenience
;; URL: https://github.com/fenril058/dtw-mode

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A simple minor-mode to run delete-trailing-whitespace automatically
;; when the buffers are saved.

(defgroup dtw nil
  "Show searched position in mode-line"
  :group 'whitespace)

(defcustom dtw-mode-lighter " dtw"
  "Lighter of dtw-mode"
  :type 'string)

(defcustom dtw-use-disable-list t
  "If nil, global-dtw-mode enables dtw-mode in the modes which
are the member of `dtw-enable-modes'. If non-nil, global-dtw-mode
enables dtw-mode in all modes except in `dtw-disable-modes'. "
  :group 'dtw)

(defvar dtw-enable-modes '(emacs-lisp-mode)
  "Major modes which `dtw-mode' can run on.")

(defvar dtw-disable-modes '(mew-draft-mode fundamental-mode)
  "Major modes which `dtw-mode' can not run on.")

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

(defun dtw-mode-maybe ()
  "What buffer `dtw-mode' prefers."
  (when (and (not (minibufferp (current-buffer)))
             (if dtw-use-disable-list
                 (not (memq major-mode dtw-disable-modes))
               (memq major-mode dtw-enable-modes))
             (dtw-mode 1)
             )))

;;;###autoload
(define-global-minor-mode global-dtw-mode
  dtw-mode dtw-mode-maybe
  :group 'dtw)

(provide 'dtw-mode)
