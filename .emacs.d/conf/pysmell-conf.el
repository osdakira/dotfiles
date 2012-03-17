;;(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
;;(autoload 'python-mode "python-mode" "Python editing mode." t)


;; ;; Initialize Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs")

(pymacs-mutable-strings t)

(require 'pysmell)
(add-hook 'python-mode-hook (lambda () (pysmell-mode t)))

(defvar ac-source-pysmell
  '((candidates
     . (lambda ()
         (require 'pysmell)
         (pysmell-get-all-completions))))
  "Source for PySmell")
 
(add-hook 'python-mode-hook
          '(lambda ()
             (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell)))))


;; (require 'anything-ipython)
;; (add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
;; (add-hook 'ipython-shell-hook #'(lambda ()
;;                                   (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

;; (when (require 'anything-show-completion nil t)
;;   (use-anything-show-completion 'anything-ipython-complete
;;                                 '(length initial-pattern)))
