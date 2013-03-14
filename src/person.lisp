(in-package #:projects-managment)

(defpclass* person ()
  ((name type string))
  (:documentation "Ответственный исполнитель"))

(defpclass* user (person)
  ((login :type string)
   (password :type string)
   (email :type string))
  (:documentation "Пользователь системы"))