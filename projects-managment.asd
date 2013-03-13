;;;; projects-managment.asd

(asdf:defsystem #:projects-managment
  :serial t
  :description "Describe projects-managment here"
  :author "Makarov Alexey alexeys9@yandex.ru"
  :license "Specify license here"
  :depends-on (:restas
	       :closure-template)
  :components ((:module "src"
			:components ((:file "package")
				     (:file "projects-managment")))))

