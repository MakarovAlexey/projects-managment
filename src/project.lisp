(in-package #:projects-managment)

(defpclass* project-managment-user ()
  ((name :type string)
   (login :type string)
   (password :type string)
   (email :type string))
  (:documentation "Пользователь системы, ответственный исполнитель"))

;;(defpclass* project ()
;;  ((name :type string)))

;;(defpclass* project-participant ()
;;  ((name :type string)))

;;(defpassociation*
;;  ((:class project :slot project-participants
;;	   :type (hu.dwim.perec:set project-participant))
;;   (:class project-participant
;;	   :slot project :type project)))

;;(defpclass* project-participant-member ()
;;  ()
;;  (:documentation "Член группы реализации участника проекта"))

;;(defpassociation*
;;  ((:class project-participant-member :slot project-participant
;;	   :type project-participant)
;;   (:class project-participant :slot members
;;	   :type (hu.dwim.perec:set project-participant-member))))

;;(defpassociation*
;;  ((:class project-participant-member :slot user :type project-managment-user)
;;   (:class project-managment-user :slot project-participant-memberships
;;	   :type (hu.dwim.perec:set project-participant-member))))

;;(defpclass* project-manager ()
;;  ()
;;  (:documentation "Ведущий проекта"))

;;(defpassociation*
;;  ((:class project-manager :slot project :type project)
;;   (:class project :slot managers
;;	   :type (hu.dwim.perec:set project-manager))))

;;(defpassociation*
;;  ((:class project-manager :slot user :type project-managment-user)
;;   (:class project-managment-user :slot projects-managments
;;	   :type (hu.dwim.perec:set project-participant-member))))

;;(defpclass* document-registrator ()
;;  ()
;;  (:documentation "Документовед"))

;;(defpassociation*
;;  ((:class document-registrator :slot project :type project)
;;   (:class project :slot document-registrators
;;	   :type (hu.dwim.perec:set document-registrator))))

;;(defpassociation*
;;  ((:class document-registrator :slot user :type project-managment-user)
;;   (:class project-managment-user :slot document-registrations
;;	   :type (hu.dwim.perec:set document-registrator))))