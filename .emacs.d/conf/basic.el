;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))               ;; command → alt
(setq ns-alternate-modifier (quote super))            ;; alt → command
(keyboard-translate ?\C-h ?\C-?)                      ;; C-h と C-?を入れ替える
(global-set-key (kbd "M-h") 'backward-kill-word)      ;; M-hで単語消す
(global-unset-key [insert])                           ;; disable insert key
(global-set-key (kbd "C-t") 'other-window-or-split)   ;; 別のwindowへ
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ;; 折り返しのトグル

(custom-set-variables
 ;; 設定系
 '(indent-tabs-mode nil)                                ;; タブは使わない
 '(indent-level 4)                                      ;; スペース4つ
 '(scroll-step 1)                                       ;; スクロールは1行ずつ
 '(indicate-empty-lines t)                              ;; 空行は出す
 '(show-paren-mode t)                                   ;; 括弧の対応は表示
 '(search-highlight t)                                  ;; 検索はハイライト
 '(visible-bell t)                                      ;; エラーは画面のFlashで
 '(make-backup-files nil)                               ;; バックアップは作らない
 '(tool-bar-mode nil)                                   ;; ツールバーは要らない
 '(inhibit-startup-screen t)                            ;; 起動画面不要
 '(backward-delete-char-untabify-method (quote hungry)) ;; 沢山消す

 ;; 内部保持設定系
 '(kill-ring-max 100)      ; 100個まで記録しておく
 '(history-length 100)     ; 100個まで記録しておく
 '(auto-save-interval 300) ; デフォルトは300

 ;; 表示系
 '(column-number-mode t) ;; 桁数出す
 '(isearch-lazy-highlight-initial-delay 0) ;; 検索ﾊｲﾗｲﾄはすぐに
 '(frame-title-format (format "emacs : %%f" )) ;; タイトルはファイルフルパス
 '(initial-frame-alist '((width . 260) (height . 55))) ;; 画面サイズ
 '(case-fold-search nil) 
 '(scroll-conservatively 1)
 '(size-indication-mode t)
 '(save-place t nil (saveplace))
 '(show-paren-style 'expression)
 '(enable-recursive-minibuffers t)
 '(truncate-partial-width-windows nil)
 ;; '(text-mode-hook (quote (text-mode-hook-identify)))
 ;;'(mumamo-chunk-coloring t)
 ;;'(transient-mark-mode t)
 ;;'(global-font-lock-mode t)

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

;;(setq frame-background-mode 'dark)
(standard-display-ascii ?\n "$\n") ;; 
(fset 'yes-or-no-p 'y-or-n-p) ;; yes じゃなくて y 
(global-hl-line-mode) ;; カーソルに横ラインを出す

;; (defface my-eol-face
;;   '((t (:foreground "gray")))
;;   "eol")
;; (defvar my-eol-face
;;   '(("\n" . 'my-eol-face)))
;; (add-hook 'font-lock-mode-hook
;;           (lambda () (font-lock-add-keywords nil my-eol-face)))


;; Indent
(setq-default c-basic-offset 4)
(c-set-offset 'case-label '+)


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
      ;; '("~/projects/dragon/application" "~/projects/otogi/application")
      '("~/projects/genju-hime/application")
      )


(defun other-window-or-split ()
  "他のwindowへ。なかったら作る"
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (change-frame-background-color-by-project)
)


;; local varibales list の警告を出さないようにする
(custom-set-variables
 '(safe-local-variable-values (quote ((clmemo-mode . t)))))


;; タブ、空白を眼に見えるように
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


(add-hook 'js2-mode-hook
          '(lambda ()
             (require 'js)
             (setq js-indent-level 4
                   js-expr-indent-offset 4
                   indent-tabs-mode nil)
             (set (make-local-variable 'indent-line-function) 'js-indent-line)))