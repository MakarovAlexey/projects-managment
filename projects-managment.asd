;;;; projects-managment.asd

(asdf:defsystem #:projects-managment
  :description "Describe projects-managment here"
  :author "Makarov Alexey alexeys9@yandex.ru"
  :license "Specify license here"
  :depends-on (:hu.dwim.perec.postgresql
	       :postmodern
	       :restas
	       :closure-template)
  :defsystem-depends-on (:closure-template)
  :serial t
  :components ((:module "src"
			:serial t
			:components ((:file "package")
				     (:file "projects-managment")
				     ;;(:file "document-type")
				     ;;(:file "expense-item")
				     ;;(:file "person")
				     (:file "project")
				     ;;(:file "task")
				     ;;(:file "expense")
				     ;;(:file "web")
				     ))
	       (:module "templates"
			:components ((:soy-file "base")
				     (:soy-file "forbidden")
				     (:soy-file "internal-server-error")
				     (:soy-file "login")))
	       (:module "routes"
			:serial t
			:components ((:file "module")
				     (:file "login")
				     (:file "index")))))