(in-package :cl-user)
(defpackage inquisitor-test
  (:use :cl
        :inquisitor
        :inquisitor.keyword
        :prove))
(in-package :inquisitor-test)

;; NOTE: To run this test file, execute `(asdf:test-system :inquisitor)' in your Lisp.

(plan 12)

(subtest "end-of-line"
  (flet ((test-eol (path eol)
           (with-open-file (in (merge-pathnames path *load-truename*)
                            :direction :input
                            :element-type '(unsigned-byte 8))
             (is (detect-end-of-line in) eol))))

    (test-eol "dat/ja/utf8-cr.ja" (cr-keyword))
    (test-eol "dat/ja/utf8-crlf.ja" (crlf-keyword))
    (test-eol "dat/ja/utf8-lf.ja" (lf-keyword))

    ;; if file has no newline then return LF
    (test-eol "dat/ascii.txt" (lf-keyword))
    (test-eol "dat/empty.txt" (lf-keyword))))


;;;; encoding
(defun test-enc (path scm enc)
  (with-open-file (in (merge-pathnames path *load-truename*)
                   :direction :input
                   :element-type '(unsigned-byte 8))
    (multiple-value-bind (encoding treatable)
        (detect-encoding in scm)
      (is encoding enc)
      (when treatable
        (diag (format nil " ; ~a cannot treat ~a"
                      (lisp-implementation-type)
                      encoding))))))

(subtest "encoding -- jp"
  (test-enc "dat/empty.txt" :jp (utf8-keyword))
  (test-enc "dat/ascii.txt" :jp (utf8-keyword))

  (test-enc "dat/ja/eucjp-lf.ja" :jp (eucj-keyword))

  (test-enc "dat/ja/jis-lf.ja" :jp (iso-2022-jp-keyword))

  (test-enc "dat/ja/sjis-crlf.ja" :jp (sjis-keyword))

  (test-enc "dat/ja/ucs2-be-lf.ja" :jp (ucs-2be-keyword))
  (test-enc "dat/ja/ucs2-le-lf.ja" :jp (ucs-2le-keyword))
  (test-enc "dat/ja/utf16-lf.ja" :jp (utf16-keyword)) ; not UCS-2 because of surrogate pair

  (test-enc "dat/ja/utf8-cr.ja" :jp (utf8-keyword))
  (test-enc "dat/ja/utf8-crlf.ja" :jp (utf8-keyword))
  (test-enc "dat/ja/utf8-lf.ja" :jp (utf8-keyword)))

(subtest "encoding -- cn"
  (test-enc "dat/empty.txt" :cn (utf8-keyword))
  (test-enc "dat/ascii.txt" :cn (utf8-keyword))

  (test-enc "dat/cn/gb2312-lf.cn" :cn (gb2312-keyword))
  (test-enc "dat/cn/gb18030-lf.cn" :cn (gb18030-keyword))
  (test-enc "dat/cn/iso2022-cn-lf.cn" :cn (iso-2022-cn-keyword))
  (test-enc "dat/cn/utf8-lf.cn" :cn (utf8-keyword)))

(subtest "encoding -- kr"
  (test-enc "dat/empty.txt" :kr (utf8-keyword))
  (test-enc "dat/ascii.txt" :kr (utf8-keyword))

  (test-enc "dat/kr/euckr-lf.kr" :kr (euck-keyword))
  (test-enc "dat/kr/johab-lf.kr" :kr (johab-keyword))
  (test-enc "dat/kr/iso2022kr-lf.kr" :kr (iso-2022-kr-keyword))
  (test-enc "dat/kr/utf8-lf.kr" :kr (utf8-keyword)))

(subtest "encoding -- ar"
  (test-enc "dat/empty.txt" :ar (utf8-keyword))
  (test-enc "dat/ascii.txt" :ar (utf8-keyword))

  (test-enc "dat/ar/iso8859-6-lf.ar" :ar (iso8859-6-keyword))
  (test-enc "dat/ar/cp1256-lf.ar" :ar (cp1256-keyword))
  (test-enc "dat/ar/utf8-lf.ar" :ar (utf8-keyword)))

(subtest "encoding -- gr"
  (test-enc "dat/empty.txt" :gr (utf8-keyword))
  (test-enc "dat/ascii.txt" :gr (utf8-keyword))

  (test-enc "dat/gr/iso8859-7.gr" :gr (iso8859-7-keyword))
  (diag "in range of greek character, cp1253 is subset of iso8859-7, probably")
  (test-enc "dat/gr/cp1253.gr" :gr (cp1253-keyword))

  (test-enc "dat/gr/utf8-lf.gr" :gr (utf8-keyword)))

(subtest "encoding -- hw"
  (test-enc "dat/empty.txt" :hw (utf8-keyword))
  (test-enc "dat/ascii.txt" :hw (utf8-keyword))

  (subtest "with vowels"
    (diag "iso8859-8 does not has vowels (called 'nikud')")
    (test-enc "dat/hw/cp1255-lf_with-vowels.hw" :hw (cp1255-keyword))
    (test-enc "dat/hw/utf8-lf_with-vowels.hw" :hw (utf8-keyword)))

  (subtest "without vowels"
    (test-enc "dat/hw/iso8859-8-lf_without-vowels.hw" :hw (iso8859-8-keyword))
    (test-enc "dat/hw/cp1255-lf_without-vowels.hw" :hw (cp1255-keyword))
    (test-enc "dat/hw/utf8-lf_without-vowels.hw" :hw (utf8-keyword))))

(subtest "encoding -- tr"
  (test-enc "dat/empty.txt" :tr (utf8-keyword))
  (test-enc "dat/ascii.txt" :tr (utf8-keyword))

  (test-enc "dat/tr/iso8859-9-lf.tr" :tr (iso8859-9-keyword))
  (test-enc "dat/tr/cp1254-lf.tr" :tr (cp1254-keyword))
  (test-enc "dat/tr/utf8-lf.tr" :tr (utf8-keyword)))

(subtest "encoding -- ru"
  (test-enc "dat/empty.txt" :ru (utf8-keyword))
  (test-enc "dat/ascii.txt" :ru (utf8-keyword))

  (test-enc "dat/ru/iso8859-5-lf.ru" :ru (iso8859-5-keyword))
  (test-enc "dat/ru/koi8-r-lf.ru" :ru (koi8-r-keyword))
  (test-enc "dat/ru/koi8-u-lf.ru" :ru (koi8-u-keyword))
  (test-enc "dat/ru/cp866-lf.ru" :ru (cp866-keyword))
  (test-enc "dat/ru/cp1251-lf.ru" :ru (cp1251-keyword))
  (test-enc "dat/ru/utf8-lf.ru" :ru (utf8-keyword)))

(subtest "encoding -- pl"
  (test-enc "dat/empty.txt" :pl (utf8-keyword))
  (test-enc "dat/ascii.txt" :pl (utf8-keyword))

  (test-enc "dat/pl/iso8859-2-lf.pl" :pl (iso8859-2-keyword))
  (test-enc "dat/pl/cp1250-lf.pl" :pl (cp1250-keyword))
  (test-enc "dat/pl/utf8-lf.pl" :pl (utf8-keyword)))

(subtest "encoding -- bl"
  (test-enc "dat/empty.txt" :bl (utf8-keyword))
  (test-enc "dat/ascii.txt" :bl (utf8-keyword))

  (test-enc "dat/bl/iso8859-13-lf.bl" :bl (iso8859-13-keyword))
  (test-enc "dat/bl/cp1257-lf.bl" :bl (cp1257-keyword))
  (test-enc "dat/bl/utf8-lf.bl" :bl (utf8-keyword)))


(finalize)
