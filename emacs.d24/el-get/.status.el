((anything-etags status "removed" recipe nil)
 (anything-yaetags status "installed" recipe
                   (:name anything-yaetags :auto-generated t :type emacswiki :description "Yet another etags interface with anything." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/anything-yaetags.el"))
 (auto-async-byte-compile status "installed" recipe
                          (:name auto-async-byte-compile :description "Automatically byte-compile when saved" :website "http://www.emacswiki.org/emacs/AutoAsyncByteCompile" :type emacswiki :post-init
                                 (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
                                 :features "auto-async-byte-compile"))
 (ectags-select status "removed" recipe nil)
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (etags-extension status "removed" recipe nil)
 (etags-select status "removed" recipe nil)
 (etags-stack status "removed" recipe nil)
 (etags-table status "installed" recipe
              (:name etags-table :auto-generated t :type emacswiki :description "Set tags table(s) based on current file" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/etags-table.el"))
 (etags-u status "installed" recipe
          (:name etags-u :auto-generated t :type emacswiki :description "(auto)updating TAGS file using etags" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/etags-u.el"))
 (point-undo status "installed" recipe
             (:name point-undo :auto-generated t :type emacswiki :description "undo/redo position" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/point-undo.el")))
