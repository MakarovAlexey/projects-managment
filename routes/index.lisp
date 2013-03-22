(in-package #:projects-managment.web)

(restas:define-route index ("")
  (destructuring-bind (value presentp) (hunchentoot:session-value 'user-name)
    (if (not presentp)
	"Нужно войти!"
	"Вход произведен!")))