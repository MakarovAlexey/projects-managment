;;;; projects-managment.asd

(asdf:defsystem #:projects-managment
  :serial t
  :description "Describe projects-managment here"
  :author "Makarov Alexey alexeys9@yandex.ru"
  :license "Specify license here"
  :depends-on (:hu.dwim.perec.postgresql
	       :postmodern
	       :restas
	       :closure-template)
  :defsystem-depends-on (:closure-template)
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
			;;	     (:file "web")
				     (:module "web"
					      :serial t
					      :components ((:module "core"
								    :components ((:soy-file "base-page")
										 (:soy-file "forbidden-page")
										 (:soy-file "internal-server-error-page")))
							   (:module "login"
								    :components ((:soy-file "login-page")))))))))

