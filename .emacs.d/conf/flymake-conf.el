;;(require 'flymake)
;;(require 'flymake-cursor)
(load-library "flymake")
;;(require 'flymake-cursor)
(eval-after-load 'flymake '(require 'flymake-cursor))
 
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

;;(add-hook 'python-mode-hook '(lambda () (flymake-mode t)))

;;===== PyFlakes
;; code checking via pyflakes+flymake
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ;;(list "pyflakes" (list local-file))))
      (list "lintrunner.py" (list local-file))))
 
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
 
(add-hook 'find-file-hook 'flymake-find-file-hook)
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
;;(setq flymake-cursor-error-display-delay nil)


;; (defun flymake-python-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		     'flymake-create-temp-inplace))
;; 	 (local-file (file-relative-name
;; 		      temp-file
;; 		      (file-name-directory buffer-file-name))))
;;     (list "pyflakes" (list local-file))))

;; (defconst flymake-allowed-python-file-name-masks '(("\\.py$" flymake-python-init)))
;; (defvar flymake-python-err-line-patterns '(("\\(.*\\):\\([0-9]+\\):\\(.*\\)" 1 2 nil 3)))
 
;; (defun flymake-python-load ()
;;   (interactive)
;;   (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;     (setq flymake-check-was-interrupted t))
;;   (ad-activate 'flymake-post-syntax-check)
;;   (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-python-file-name-masks))
;;   (setq flymake-err-line-patterns flymake-python-err-line-patterns)
;;   (flymake-mode t))
;; (add-hook 'python-mode-hook '(lambda () (flymake-python-load)))


;; ;; pyflakes の パスを設定する必要がある。
;; (setq exec-path (cons "/usr/local/bin" exec-path))
;; (setenv "PATH"
;;         (concat '"/usr/local/bin:" (getenv "PATH")))

;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (unless (eq buffer-file-name nil) (flymake-python-load))))

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             ; Activate flymake unless buffer is a tmp buffer for the interpreter
;;             (unless (eq buffer-file-name nil) (flymake-mode t))

;; ;; -*- emacs-lisp -*-
;; ;; License: Gnu Public License
;; ;;
;; ;; Additional functionality that makes flymake error messages appear
;; ;; in the minibuffer when point is on a line containing a flymake
;; ;; error. This saves having to mouse over the error, which is a
;; ;; keyboard user's annoyance

;; ;;flymake-ler(file line type text &optional full-file)
;; (defun show-fly-err-at-point ()
;;   "If the cursor is sitting on a flymake error, display the
;; message in the minibuffer"
;;   (interactive)
;;   (let ((line-no (line-number-at-pos)))
;;     (dolist (elem flymake-err-info)
;;       (if (eq (car elem) line-no)
;; 	  (let ((err (car (second elem))))
;; 	    (message "%s" (fly-pyflake-determine-message err)))))))

;; (defun fly-pyflake-determine-message (err)
;;   "pyflake is flakey if it has compile problems, this adjusts the
;; message to display, so there is one ;)"
;;   (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
;; 	((null (flymake-ler-file err))
;; 	 ;; normal message do your thing
;; 	 (flymake-ler-text err))
;; 	(t ;; could not compile err
;; 	 (format "compile error, problem on line %s" (flymake-ler-line err)))))

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;;   "Display the error in the mini-buffer rather than having to mouse over it"
;;   (show-fly-err-at-point))
;; (global-set-key (kbd "C-c e") 'flymake-goto-next-error)

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;;   "Display the error in the mini-buffer rather than having to mouse over it"
;;   (show-fly-err-at-point))

;; (defadvice flymake-mode (before post-command-stuff activate compile)
;;   "Add functionality to the post command hook so that if the
;; cursor is sitting on a flymake error the error information is
;; displayed in the minibuffer (rather than having to mouse over
;; it)"
;;   (set (make-local-variable 'post-command-hook)
;;        (cons 'show-fly-err-at-point post-command-hook)))

;;(require 'flymake-cursor)