;; flymake for python
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/bin/lintrunner.py"  (list local-file))))
      ;; (list "~/.emacs.d/bin/checkers"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")

;; FlymakeHtml
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(delete '("\\.xml?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; (defvar flymake-read-multiple-lines nil)
;; (make-variable-buffer-local 'flymake-read-multiple-lines)
;; (set-default 'flymake-read-multiple-lines nil)

;; (defun fold-lines (list)
;;   (if list
;;       (concat (car list) " " (fold-lines (cdr list)))
;;     ""))

;; (defadvice flymake-split-output (after flymake-output-split-multilines)
;;   (when flymake-read-multiple-lines
;;     (let ((lines (car ad-return-value))
;;           (residual (cadr ad-return-value)))
;;       (setq ad-return-value
;;             (list (list (fold-lines lines))
;;                   residual)))))
;; (ad-activate 'flymake-split-output)

;; Nope, I want my copies in the system temp dir.
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "/tmp/")
(setq flymake-number-of-errors-to-display 4)

;; (defun flymake-html-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     ;; (list "tidy" (list local-file))))
;;     (list "tidy" (list "-utf8" local-file))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.html$\\|\\.ctp" flymake-html-init))

;; (add-to-list 'flymake-err-line-patterns
;;              '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
;;                nil 1 2 4))

;; HTML用Flymakeの設定
;; (defun flymake-html-init ()
;;   (list "tidy" (list (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.html\\'" flymake-html-init))

;; ;; tidy error pattern
;; (add-to-list 'flymake-err-line-patterns
;; '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
;;   nil 1 2 4))

