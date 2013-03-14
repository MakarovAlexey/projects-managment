(in-package #:projects-managment)

(defpclass* document-directory ()
  ((name :type string)))

(defpclass document-type ()
  ((name :type string))
  (:documentation "Тип документа"))

(defpassociation*
  ((:class document-directory :slot document-types :type (hu.dwim.perec:set document-type))
   (:class document-type :slot parent-directory :type document-directory)))

(defpclass* common-directory (document-directory) ())

(defpassociation*
  ((:class document-directory :slot subdirectories :type (hu.dwim.perec:set common-directory))
   (:class common-directory :slot parent-directory :type document-directory)))

(defpclass* root-directory (document-directory) ())