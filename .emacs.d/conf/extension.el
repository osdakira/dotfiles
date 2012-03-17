;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  ;;(setq auto-install-use-wget t)
  )

(require 'anything-startup)
(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "M-i") 'anything-imenu)

;; tag jump
;; (require 'anything-etags)
;; (require 'anything-gtags)
;; (define-key global-map (kbd "C-x t")
;;   (lambda ()
;;     "Tag jump using etags, gtags and `anything'."
;;     (interactive)
;;     (let* ((initial-pattern (regexp-quote (or (thing-at-point 'symbol) ""))))
;;       (anything (list anything-c-source-gtags-select
;;                       anything-c-source-etags-select))
;;       "Find Tag: " nil)))


(setq recentf-max-saved-items 3000)
(require 'recentf-ext)

;;(require 'col-highlight)
;;(column-highlight-mode 1)

;; ;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
;; (when (locate-library "uniquify")
;;   (load-safe "uniquify")
;;   (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
 ;;'(uniquify-buffer-name-style (quote forward) nil (uniquify));;同名のファイルはディレクトリを付ける

;; 連続押しカスタマイズ
(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'color-moccur)
(require 'moccur-edit)
(require 'grep-edit)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(require 'minor-mode-hack)



;;;
;;;  Yasnippet
;;;
;;(require 'yasnippet-bundle)
;;(require 'anything-c-yasnippet)
;;(require 'yasnippet-config)
;; Initialize Yasnippet
;Don't map TAB to yasnippet
;In fact, set it to something we'll never use because
;we'll only ever trigger it indirectly.
;; (setq yas/trigger-key (kbd "C-c C-y"))
;; (yas/initialize)



;; ; 前回編集していた場所を記憶
;; (load "saveplace")
;; (setq-default save-place t)


;; (require 'drill-instructor)
;; (setq drill-instructor-global t)



(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)



(require 'boxes)
;; 文字列を囲む設定に書き換え。デフォルトは正直イラネ
(setq boxes-known-modes
  '((c-mode . "c") (c++-mode . "c") (java-mode . "c")
    (html-mode . "html") (sh-mode . "shell") (perl-mode . "shell")
    (python-mode . "shell") (ruby-mode . "shell")
    (emacs-lisp-mode . "lisp") (lisp-mode . "lisp")))
;; 設定ファイルのコメントは通常 # なので
(setq-default boxes-default-type "shell")
;; センタリングされてるほうがカッコイイ
(setq-default boxes-args "-s 75 -a c")
;; 簡単に作成・修正できるようにする
(defalias 'boxes 'boxes-mend)



;; python-mode
;; (autoload 'python-mode "python-mode" nil t)
;;(autoload 'python-mode "python-mode" "Python editing mode." t)
;; (autoload 'py-shell "python-mode" "Python shell" t)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-hook 'python-mode-hook
;;           '(lambda()
;;              (require 'pycomplete)
;;              (setq indent-tabs-mode nil)))


;; (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode)
;;                                       interpreter-mode-alist))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 複数のフレームをまたぐ \C-x o ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice other-window (around other-window-all-frames activate)
  (interactive "p")
  (ad-set-arg 1 t)
  ad-do-it
  (other-frame 0))


;;  (require 'sr-speedbar)
;; ;; (global-set-key (kbd "s-s") 'sr-speedbar-toggle)
;; (setq sr-speedbar-right-side nil)
;; (sr-speedbar-toggle)



;; anything-etags+.el
;; (require 'anything-etags+)
;; (global-set-key "\M-." 'anything-etags+-select-one-key)