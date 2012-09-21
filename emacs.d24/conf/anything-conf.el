(require 'anything)
(global-set-key (kbd "C-;") 'anything-for-files)
(require 'anything-match-plugin nil t)
(require 'anything-extension)
(require 'anything-exuberant-ctags)
;;anything で対象とするkill-ring の要素の長さの最小値.
;;デフォルトは 10.
(setq anything-kill-ring-threshold 20)
(global-set-key "\M-y" 'anything-show-kill-ring)

;; ;; ▼要拡張機能インストール▼
;; ;;; P190-191 ctagsとEmacsとの連携
;; ;; ctags.elの設定
;; (require 'ctags nil t)
;; (setq tags-revert-without-query t)
;; ;; ctagsを呼び出すコマンドライン。パスが通っていればフルパスでなくてもよい
;; ;; etags互換タグを利用する場合はコメントを外す
;; ;; (setq ctags-command "ctags -e -R ")
;; ;; anything-exuberant-ctags.elを利用しない場合はコメントアウトする
;; (setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
;; (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)

;; ▼要拡張機能インストール▼
;;; P192-193 Anythingとタグの連携
;; AnythingからTAGSを利用しやすくするコマンド作成
;; (when  (require 'anything-exuberant-ctags nil t)
;;   ;; anything-for-tags用のソースを定義
;;   (setq anything-for-tags
;;         (list anything-c-source-imenu
;;               ;; anything-c-source-gtags-select
;;               ;; etagsを利用する場合はコメントを外す
;;               ;; anything-c-source-etags-select
;;               anything-c-source-exuberant-ctags-select
;;               ))

;;   ;; anything-for-tagsコマンドを作成
;;   (defun anything-for-tags ()
;;     "Preconfigured `anything' for anything-for-tags."
;;     (interactive)
;;     (anything anything-for-tags
;;               (thing-at-point 'symbol)
;;               nil nil nil "*anything for tags*"))
  
;; ;; M-tにanything-for-currentを割り当て
;; (define-key global-map (kbd "M-t") 'anything-for-tags))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.2 統一したインタフェースでの操作                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P122-129 候補選択型インタフェース──Anything
;; (auto-install-batch "anything")
;; (when (require 'anything nil t)
;;   (setq
;;    ;; 候補を表示するまでの時間。デフォルトは0.5
;;    anything-idle-delay 0.3
;;    ;; タイプして再描写するまでの時間。デフォルトは0.1
;;    anything-input-idle-delay 0.2
;;    ;; 候補の最大表示数。デフォルトは50
;;    anything-candidate-number-limit 100
;;    ;; 候補が多いときに体感速度を早くする
;;    anything-quick-update t
;;    ;; 候補選択ショートカットをアルファベットに
;;    anything-enable-shortcuts 'alphabet)

;;   (when (require 'anything-config nil t)
;;     ;; root権限でアクションを実行するときのコマンド
;;     ;; デフォルトは"su"
;;     (setq anything-su-or-sudo "sudo"))

;;   ;; (require 'anything-match-plugin nil t)

;;   ;; (when (and (executable-find "cmigemo")
;;   ;;            (require 'migemo nil t))
;;   ;;   (require 'anything-migemo nil t))

;;   ;; (when (require 'anything-complete nil t)
;;   ;;   ;; lispシンボルの補完候補の再検索時間
;;   ;;   (anything-lisp-complete-symbol-set-timer 150))

;;   (require 'anything-show-completion nil t)

;;   (when (require 'descbinds-anything nil t)
;;     ;; describe-bindingsをAnythingに置き換える
;;     (descbinds-anything-install)))

;; ▼要拡張機能インストール▼
;;; P127-128 過去の履歴からペースト──anything-show-kill-ring
;; M-yにanything-show-kill-ringを割り当てる
;; (define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; ▼要拡張機能インストール▼
;;; P128-129 moccurを利用する──anything-c-moccur
;; (when (require 'anything-c-moccur nil t)
;;   (setq
;;    ;; anything-c-moccur用 `anything-idle-delay'
;;    anything-c-moccur-anything-idle-delay 0.1
;;    ;; バッファの情報をハイライトする
;;    anything-c-moccur-higligt-info-line-flag t
;;    ;; 現在選択中の候補の位置をほかのwindowに表示する
;;    anything-c-moccur-enable-auto-look-flag t
;;    ;; 起動時にポイントの位置の単語を初期パターンにする
;;    anything-c-moccur-enable-initial-pattern t)
;;   ;; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
;;   (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))


