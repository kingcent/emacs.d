
;;---for org gtd start---
;;refer to this page:http://blog.chinaunix.net/uid-26185912-id-3317793.html
(require 'org-capture)
(global-set-key "\C-cc" 'org-capture)
(setq GTD_PATH "e:/kuaipan/emacs-files/gtd11/")

(org-remember-insinuate)
(setq org-directory GTD_PATH)
(setq org-capture-templates 
    '(
        ("n" "New" entry (file (concat GTD_PATH "inbox.org")) "* %? %t \n %i\n %a" ) 
        ("t" "Task" entry (file+headline  (concat GTD_PATH "task.org") "Tasks") "** TODO %?  %t\n %i\n %a" ) 
        ("p" "Project" entry (file (concat GTD_PATH "project.org"))  "** %? %^g %i\n %a") 
 ;       ("New" ?n "* %? %t \n %i\n %a" (concat GTD_PATH "inbox.org") ) 
 ;       ("Task" ?t "** TODO %?\n %i\n %a" (concat GTD_PATH "task.org") "Tasks") 
 ;       ("Calendar" ?c "** TODO %?\n %i\n %a" (concat GTD_PATH "task.org") "Tasks") 
 ;       ("Idea" ?i "** %?\n %i\n %a" (concat GTD_PATH "task.org") "Ideas") 
 ;       ("Note" ?r "* %?\n %i\n %a" (concat GTD_PATH "note.org") ) 
 ;       ("Project" ?p "** %?\n %i\n %a" (concat GTD_PATH "project.org") %g) 
     )
) 
(setq org-default-notes-file (concat org-directory "inbox.org"))
;;����TODO�ؼ���
(setq org-todo-keywords
(list "TODO(t)" "|" "CANCELED(c)" "DONE(d)"))
;; ����Ŀת���ڸ��ļ�֮�䣬��������ͻعˡ�
(custom-set-variables
'(org-refile-targets
(quote
(("inbox.org" :level . 1)("task.org" :level . 2) ("project.org":level . 1))
)))
;; ���ٴ�inbox
(defun inbox() (interactive) (find-file (concat GTD_PATH "inbox.org")))
(global-set-key "\C-cz" 'inbox)
;; �������� agenda-view
(define-key global-map "\C-ca" 'org-agenda-list)
(define-key global-map "\C-ct" 'org-todo-list)
(define-key global-map "\C-cm" 'org-tags-view)
;;��ʾ���ǵ�����
(setq org-agenda-files
    (list (concat GTD_PATH "inbox.org")
          (concat GTD_PATH "task.org")
          (concat GTD_PATH "project.org")
    )
)
(provide 'init-gtd11)
;;---for org gtd end---
