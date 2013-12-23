(require 'ruby-block)
  ;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

  ;; We never want to edit Rubinius bytecode
  (add-to-list 'completion-ignored-extensions ".rbc")

  (define-key 'help-command (kbd "R") 'yari)

  (eval-after-load 'ruby-mode
    '(progn
       (defun prelude-ruby-mode-defaults ()
         (inf-ruby-setup-keybindings)
         ;; turn off the annoying input echo in irb
         (setq comint-process-echoes t)
         (ruby-block-mode t)
         (ruby-end-mode +1)
         (ruby-tools-mode +1)
         ;; CamelCase aware editing operations
         (subword-mode +1))

       (setq prelude-ruby-mode-hook 'prelude-ruby-mode-defaults)

       (add-hook 'ruby-mode-hook (lambda ()
                                   (run-hooks 'prelude-ruby-mode-hook)))))

(setq ruby-deep-indent-paren-style nil)

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(add-to-list 'ruby-encoding-map '(utf-8 . utf-8))
(add-to-list 'ruby-encoding-map '(undecided . utf-8))

(setq ruby-electric-expand-delimiters-list nil)
(require 'rinari)
(global-rinari-mode)

;; (require 'ruby-end)


(defun execute-rspec ()
  (interactive)
  (do-applescript (format "tell application \"iTerm\"
  activate
  tell current session of current terminal
    write text \"bundle exec spring rspec %s:%s\"
  end tell
  end tell
  tell application \"System Events\"
    keystroke return
  end tell"
  buffer-file-name (line-number-at-pos))))

(define-key ruby-mode-map (kbd "C-c r") 'execute-rspec)
