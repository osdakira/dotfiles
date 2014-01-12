;; (setenv "PATH"
;;         (concat
;;          (substitute-in-file-name
;;           (substring (shell-command-to-string "grep PATH ~/.bashrc") 12 -1))
;;          '":"
;;          (getenv "PATH")))

;;; P82-83 パスの設定
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
;; (add-to-list 'backup-directory-alist
;;              (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "/tmp/") t)))


;; (loop for x in (reverse
;;                 (split-string (substring (shell-command-to-string "echo $PATH") 0 -1) ":"))
;;       do (add-to-list 'exec-path x))

;; When opened from Desktep entry, PATH won't be set to shell's value.
;; (let ((path-str
;;            (replace-regexp-in-string
;;             "\n+$" "" (shell-command-to-string "echo $PATH"))))
;;      (setenv "PATH" path-str)
;;      (setq exec-path (nconc (split-string path-str ":") exec-path)))


;; (defun set-exec-path-from-shell-PATH ()
;;   "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

;; This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))


;; (loop for x in (reverse
;;                 (split-string (substring (shell-command-to-string "grep PATH ~/.bashrc") 12 -1) ":"))
;;       do (add-to-list 'exec-path x))
;; (getenv "PATH")
;; (setenv "PATH"
;;         (concat '"/usr/local/bin:" (getenv "PATH")))
