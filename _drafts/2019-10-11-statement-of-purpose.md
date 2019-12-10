---
title: Statement of Purpose
description: New blog post.
header: Statement of Purpose
duration: 1 minute read
---

&nbsp;

Manning [Computational Linguistics and Deep Learning](https://nlp.stanford.edu/manning/papers/Manning-Last-Words-COLI_a_00239.pdf)

### Statement of Purpose

Understanding natural language is a skill that everyone reading this sentence
has perfected at least to some extent, but how hard it is to make a machine
show a comparable level of proficiency. We are probably very far from
being able to claim that a machine truly "understands" any human language, nevertheless
a tremendous amount of effort by the computational linguistics community has led 
to significant improvements in concrete tasks such as information extraction and
question answering.

The field of computational linguistics is becoming increasingly relevant as
the amount of data generated in almost every imaginable human endeavor increases at 
an accelerating pace. To tame this colossal flood of textual data we make
use of increasingly sophisticated neural network architectures and
word embeddings trained in massive clusters to achieve state of the art sequence
labeling, machine translation and textual entailment. Despite the truly beautiful 
innovations in deep learning for computational linguistics the great surge of complexity 
is many times followed only by modest gains in performance. We must turn to the more
fundamental questions in the field to understand how the language structure and
the text organization can leverage the potential of state of the art machine learning.

I intend to pursue a PhD in Computational Linguistics to investigate these and other
questions that have been fueling my research dedication in the past few years. 
To reveal my background and aspirations in this field of study,
I provide a summary of the research I've been doing during my master's studies.

During my Master’s study I have worked extensively in Natural Language Processing, especially
in the task of named entity recognition, disambiguation and relation extraction in the Web. 
However, my research actually began with the quantitative analysis of scientific production.

The quantitative analysis of scientific production most often relies almost exclusively
on citation counts. This is problematic for mainly three reasons. First, the number of
citations is not necessarily a measure of scientific quality because citations from
every venue have the same weight. Second, citations take a long
time to happen, what prevents the short term analysis of the scientific impact of recent
discoveries. Second, citation data is hard to acquire. There are multiple citation databases
and many times they either contain conflicting or incomplete data. Also, this information is
often not public.

For this reason, together with fellow researchers in UFMG I introduced a graph based
index to rank venues, researchers and departments in the field of computer science
called P-score based on Markov Chains. A paper 
named "P-score: a reputation bibliographic index that complements citation counts"
discussing this index and its relation to citation counts was published in Scientometrics.
P-score is a graph based index that does not rely on citation counts nad it can either
replace the more cumbersome citation based indices or complement the pure citation
analysis.

P-score relies on a reference set of researchers, venues or departments to attribute 
reputations to the remaining entities in the graph. I wanted to conduct a 
time series analysis of department reputations and research interests using P-score
but I faced a challenge. Although the field of Computer Science has many wonderful
resources of academic production such as DBLP and MAG, the affiliation data is often
missing or wrong in the data records, what prevents further analysis. 
There are more than two million researchers listed in DBLP and even among the most
productive roughly half the records are missing affiliation information. And even
when this information exists, a department can have multiple names.

At first, I collected this data manually from university webpages but this work quickly 
became tedious and cumbersome what led me to explore automatic methods. Constructing
wrappers page by page was hardly quicker than collecting the data manually, so I turned
to machine learning methods of information extraction. And this temporary shift in 
research goal led to an increasing passion for NLP and a dissertation titled 
"Named Entity Recognition on the Web". 

The automatic extraction of affiliation data with machine learning presented two
challenges: 
First, most of the time, the text found in web pages is very different from plain text, 
because the HTML structure is important and sentences are usually too short to provide 
adequate context for conventional NER approaches to work properly. 
Second, training specific models for each language would certainly become as cumbersome
as building wrappers.

I constructed a dataset (publicly available) with webpage samples from multiple countries 
in proportion to the academic community in that country and trained the 
multilanguage models comparing their performances. By modelling the affiliation extraction problem
as a NER problem we could use HMMs, CRFs or the more modern Bi-LSTM-CRF to label
named entities (researchers) across all university webpages in multiple languages.
During the experiments I learned that by making use of the text structure and in this case the HTML 
structure we could boost model performance significantly.
That is, most websites present a regular organization, so named entities tend to occur 
in similar HTML contexts. By comparing these contexts while atributing labels to tokens, 
we can exploit these patterns to improve the accuracy when the classes are not obvious from
the text alone. To achieve this improvement I added an attention layer at the output of the
Bi-LSTM to compare token representations according to their HTML contexts. This shows
the potential to exploit regular structures in the text to boost the performance
of sequence models. Though, in this case, it comes at the expense of further complexity.

The results of this research are being used to complement the existing affiliation 
database in www.pscore.com.br. The insights acquired doing this research lead me to
think that granting neural networks the ability to exploit text structure by building
some of these structures in the architecture can lead us closer to answering 
interesting linguistic questions.

Stanford's program has captured my attention because of the outstanding faculty
of the Natural Language Processing Group and the presence of members from both 
the Linguistics Department and the Computer Science Department.
The book "Foundations of Statistical Natural Language Processing" by 
Prof. Christopher Manning has been a terrific introduction to the field of NLP, and more 
than often I catch myself looking for answers in this material and the online lectures 
by Prof. Dan Jurafsky.
The speech by Prof. Manning in the 2015 ACL "Computational Linguistics and Deep Learning" 
is a splendid source of motivation that captures many of my own sentiments toward
the future of research in NLP. I would be honored to participate in this group
learning with the more experienced members and also providing new ideas.

# However, taking in consideration the general task of
# Information Extraction, it is hardly achievable to build a specific dataset for each
# extraction task. There comes the paradigm of Open Information Extraction, but the 
# existing solutions are too noisy to be useful in most concrete applications. 


Some quotes:

“The next big step for Deep Learning is natural language understanding, which aims to 
give machines the power to understand not just individual words but entire sentences 
and paragraphs.”

“The next big step for Deep Learning is natural language understanding, which 
aims to give machines the power to understand not just individual words but 
entire sentences and paragraphs.”

"I encourage people to not get into the rut of doing no more than using 
word vectors to make performance go up a couple of percent."

"The future is bright. However, I would encourage everyone to think about 
problems, architectures, cognitive science, and the details of human language, 
how it is learned, processed, and how it changes, rather than just chasing 
state-of-the-art numbers on a benchmark task"

-----------


What are currently the main conferences in NLP?

**(All venues)[OPhttps://www.aclweb.org/anthology/]**

Conferences:
* [Association for Computational Linguistics (ACL)](https://www.aclweb.org/anthology/venues/acl/)
* [Conference on Computational Natural Language Learning (CoNLL)](https://www.aclweb.org/anthology/venues/conll/)
* [European Chapter of the Association for Computational Linguistics (EACL)](https://www.aclweb.org/anthology/venues/eacl/)
* [Conference on Empirical Methods in Natural Language Processing (EMNLP)](https://www.aclweb.org/anthology/venues/emnlp/)
* [North American Chapter of the Association for Computational Linguistics (NAACL)](https://www.aclweb.org/anthology/venues/naacl/)
* [Lexical and Computational Semantics and Semantic Evaluation (\*SEMEVAL)](https://www.aclweb.org/anthology/venues/semeval/)
* [Transactions of the Association for Computational Linguistics (TACL)](https://www.aclweb.org/anthology/venues/tacl/)

Special interest groups:
* [Special Interest Group for Annotation (SIGANN)](https://www.aclweb.org/anthology/sigs/sigann/)
* [Special Interest Group on Biomedical Natural Language Processing (SIGBIOMED)](https://www.aclweb.org/anthology/sigs/sigbiomed/)
* [Special Interest Group on Linguistic data and corpus-based approaches to NLP (SIGDAT)](https://www.aclweb.org/anthology/sigs/sigdat/)
* [Special Interest Group on Natural Language Learning (SIGNLL)](https://www.aclweb.org/anthology/sigs/signll/)S
* [Special Interest Group on Computational Morphology and Phonology (SIGMORPHON)](https://www.aclweb.org/anthology/sigs/sigmorphon/)
* [Special Interest Group for Machine Translation (SIGMT)](https://www.aclweb.org/anthology/sigs/sigmt/)
* [Association for Mathematics of Language (SIGMOL)](https://www.aclweb.org/anthology/sigs/sigmol/)
* [Special Interest Group on the Lexicon (SIGLEX)](https://www.aclweb.org/anthology/sigs/siglex/)

Journals:
* [Computational Linguistics (CL)](https://www.aclweb.org/anthology/venues/cl/)
* [Natural Language Engineering (NLE)](https://www.cambridge.org/core/journals/natural-language-engineering)





What are the main researchers?

* [Authors in P-score](http://www.pscore.com.br/area/1/?area=1&model=P-score&year=1940,2020&ds=0.5&top_authors=200&refvenues=3769,1639,1788,4398,4709,5368&count=300#authors)

1. Hermann Ney:
  Affiliation: RWTH Aachen University, Germany
  Fields: Machine Translation, Speech Recognition
  Interesting works: Neural Hidden Markov Model for Machine Translation.

2. Shrikanth S. Narayanan
  Affiliation: University of Southern California, Los Angeles, USA
  Fields: Speech Recognition

3. Christopher D. Manning
  Affiliation: Stanford
  Fields: Question Answering, Natural Language Understanding, Text Summarization, Relation Extraction, NE Disambiguation

4. Eduard H. Hovy
  Carnegie Mellon University
  Fields: Sentiment Analysis, Proposition Extraction, NER, Interpretable Embeddings, Textual Entailment, Translation

5. Noah A. Smith
  University of Washington
  Book: Linguistic Structure Prediction
  Embeddings

6. Dan Klein
  Berkeley 
  Unsupervised language acquisition, Machine translation, Efficient algorithms for NLP, Information extraction

- Haizhou Li
- Dan Roth
- Kevin Knight
- Alex Waibel
- Iryna Gurevych
- Chris Dyer
- Mirella Lapata
- Eiichiro Sumita
- Qun Liu
- Ido Dagan
- Graham Neubig
- Jun'ichi Tsujii
- John H. L. Hansen
- Heng Ji
- Yuji Matsumoto
- Ming Zhou
- Daniel Jurafsky
- Kathy McKeown
- Hinrich Schütze
- Satoshi Nakamura
- Mari Ostendorf
- Trevor Cohn
- Timothy Baldwin
- Min Zhang
- Rada Mihalcea
- Ting Liu
- Pushpak Bhattacharyya
- Regina Barzilay
- Jim Glass
- Guodong Zhou
- Hwee Tou Ng
- Chris Callison-Burch
- Jianfeng Gao
- Yue Zhang
- Benjamin Van Durme
- Alessandro Moschitti
- Richard M. Schwartz
- Ralph Grishman
- Luke S. Zettlemoyer
- Maosong Sun
- Claire Cardie
- Martha Palmer
- Chin-Hui Lee
- Sadao Kurohashi
- Jason Eisner
- Owen Rambow
- Anders Søgaard
- Julia Hirschberg
- Mark Johnson
- Philip Resnik
- Masaaki Nagata
- Alan W. Black
- Dragomir R. Radev
- Yusuke Miyao
- Keikichi Hirose
- Vincent Ng
- Mark J. F. Gales
- Marilyn A. Walker
- Diane J. Litman
- Yang Liu
- Daniel Gildea
- Tatsuya Kawahara
- Andrew McCallum
- Xiaojun Wan
- Yejin Choi
- Philipp Koehn
- Xuanjing Huang
- Nizar Habash
- Bo Xu
- Hal Daumé III
- Lin-Shan Lee
- Mark Dredze
- Aravind K. Joshi
- Kiyohiro Shikano
- Jun Zhao
- Tanja Schultz
- Mohit Bansal
- Eugene Charniak
- Michael Collins
- Chin-Yew Lin
- Stephan Vogel
- Stephen Clark
- Zhiyuan Liu
- Jordan L. Boyd-Graber
- Björn W. Schuller
- Eneko Agirre
- Stephanie Seneff
- Li Deng
- Chengqing Zong
- Daniel Marcu
- Hervé Bourlard
- Alex Acero
- William Yang Wang
- Hitoshi Isahara

I am a computer scientist in the field of NLP.


**What does a computer scientist in the field of NLP do?**

Make a computer understand human language.

[Understanding Human Language: Can NLP and Deep Learning Help?](https://dl.acm.org/citation.cfm?id=2926732&dl=ACM&coll=DL)


What is the purpose of the computer scientist?

What is the purpose of the scientist?

What is the purpose of NLP?

What are the big questions in NLP?

Who are the names in NLP?

Why P-score was important?

What was the motivation behind my master's dissertation?

What did I learn doing my dissertation?

And what now? What is the expected future work? What is my motivation to keep researching?

Why is open information extraction important?

Who are the big names in OIE?

What do I intend to do to advance the field of OIE?

What the world gains with that?

What does Stanford gain with that?

