;; TODO: Make a custom variable.
(defvar drkm-fav:favourite-directories-alist
  '(
    ("saxon-src"  . "y:/Saxon/saxon-resources9-0-0-1/source/net/sf/saxon")
    ("test"  . "E:/test.txt")
    ("kernow-src" . "~/xslt/kernow/svn-2007-09-29/kernow/trunk/src/net/sf/kernow")
   )
  "See `drkm-fav:handler'.")

(defvar drkm-fav::fav-dirs-re
  ;; TODO: Is tehre really no other way (than mapcar) to get the list
  ;; of the keys of an alist?!?
  (concat
   "^@"
   (regexp-opt
    (mapcar 'car drkm-fav:favourite-directories-alist)
    t))
  "Internal variable that stores a regex computed from
`drkm-fav:favourite-directories-alist'.  WARNING: This is not
updated automatically if the later variable is changed.")

(defun drkm-fav:handler (primitive &rest args)
  "Magic handler for favourite directories.

With this handler installed into `file-name-handler-alist', it is
possible to use shortcuts for often used directories.  It uses
the mapping in the alist `drkm-fav:favourite-directories-alist'.

Once installed, say you have the following alist in the mapping
variable:

    ((\"dir-1\" . \"~/some/real/dir\")
     (\"dir-2\" . \"c:/other/dir/for/windows/users\"))

You can now use \"@dir-1\" while opening a file with C-x C-f for
instance, with completion for the abbreviation names themselves
as well as for files under the target directory."
  (cond
   ;; expand-file-name
   ((and (eq primitive 'expand-file-name)
         (string-match drkm-fav::fav-dirs-re (car args)))
    (replace-match
     (cdr (assoc (match-string 1 (car args))
                 drkm-fav:favourite-directories-alist))
     t t (car args)))
   ;; file-name-completion
   ((and (eq primitive 'file-name-completion)
         (string-match "^@\\([^/]*\\)$" (car args)))
    (let ((compl (try-completion
                  (match-string 1 (car args))
                  drkm-fav:favourite-directories-alist)))
      (cond ((eq t compl)
             (concat "@" (match-string 1 (car args)) "/"))
            ((not compl)
             nil)
            (t
             (concat "@" compl)))))
   ;; file-name-all-completions
   ((and (eq primitive 'file-name-all-completions)
         (string-match "^@\\([^/]*\\)$" (car args)))
    (all-completions
     (match-string 1 (car args))
     drkm-fav:favourite-directories-alist))
   ;; Handle any primitive we don't know about (from the info node
   ;; (info "(elisp)Magic File Names")).
   (t (let ((inhibit-file-name-handlers
             (cons 'drkm-fav:handler
                   (and (eq inhibit-file-name-operation primitive)
                        inhibit-file-name-handlers)))
            (inhibit-file-name-operation primitive))
        (apply primitive args)))))

;; Actually plug the feature into Emacs.
(push '("\\`@" . drkm-fav:handler) file-name-handler-alist)
(provide 'drkm-fav)
