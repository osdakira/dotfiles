;; init settings
;; Replace Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(keyboard-translate ?\C-h ?\C-?)   ;; C-h is backspace
(global-set-key (kbd "C-?") 'help) ;; C-? is help
(global-unset-key [insert])
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ;; 折り返しをトグル
(fset 'yes-or-no-p 'y-or-n-p)
(standard-display-ascii ?\n "$\n")  ;; 末尾に$
(cua-mode t) ; cua-modeをオン
(setq cua-enable-cua-keys nil) ; CUAキーバインドを無効にする
(global-hl-line-mode)
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
;; (global-auto-revert-mode 1)

;; set by emacs configuration

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(auto-save-interval 1000)
 '(backward-delete-char-untabify-method (quote hungry))
 '(blink-cursor-mode nil)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes (quote ("466cdb687a83da9c0e9bb995023600ae00c43efe41fdf31c264fd17285214f95" default)))
 '(debug-on-error t)
 ;; '(debug-on-quit t)
 ;; '(enable-recursive-minibuffers t)
 '(history-length 300)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(kill-ring-max 100)
 '(make-backup-files nil)
 '(recentf-max-menu-items 10)
 '(recentf-max-saved-items 3000)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(save-place t nil (saveplace))
 '(scroll-conservatively 1)
 '(scroll-step 1)
 '(search-highlight t)
 '(set-default-file-coding-system (quote utf-8-unix))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 ;; '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-frame-parameter nil 'alpha 80 )
;; (set-face-underline-p 'modeline t) ; モードラインには下線をつける
;; (set-face-bold-p 'modeline t) ; モードラインは太字
;; (setq frame-background-mode 'dark)
(setq visible-bell t)
(setq warning-minimum-level :emergency)
(load-theme 'molokai t)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; ミニバッファの履歴を保存する
(savehist-mode t)


;; (defun my-dynamic-modeline ()
;;   (cond
;;    ((numberp (string-match "workstation" buffer-file-name))
;;     (set-face-foreground 'modeline "#00ffff"))
;;    ((numberp (string-match "mina-game" buffer-file-name))
;;     (set-face-foreground 'modeline "#ffff00"))
;;    (t
;;     (set-face-foreground 'modeline "white"))))
;; (add-hook 'find-file-hook 'my-dynamic-modeline)
;; (add-hook 'select-window-functions 'my-dynamic-modeline)

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  ;; (my-dynamic-modeline)
)
(global-set-key (kbd "C-t") 'other-window-or-split)


;; 行末の空白を強調表示
;; (setq-default show-trailing-whitespace t)
;; (set-face-background 'trailing-whitespace "#b14770")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 行間
(setq-default line-spacing 0)

;; grep-a-lot grep バッファを沢山作る
(require 'grep-a-lot)

(require 'wgrep)
(define-key wgrep-mode-map (kbd "C-x C-s") '(lambda () (interactive) (let ((wgrep-auto-save-buffer t)) (wgrep-finish-edit))))
;; grep-mode > wgrep-mode への移行
(setq wgrep-enable-key "r")
;; * To apply all changes wheather or not buffer is read-only.
;(setq wgrep-change-readonly-file t)
;; バッファ編集適用後の一括保存を grep-mode でバインド
(define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


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


;; (setenv "PATH"
;;         (concat
;;          (substitute-in-file-name
;;           (substring (shell-command-to-string "grep PATH ~/.bashrc") 12 -1))
;;          '":"
;;          (getenv "PATH")))

;;; P82-83 パスの設定
;; (add-to-list 'exec-path "/opt/local/bin")
;; (add-to-list 'exec-path "/usr/local/bin")
;; (add-to-list 'exec-path "~/bin")

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
;; (add-to-list 'backup-directory-alist
;;              (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "/tmp/") t)))


(when (eq window-system 'ns)
  (let ((my-font-height 120)
        (my-font (cond
                  (t   "Monaco")  ;; XCode 3.1 で使っているフォント
                  (nil "Menlo")   ;; XCode 3.2 で使ってるフォント
                  ))
        (my-font-ja "Hiragino Maru Gothic Pro"))
    (setq mac-allow-anti-aliasing t)

    ;; フォントサイズの微調節 (12ptで合うように)
    (setq face-font-rescale-alist
          '(("^-apple-hiragino.*" . 1.2)
            (".*osaka-bold.*" . 1.2)
            (".*osaka-medium.*" . 1.2)
            (".*courier-bold-.*-mac-roman" . 1.0)
            (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
            (".*monaco-bold-.*-mac-roman" . 0.9)
            ("-cdac$" . 1.3)))

    ;; デフォルトフォント設定
    (when my-font
      (set-face-attribute 'default nil :family my-font :height my-font-height)
      ;;(set-frame-font (format "%s-%d" my-font (/ my-font-height 10)))
      )

    ;; 日本語文字に別のフォントを指定
    (when my-font-ja
      (let ((fn (frame-parameter nil 'font))
            (rg "iso10646-1"))
        (set-fontset-font fn 'katakana-jisx0201 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0208 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0212 `(,my-font-ja . ,rg))))))

(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  )


;; 改行やタブを可視化する whitespace-mode
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□]) ; zenkaku space
        (newline-mark 10 [8629 10]) ; newlne
        (tab-mark 9 [187 9] [92 9]) ; tab » 187
        )
      whitespace-style
      '(spaces
        ;; tabs
        trailing
        newline
        space-mark
        tab-mark
        newline-mark))
;; whitespace-modeで全角スペース文字を可視化　
(setq whitespace-space-regexp "\\(\x3000+\\)")
;; whitespace-mode をオン
(global-whitespace-mode t)


(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "M-@") 'er/contract-region) ;; リージョンを狭める


(require 'auto-complete-config)
(ac-config-default)
(setq ac-delay 0.1) ;; auto-completeまでの時間
(setq ac-auto-show-menu 0.2) ;; メニューが表示されるまで
(setq ac-use-menu-map t) ;; 補完メニューをC-p C-nで操作できるようにする(通常はTABで上や下に移動する)
(setq ac-use-fuzzy t) ;; 曖昧マッチな補完が出来るようにする。

;; (add-hook 'emacs-lisp-mode-hook '(lambda () (require 'eldoc-extension) (eldoc-mode t) ))



(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;;(ctags-update-minor-mode)

;; (global-set-key "\M-?" 'etags-select-find-tag-at-point)
;; (global-set-key "\M-." 'etags-select-find-tag)

;; https://github.com/luozengbin/dot.emacs.d/blob/master/site-start.d/init_dired.el
;;
;; 基本設定
;;______________________________________________________________________
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)

;; サイズ表示を分かりやすくする
(setq dired-listing-switches "-alh")

;; ;; 画像を直接開けるように
;; (auto-image-file-mode t)

;; diredのコピー、削除操作のネストを自動化する
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

(require 'goto-chg)
(global-set-key "\M-[" 'goto-last-change)
(global-set-key "\M-]" 'goto-last-change-reverse)


(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


;; ;; key-chord
;; (require 'key-chord)
;; (key-chord-mode 1)
;; (setq key-chord-two-keys-delay 0.05)

;; ;; key setting
;; (key-chord-define-global "gl" 'goto-line)
;; (key-chord-define-global "as" 'auto-save-buffers-toggle)
;; (key-chord-define-global "re" 'replace-string)
;; (key-chord-define-global "zx" 'undo)


(require 'key-combo)
(key-combo-mode 1)
(key-combo-load-default)
(key-combo-define-global (kbd "C-a") '(back-to-indentation
                                       beginning-of-buffer key-combo-return))
;; (require 'lineno)

(require 'multi-term)
(setq multi-term-program "/bin/bash")


(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (global-num3-mode)

;; (rainbow-mode)
(add-hook 'css-hook 'rainbow-mode)
(add-hook 'scss-hook 'rainbow-mode)

;; (setq rbenv-installation-dir (concat (getenv "HOME") "/.homebrew/var/rbenv/"))
;; ;; (custom-set-variables '(rbenv-installation-dir (concat (getenv "HOME") "/.homebrew/var/rbenv/")))
;; (require 'rbenv)
;; (rbenv-use-global)


(require 'smart-mode-line)
(sml/setup)

;; (require 'smartrep)

(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

;; (global-undo-tree-mode)

;;   (require 'yas-jit)
;;   (setq yas/root-directory snippet-directory)
;;   (yas/jit-load)

(require 'helm-config)
(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; ;; C-hでバックスペースと同じように文字を削除
;; (define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(helm-mode 1)

;; [Mac の emacs で find-file のデフォルトディレクトリを "~/" にする。 - Qiita [キータ]](http://qiita.com/t2psyto/items/05776f010792ba967152)
(setq default-directory "~/")
(setq command-line-default-directory "~/")


;; Google日本語入力を使う場合はおすすめ
(setq default-input-method "MacOSX")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")


(global-auto-highlight-symbol-mode)

(auto-indent-global-mode)

;; ruby-mode
;; マジックコメントを入れない
(setq ruby-insert-encoding-magic-comment nil)
;; TODO FIXME を強調表示
(add-hook 'ruby-mode-hook 'fic-ext-mode)
;; mysql
(autoload 'edbi:open-db-viewer "edbi")
;; flycheck
(add-hook 'ruby-mode-hook 'flycheck-mode)
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)
(setq ruby-block-highlight-toggle 'minibuffer)
(setq ruby-block-highlight-toggle t)

(require 'ruby-end)

(require 'ruby-tools)

;; (add-hook 'ruby-mode-hook 'robe-mode)
;;  - M-. to jump to the definition
;;  - M-, to jump back
;;  - C-c C-d to see the documentation
;;  - C-c C-k to refresh Rails environment
;;  - C-M-i to complete the symbol at point


;; rspec-mode と ruby-test-mode がある
;; rspec-mode
;;; Commentary:
;;
;; This minor mode provides some enhancements to ruby-mode in
;; the contexts of RSpec specifications.  Namely, it provides the
;; following capabilities:
;;
;;  * toggle back and forth between a spec and it's target (bound to
;;    `\C-c ,t`)
;;
;;  * verify the spec file associated with the current buffer (bound to `\C-c ,v`)
;;
;;  * verify the spec defined in the current buffer if it is a spec
;;    file (bound to `\C-c ,v`)
;;
;;  * verify the example defined at the point of the current buffer (bound to `\C-c ,s`)
;;
;;  * re-run the last verification process (bound to `\C-c ,r`)
;;
;;  * toggle the pendingness of the example at the point (bound to
;;    `\C-c ,d`)
;;
;;  * disable the example at the point by making it pending
;;
;;  * reenable the disabled example at the point
;;
;;  * run all specs related to the current buffer (`\C-c ,m`)
;;
;;  * run the current spec and all after it (`\C-c ,c`)
;;
;;  * run spec for entire project (bound to `\C-c ,a`)
;;

(require 'foreign-regexp)
(custom-set-variables
 '(foreign-regexp/regexp-type 'perl) ;; Choose by your preference.
 '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.
