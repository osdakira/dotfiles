(eval-when-compile
  (require 'cl))

; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; http://blog.iss.ms/2010/08/28/191049
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))
(package-initialize)

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf" "elpa" "vendor")
;; (byte-recompile-directory "~/.emacs.d/elisp" t nil)

(load "basic")
(load "auto-install-conf")
(load "anything-conf")
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
(load "point-undo-conf")
(load "clojure-conf")


;; http://gihyo.jp/book/2012/978-4-7741-5002-4/support