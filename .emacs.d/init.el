(eval-when-compile
  (require 'cl))

; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf")
;; (byte-recompile-directory "~/.emacs.d/elisp" t nil)

(load "basic")
(load "extension")
(load "auto-complete-conf")
(load "elscreen-conf")
(load "smartchar-conf")
(load "face-conf")
(load "nxhtml-conf")
;; (load "magit-conf")
;; (load "yaml-conf")
;; (load "gtags-conf")
;; (load "rope-conf")
;; (load "pysmell-conf")
(load "flymake-conf")
(load "myworks-conf")


;; http://blog.iss.ms/2010/08/28/191049