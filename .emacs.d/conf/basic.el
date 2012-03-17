;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta)) ;; command → alt
(setq ns-alternate-modifier (quote super)) ;; alt → command
(global-set-key (kbd "M-h") 'backward-kill-word) 
(global-unset-key [insert]) ;; disable insert key
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-t") 'other-window-or-split)
(global-set-key (kbd "C-S-i")   'indent-region)

(custom-set-variables
 ;; 設定系
 '(indent-tabs-mode nil) ;; タブは使わない
 '(indent-level 4)
 '(tab-width 4)
 '(backward-delete-char-untabify-method (quote hungry)) ;; 沢山消す
 '(scroll-step 1)
 '(indicate-empty-lines t) ;; 空行は出す
 '(show-paren-mode t) ;; 括弧の対応は表示
 '(search-highlight t) ;; 検索はハイライト
 '(visible-bell t) ;; エラーは画面のFlashで
 '(make-backup-files nil) ;; バックアップは作らない
 '(tool-bar-mode nil)
 '(inhibit-startup-screen t)

 ;; 内部保持設定系
 '(history-length 100)
 '(auto-save-interval 300) ; デフォルトは300
 '(kill-ring-max 100) ; 100個まで記録しておく

 ;; 表示系
 '(case-fold-search nil) ;;
 '(column-number-mode t) ;; 桁数出す
 '(enable-recursive-minibuffers t)
 ;;'(global-font-lock-mode t)
 '(initial-frame-alist '((width . 260) (height . 55)))
 '(isearch-lazy-highlight-initial-delay 0)
 '(frame-title-format (format "emacs : %%f" ))
 ;;'(mumamo-chunk-coloring t)
 '(save-place t nil (saveplace))
 '(scroll-conservatively 1)
 '(show-paren-style 'expression)
 '(size-indication-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 ;;'(transient-mark-mode t)
 '(truncate-partial-width-windows nil)

 ;; 文字コード系
 '(set-default-file-coding-system 'utf-8-unix)
 '(prefer-coding-system 'utf-8-unix)
 '(current-language-environment "UTF-8")

)

(custom-set-faces
 (set-background-color "Black")
 (set-foreground-color "LightGray")
 (set-cursor-color "Gray")
 (set-frame-parameter nil 'alpha 85)
 (set-face-foreground 'modeline "#FF00")
)
(setq frame-background-mode 'dark)
;;(setq  initial-frame-alist '((width . 10) (height . 10)))
(standard-display-ascii ?\n "$\n")
;; (defface my-eol-face
;;   '((t (:foreground "gray")))
;;   "eol")
;; (defvar my-eol-face
;;   '(("\n" . 'my-eol-face)))
;; (add-hook 'font-lock-mode-hook
;;           (lambda () (font-lock-add-keywords nil my-eol-face)))


;; Indent
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(c-set-offset 'case-label '+)

(global-hl-line-mode) ;; カーソルに横ラインを出す
(fset 'yes-or-no-p 'y-or-n-p) ;; yes じゃなくて y 

;; modeline関係
;;(set-face-underline-p 'modeline t) ; モードラインには下線をつける
(set-face-bold-p 'modeline t) ; モードラインは太字


;;RETで検索を終了した時、常にカーソル位置を検索後の後ろに
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (cond
             ((eq last-input-event ?\C-m)
              (goto-char (match-end 0)))
             ((eq last-input-event ?\M-m)
              (goto-char (match-beginning 0))))))

;; ;; shell-modeで上下で補完
;; (setq shell-mode-hook
;;       (function (lambda ()
;;                   (define-key shell-mode-map [up] 'comint-previous-input)
;;                   (define-key shell-mode-map [down] 'comint-next-input))))



;; ctags
;; (setq tags-table-list
;;       '("~/emacs" "/usr/local/lib/emacs/src"))
;; http://www.bookshelf.jp/texi/emacs-20.6-man-jp/emacs_23.html#SEC272
;; (setq tags-table-list
;;       '("~/projects/dragon/application"))
(setq tags-table-list
      '("~/projects/dragon/application" "~/projects/otogi/application")
      )

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (change-frame-background-color-by-project)
)

;; local varibales list の警告を出さないようにする
(custom-set-variables
 '(safe-local-variable-values (quote ((clmemo-mode . t)))))


(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")