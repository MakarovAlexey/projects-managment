(in-package #:large-object.test)

(deftestsuite lo () ())

(defvar *test-value*
  (make-array +LARGE-OBJECT-BUFFER-SIZE+
	      :element-type '(unsigned-byte 8)
	      :initial-element 0))

(defvar *oid* 16640)

(addtest creation-unlinking
  (postmodern:with-connection '("test" "postgres" "zxcvb" "localhost")
    (postmodern:with-transaction ()
      (lo-create *oid*))
    (postmodern:with-transaction ()
      (lo-unlink *oid*))))

(addtest opening-closing
  (postmodern:with-connection '("test" "postgres" "zxcvb" "localhost")
    (postmodern:with-transaction ()
      (lo-create *oid*)
      (lo-close (lo-open *oid* +INV-WRITE+))
      (lo-unlink *oid*))))

(addtest writing
  (postmodern:with-connection '("test" "postgres" "zxcvb" "localhost")
    (postmodern:with-transaction ()
      (lo-create *oid*)
      (let ((fd (lo-open *oid* +INV-WRITE+)))
	(lo-write fd *test-value*)
	(lo-close fd))
      (lo-unlink *oid*))))

(addtest reading
  (postmodern:with-connection '("test" "postgres" "zxcvb" "localhost")
    (postmodern:with-transaction ()
      (lo-create *oid*)
      (let ((fd (lo-open *oid* (logior +INV-WRITE+))))
	(lo-write fd *test-value*)
	(lo-close fd)))
    (postmodern:with-transaction ()
      (let ((fd (lo-open *oid* (logior +INV-READ+))))
	(ensure #'(lambda ()
		    (every #'eq (lo-read fd (length *test-value*))
			   *test-value*)))
	(lo-close fd)
	(lo-unlink *oid*)))))