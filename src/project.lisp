(in-package #:projects-managment)

(defpclass* project ()
  ((name :type string)))

(defpclass* project-participant ()
  ((name :type string)))

(defpassociation*
  ((:class project :slot project-participants
	   :type (hu.dwim.perec:set project-participant))
   (:class project-participant
	   :slot project :type project)))

(defpclass* person-participation () ())

(defpassociation*
  ((:class project-participant
	   :slot person-participations
	   :type (hu.dwim.perec:set person-participation))
   (:class person-participation
	   :slot project-participant
	   :type project-participant)))

(defpassociation*
  ((:class person
	   :slot person-participations
	   :type (hu.dwim.perec:set person-participation))
   (:class person-participation
	   :slot person
	   :type person)))