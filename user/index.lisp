(in-package #:projects-managment.user)

(restas:define-route index ("")
  (multiple-value-bind (value presentp) (hunchentoot:session-value :user)
    (if (not presentp)
	"Нужно войти!"
	"Вход произведен!")))