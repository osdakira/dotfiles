(defun my-dynamic-modeline ()
  (cond
   ((numberp (string-match "edo2" buffer-file-name))
    (set-face-foreground 'modeline "#00ffff"))
   ((numberp (string-match "edo" buffer-file-name))
    (set-face-foreground 'modeline "#ffff00"))
   (t
    (set-face-foreground 'modeline "white"))))
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (my-dynamic-modeline)
)
(global-set-key (kbd "C-t") 'other-window-or-split)

;; modeline関係
(set-face-underline-p 'modeline t) ; モードラインには下線をつける
(set-face-bold-p 'modeline t) ; モードラインは太字

(setq frame-background-mode 'dark)

(custom-set-variables
 '(set-default-file-coding-system 'utf-8-unix)
 '(blink-cursor-mode nil)
 '(auto-save-interval 100) ; デフォルトは300
 '(backward-delete-char-untabify-method (quote hungry))
 '(column-number-mode t)
 '(case-fold-search nil)
 '(current-language-environment "UTF-8")
 '(enable-recursive-minibuffers t)
 '(frame-title-format (format "emacs : %%f" ))
 '(global-font-lock-mode t)
 '(history-length 100)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(indent-level 4)
 '(indicate-empty-lines t)
 '(kill-ring-max 100) ; 100個まで記録しておく
 '(make-backup-files nil)
 '(recentf-max-saved-items 1000)
 '(save-place t nil (saveplace))
 '(search-highlight t)
 '(show-paren-mode t)
 '(show-paren-style 'expression)
 '(scroll-step 1)
 '(scroll-conservatively 1)
;; '(tab-width 4)
 '(visible-bell t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 ;; '(which-function-mode t)
 '(python-indent-offset 4)
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes (quote ("cd881cd785e681c826a455d367697e60a2131a051801ae96d0f33cdaabd8d487" "6615e5aefae7d222a0c252c81aac52c4efb2218d35dfbb93c023c4b94d3fa0db" default)))
)

(set-frame-parameter nil 'alpha 80)

(elscreen-start)

(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start 1)
(setq ac-dwim t)
(setq ac-use-menu-map t) ;; C-n/C-pで候補選択可能
(add-to-list 'ac-sources 'ac-source-yasnippet) ;; 常にYASnippetを補完候補に
(global-auto-complete-mode t)


;; 行末の空白を強調表示
;; (setq-default show-trailing-whitespace t)
;; (set-face-background 'trailing-whitespace "#b14770")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 行間
(setq-default line-spacing 0)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; grep-a-lot
(require 'grep-a-lot)
;; wgrep
(require 'wgrep)
(define-key wgrep-mode-map (kbd "C-x C-s") '(lambda () (interactive) (let ((wgrep-auto-save-buffer t)) (wgrep-finish-edit))))
;; grep-mode > wgrep-mode への移行
(setq wgrep-enable-key "r")
;; * To apply all changes wheather or not buffer is read-only.
;(setq wgrep-change-readonly-file t)
;; バッファ編集適用後の一括保存を grep-mode でバインド
(define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)


;; (require 'pony-mode)
;; (add-hook 'sgml-mode-hook
;;           (lambda ()
;;             (auto-complete-mode)
;;             (setq sgml-basic-offset 4)
;;             (setq indent-tabs-mode nil)
;; ;;            (tab-width 4)
;;             (pony-tpl-mode)
;;             ))



(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;; Mac でファイルを開いたときに、新たなフレームを作らない
;; (setq ns-pop-up-frames nil)

;; (auto-compile-on-save-mode 1)

;; (require 'ctags-update)
;; (ctags-auto-update-mode 1)

;; (setq ipython-command "/usr/local/bin/ipython")
;; (require 'ipython)


;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)


(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )


;; (add-hook 'python-mode-hook
;;   '(lambda ()
;;     (setq imenu-create-index-function 'python-imenu-create-index)))

;; (add-hook 'python-mode-hook
;;   '(lambda ()
;;     (setq imenu-create-index-function 'python-imenu-create-index)))


(require 'fold-dwim)
(global-set-key (kbd "C-c o") 'fold-dwim-toggle)
(global-set-key (kbd "C-c n") 'fold-dwim-hide-all)
(global-set-key (kbd "C-c k") 'fold-dwim-show-all)
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode)
             ;; (fold-dwim-hide-all)
             ))


;; ;; diffの表示方法を変更
;; (defun diff-mode-setup-faces ()
;;   ;; 追加された行は緑で表示
;;   (set-face-attribute 'diff-added nil
;;                       :foreground "white" :background "dark green")
;;   ;; 削除された行は赤で表示
;;   (set-face-attribute 'diff-removed nil
;;                       :foreground "white" :background "dark red")
;;   ;; 文字単位での変更箇所は色を反転して強調
;;   (set-face-attribute 'diff-refine-change nil
;;                       :foreground nil :background nil
;;                       :weight 'bold :inverse-video t))
;; (add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; ;; diffを表示したらすぐに文字単位での強調表示も行う
;; (defun diff-mode-refine-automatically ()
;;   (diff-auto-refine-mode t))
;; (add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; ;; diff関連の設定
;; (defun magit-setup-diff ()
;;   ;; diffを表示しているときに文字単位での変更箇所も強調表示する
;;   ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
;;   (setq magit-diff-refine-hunk 'all)
;;   ;; diff用のfaceを設定する
;;   (diff-mode-setup-faces)
;;   ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
;;   (set-face-attribute 'magit-item-highlight nil :inherit nil))
;; (add-hook 'magit-mode-hook 'magit-setup-diff)


;; (autoload 'edbi:open-db-viewer "edbi")
;; (require 'edbi)

;; 大文字小文字変換
(defun seq-upcase-backward-word ()
  (interactive)
  (backward-word)
  (upcase-word 1))
(defun seq-capitalize-backward-word ()
  (interactive)
  (backward-word)
  (capitalize-word 1))
(defun seq-downcase-backward-word ()
  (interactive)
  (backward-word)
  (downcase-word 1))
(global-set-key "\M-u" 'seq-upcase-backward-word)
(global-set-key "\M-c" 'seq-capitalize-backward-word)
(global-set-key "\M-l" 'seq-downcase-backward-word)

(add-to-list 'auto-mode-alist '("[Rr]akefile" . ruby-mode))

;; (require 'popwin)
;; ;; (setq display-buffer-function 'popwin:display-buffer)
;; (setq pop-up-windows nil)
;; (require 'popwin nil t)
;; (when (require 'popwin nil t)
;;   (setq anything-samewindow nil)
;;   (setq display-buffer-function 'popwin:display-buffer)
;;   (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
;;   (push '("*Completions*" :height 0.4) popwin:special-display-config)
;;   (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
;;   )


(add-hook
  'nxml-mode-hook
  (lambda ()
    (define-key nxml-mode-map (kbd "M-h") 'backward-kill-word)))


;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
(setq vc-follow-symlinks t)
