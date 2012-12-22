(restas:define-module #:projects-managment.web
    (:use :cl :cl-user :cl-who :projects-managment))

(in-package :projects-managment.web)

(defun get-object (id-string)
  (manardb:mptr-to-lisp-object (parse-integer id-string)))

;;(restas:start '#:projects-managment-web :port 8088)
(setf hunchentoot:*catch-errors-p* nil)

(restas:define-route main ("" :method :get)
  (projects-managment.templates:index
   (list :records (map 'list
                       #'(lambda (project)
                           (list :id (manardb:mptr project)
                                 :project project))
                       (manardb:retrieve-all-instances 'project)))))

(restas:define-route add-project ("add-project")
  (projects-managment.templates:add-project))

(restas:define-route project-form ("add-project" :method :post)
  (make-instance 'project
		 :name (hunchentoot:post-parameter "name")
                 :comment (hunchentoot:post-parameter "comment"))
  (restas:redirect 'main))

(restas:define-route projects-tasks ("project/:project"
                                     :parse-vars (list :project #'get-object))
  (with-html-output-to-string (*standard-output* nil :prologue t)
      (:html
       (:head (:title "Проект"))
       (:body
	(:h1 (str (name-of project)))
	(:ul
	 (loop for child-group being the element of (reverse (subgroups-of group))
	    do (htm
		(:li
		 (:a :href (restas:genurl 'show-document-group :id (manardb:mptr child-group))
		     (str (name-of child-group)))
		 (str " (")
		 (:a :href (restas:genurl 'remove-document-group :id (manardb:mptr child-group))
		     "удалить")
		 (str ")")))))
	(:p (:a :href (restas:genurl 'add-subgroup-form :id (manardb:mptr group))
		"Добавить группу"))
	(:ul
	 (loop for document being the element of (documents-of group)
	    do (htm
		(:li
		 (:a :href (restas:genurl 'show-document :id (manardb:mptr group)
					  :document (manardb:mptr document))
		     (str (name-of document)))))))
	(:p (:a :href (restas:genurl 'add-document-form :id (manardb:mptr group))
		"Добавить документ"))))))

(restas:define-route add-subgroup-form ("document-group/:id/add-subgroup"
					:parse-vars (list :id #'parse-integer))
  (with-html-output-to-string (*standard-output* nil :prologue t)
    (:html
     (:head (:title "Новая группа документов"))
     (:body
      (:h1 "Новая группа документов")
      ((:form :action (restas:genurl 'add-subgroup :id id) :method "post")
       (:p (:label :for "name" "Название:")
	   (:input :id "name" :name "name"))
       (:p (:label :for "comment" "Комментарий:"))
       (:p (:textarea :id "comment" :name "comment"))
       (:p (:input :type :submit :value "Создать")))))))

(restas:define-route add-subgroup ("document-group/:id/add-subgroup"
				   :method :post
				   :parse-vars (list :id #'parse-integer))
  (let ((parent (manardb:mptr-to-lisp-object id)))
    (push (make-instance 'document-group
			 :name (hunchentoot:post-parameter "name")
			 :comment (hunchentoot:post-parameter "comment")
			 :parent-group parent)
	  (subgroups-of parent))
    (restas:redirect 'show-document-group :id id)))

(restas:define-route remove-subgroup ("document-group/:id/remove-subgroup"
				      :method :post
				      :parse-vars (list :id #'parse-integer))
							;;:subgroup-id #'parse-integer))
 ;; (let ((group (manardb:mptr-to-lisp-object id)))
;;;	(subgroup (manardb:mptr-to-lisp-object subgroup-id)))
;;    (delete subgroup (subgroups-of id))
    (restas:redirect 'show-document-group :id id))

(restas:define-route add-document-form ("document-group/:id/add-document"
					:parse-vars (list :id #'parse-integer))
  (with-html-output-to-string (out nil :prologue t)
    (:html
     (:head (:title "Новый документ"))
     (:body
      (:h1 "Новый документ")
      ((:form :method "post" :action (restas:genurl 'add-document :id id))
       (:p (:label :for "name" "Название:")
	   (:input :id "name" :name "name"))
       (:p (:label :for "comment" "Комментарий:"))
       (:p (:textarea :id "comment" :name "comment"))
       (:p "Необходимые документы")
       (:ul
	(manardb:doclass (group 'root-group)
	  (let ((element-id (format nil "groups[~a]" (manardb:mptr group))))
	    (htm
	     (:li (:input :id (str element-id) :name (str element-id))
		  (:label :for (str element-id) (str (name-of group))))))))
       (:p (:input :type :submit :value "Создать")))))))

(restas:define-route add-document ("document-group/:id/add-document"
				   :method :post
				   :parse-vars (list :id #'parse-integer))
  (pushnew (make-instance 'document
			  :name (hunchentoot:post-parameter "name")
			  :comment (hunchentoot:post-parameter "comment"))
	   (documents-of (manardb:mptr-to-lisp-object id)))
  (restas:redirect 'show-document-group :id id))

(restas:define-route show-document ("document-group/:id/document/:document"
				    :parse-vars (list :id #'parse-integer
						      :document #'parse-integer))
  "Здесь будет информация о документе")

