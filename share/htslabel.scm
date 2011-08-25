(defvar hts_synth_pre_hooks nil)
(defvar SaveLabel_fp t )

(defSynthType HTSLABEL
 (apply_hooks hts_synth_pre_hooks utt)
 (hts_dump_feats_from_fp utt hts_feats_list SaveLabel_fp)
 utt
)

(define (hts_dump_feats_from_fp utt feats ofile)
    (mapcar
     (lambda (s)
       (hts_feats_output ofile s))
     (utt.relation.items utt 'Segment)
    )
)

(define (SaveLabel text filename)
"(SaveLabel TEXT FILENAME)
TEXT, a string. Label generated"
   (set! SaveLabel_fp (fopen filename "w"))
   (Param.set 'Synth_Method "HTSLABEL")
   (utt.synth (eval (list 'Utterance 'Text text)))
   (fclose SaveLabel_fp)
 filename
)

