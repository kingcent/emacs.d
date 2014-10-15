
;;---for org gtd start---
;;refer to this page:http://blog.chinaunix.net/uid-26185912-id-3317793.html
(require 'remember)
(require 'org-remember)
(global-set-key "\C-cc" 'remember)
(setq GTD_PATH "e:/kuaipan/emacs-files/gtd/")

(org-remember-insinuate)
(setq org-directory GTD_PATH)
(setq org-remember-templates '(
("Task" ?t "** TODO %? %t\n %i\n %a" (concat GTD_PATH "inbox.org") "Tasks")
("Book" ?c "** %? %t\n %i\n %a" (concat GTD_PATH "inbox.org") "Book")
("Calendar" ?c "** %? %t\n %i\n %a" (concat GTD_PATH "inbox.org") "Calender")
("Project" ?p "** %? %t\n %i\n %a" (concat GTD_PATH "inbox.org") "Project")))
(setq org-default-notes-file (concat org-directory "inbox.org"))
;;����TODO�ؼ���
(setq org-todo-keywords
(list "TODO(t)" "|" "CANCELED(c)" "DONE(d)"))
;; ����Ŀת���ڸ��ļ�֮�䣬��������ͻعˡ�
(custom-set-variables
'(org-refile-targets
(quote
(("inbox.org" :level . 1)("canceled.org" :level . 1) ("finished.org":level . 1))
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
          (concat GTD_PATH "canceled.org")
          (concat GTD_PATH "finished.org")
    )
)
;;---for org gtd end---
