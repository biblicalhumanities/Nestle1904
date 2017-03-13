Nestle 1904 Greek New Testament 
===============================

with morphology, lemmatization, and Strong's numbers
		     
Public Domain. Copy Freely. δωρεὰν ἐλάβετε, δωρεὰν δότε.

Analysis edited by Dr. Ulrik Sandborg-Petersen

Version 1.1
December 9, 2013

For other high quality resources suitable to scholarly study of Greek and Hebrew, see the [Biblical Humanities Dashboard](http://biblicalhumanities.org/dashboard/).


What is this?
=============

This is the 1904 edition of Eberhard Nestle's Greek New Testament,
with morphological tags, lemmatization, and Strong's numbering.

The base text has been created by Diego Renato dos Santos, and has a
home on the Internet at this address (retrieved November 13, 2013):

https://sites.google.com/site/nestle1904/

The reader is encouraged to visit this website, where more information
about the method of production of the base text can be found.  The
editor of the analysis wishes to thank Diego Renato ds Santos for the
care and effort with which he has prepared the base text, and thus has
rendered the Body of Christ an invaluable service.

The text has been augmented with morphological tags, lemmatization,
and Strong's numbers.  This work was carried out by Dr. Ulrik
Sandborg-Petersen of Emergence Consult and Aalborg University,
Denmark.

The basic method has been to port over as much as possible of an
analysis of the Wescott-Hort GNT based on the work done on that text
by Dr. Maurice A. Robinson, augmented by a few tricks derived from a
combination of computational linguistics and Koine Greek
word-formation rules.  The few hundred words that in this way did not
get any analysis, or only a partial or ambiguous analysis, were
corrected through analysis supplied by hand.

The editor wishes to thank Dr. Maurice A. Robinson for the staggering
amount of labor which he has expended on the preparation of his
various morphological databases and the texts which they describe. The
present morphological edition is largely the work of Dr. Robinson,
re-purposed for a different text. Thus the present analysis would not
exist without the work done by Dr. Robinson, and he deserves most of
the credit for the existence of the present analysis.  Any errors
which the present editor has introduced remain, of course, my
responsibility alone.


Copyright status
================

The base text, being Nestle 1904, is in the Public Domain.  The
curator of that text is, as was mentioned above, Diego Renato dos
Santos.  He has chosen to keep his edition of the text in the Public
Domain.

The morphological tags and Strong's numbers on which the present
analysis were based was placed into the Public Domain by Dr. Maurice
A. Robinson.  The few hundred pieces of information which could not be
derived from this information automatically are hereby placed into the
Public Domain by the present editor, Dr. Ulrik Sandborg-Petersen.

Hence, the total work is in the Public Domain. Copy freely for any
purpose, including for commercial or for non-commercial use.

The present editor would, of course, appreciate being notified of any
errors and inconsistencies.  Such notification is best received
through email at the following address:

ulrikp-WRITETHESIGN-emergence dot dk.


Lemmas
======

It is well known that Strong's numbering system is inadequate for
describing the full range of lemmas necessary for an accurate
description of modern editions such as Nestle's 1904 edition.  This is
because Strong's numbering system is incomplete: It only contains the
lemmas that were extant in the Textus Receptus, whereas the full range
of lemmas needed for New Testament lexicography in all editions and
manuscripts is not covered in its totaliy by the Strong's
numbers. 

Some effort has therefore been made to keep the lemmas of this
analysis more correct than the Strong's numbering alone can achieve.


Morphological analysis
======================

The morphological information given corresponds to that used by
Dr. Maurice A. Robinson in all of his morphologically tagged texts.  A
separate, accompanying file describes the tags used.

Two morphological tags are provided: One which is more "functional",
and one which is more "form-oriented".  The differences between the
two only exist in the description of the verbal system.  The
form-oriented system is very careful not to make morphological
distinctions which are not warranted by the form.  For example, the
present indicative does not exhibit any formal characteristics which
allows the distinction between the middle and the passive voice, hence
present indicative verbs are always described as being middle/passive
in the "form-oriented" tag.  The "functional" tag, on the other hand,
sometimes makes a distinction between the middle and the passive, even
in the tenses where this is not formally distinguished by the forms.
This is so as to be sensitive to the semantics of the verb.


Format
======

The format of the file is as follows:

- One (1) line-per-word (one record)
- Seven (7) tab-delimited fields per line.

The seven tab-delimited fields are as follows:

1) Book chapter:verse designation, where the books are the ones
   specified by the OSIS standard.  The format is always
   "OSIS-book-id" followed by a single space (ASCII 0x20), followed by
   a base-10 number designating the chapter, followed by a single
   colon (ASCII 0x3a), followed by a base-10 number designating the
   verse.

2) The Greek text of the word, including any punctuation and/or other
   interpunctuation (such as dashes) preceding or following the word.
   The encoding is Unicode polytonic Greek.  Hopefully, I have not
   made any mistakes in this encoding: No monotonic accents should be
   present.

3) The "functional" morphological tag.

4) The "form-oriented" morphologcal tag.

5) The Strong's number. This has one of two formats: Either a single
   Strong's number in base 10, or two numbers separated by an
   ampersand (ASCII 0x26, i.e., "&"). In the latter case, the first
   number is the Strong's number, and the second number is a so-called
   "Tense Voice Mood" number, or "TVM number".  The TVM number was
   popularized by Dr. Robinson's analyses of various texts, and was
   probably first used in the Online Bible.  The TVM numbers are not
   further described here, and in any case, the morphological tags
   should always be consulted over and above the TVM number.  No
   effort has been made to keep the TVM numbers in sync with the
   morphological tags, nor are TVM numbers always provided for a verb.

6) The lemma.  This should conform to BDAG and/or ANLEX by Friberg,
   Friberg, and Miller.  The encoding is the same as that of field
   (2).

7) An attempt at a "normalized" form of the word.  "Normalized" here
   means:

   a) Punctuation has been removed.

   b) Most accents due to throwback clitics have been eliminated.

   c) Any final grave accent has been made acute when not eliminated
   by (b).

   Note that process (b) is not perfect. It only normalizes words
   which have more than one accent.  A consequence of this is that
   clitics such as MOU will not get the accent removed even when the
   accent is present (e.g., due to a throwback clitic that follows
   it).  Thus field (7) is not totally reliable.

   The encoding is the same as that of field (2).


Release history
===============

Version 1.1:  December 9, 2013: A few tags were fixed for conformance
              to the tag schema.

Version 1.0:  November 13, 2013: Initial release


May the name of the Lord be praised for ever more.


Ulrik Sandborg-Petersen
--
Ulrik Sandborg-Petersen, PhD
Associate Professor, Aalborg University, Denmark
Director, Emergence Consult

ulrikp-WRITETHESIGN-emergence dot dk

