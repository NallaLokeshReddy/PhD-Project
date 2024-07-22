%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is a class for LaTeX2e that should format a report as per
% the IITM Thesis guidelines.  The page layout is set using the
% geometry package.  The double/singlespacing is setup using
% setspace.  Figure captions are set using the hang option of
% caption2.  natbib is used to do the citation using an
% author-year format. I've made an iitm.bst file that formats 
% the references as per the IITM guidelines.
%
% To use this class do the following:
%  \documentclass[options]{iitmdiss} 
%
% Options:
%
%   PhD, MS, MTech or BTech -- generates the appropriate title page
%   and loads the report class.
%
%   synopsis -- Generates the title page for the synopsis.  This also
%   loads the article class instead of the report.
%  
% Example:
%
% \documentclass[PhD,synopsis]{iitmdiss}
% \documentclass[MS]{iitmdiss}
%
% IMPORTANT NOTICE:
% 
%   PLEASE DO NOT MESS WITH THE MARGINS AND GENERAL FORMATTING SETUP
%   IN THIS FILE UNLESS YOU ARE ABSOLUTELY SURE THAT THE FORMAT DOES NOT
%   MATCH WITH THE THESIS GUIDELINES.  FOR EXAMPLE, DO NOT CHANGE THE 
%   MARGINS AND SPACING JUST TO MAKE YOUR THESIS LARGER!
% 
% Notes:
%
%   * I am using as much of the Thesis guidelines for the spacing
%     and margins as I can.
%   * I have used newdiss.cls by R.~K.~Hariram, U.~V.~Ravindra et al. 
%     as a reference and a source for some of the macros.
%   * This class will assume a4paper with 12pt fonts.
%   * I am no TeXpert so feel free to clean up the mess.
%
% Prabhu Ramachandran <prabhu@ae.iitm.ac.in>
% March 2005.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changes:
% ========
%
% - Removed the obsolete ``compat2`` option from the ``geometry`` package.
%
% - Added ``emptypage`` package to disable page numbering in blank pages.
%
% - Added ``twoside`` option to ``article`` (synopsis) and ``report`` (thesis)
%   classes for left-margin adjustment during two-sided printing. Also, you can
%   now use ``\cleardoublepage`` to start a new page on the right hand side.
%
% - Added ``openright`` option to ``report`` (thesis) class to ensure chapters
%   start on the right hand side (odd page numbers)
%
% - Added ``\pagenumbering{gobble}`` to "Title", "Quotation", "Dedication", and
%   "Thesis Certificate" pages to ensure they start on the right hand side (odd
%   page numbers)
%
% - Roman page numbering now starts from the "Acknowledgements" page.
%
% Jithin Jith <j.jith@outlook.com>
% Jan 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{iitmdiss}[2005/03/09 Class for IIT-Madras Dissertations]

\newif\if@PhD
\newif\if@MS
\newif\if@MTech
\newif\if@BTech
\newif\if@Synopsis

\DeclareOption{PhD}{\@PhDtrue}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{MTech}{\@MTechtrue}
\DeclareOption{BTech}{\@BTechtrue}
\DeclareOption{synopsis}{\@Synopsistrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load the correct class.
\if@Synopsis
    \LoadClass[12pt,a4paper,twoside]{report}%{article}
\else
    \LoadClass[12pt,a4paper,twoside,openright]{report}
    %\LoadClass[12pt,a4paper,twoside]{report}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometry and page layout
%\setlength{\textheight}{0.95\textheight}
\RequirePackage[a4paper,
                left=31.7mm,right=31.7mm,top=25.4mm,bottom=34mm, % Change this to make left-right alternate pages
                footskip=17mm, %footskop=34mm touches the bottom of page
                nohead]{geometry}[2002/07/08]
\parskip 8pt

\renewcommand{\@pnumwidth}{2.5em}
%\renewcommand{\@tocrmarg}{2.5em}

\RequirePackage{emptypage} % avoid page numbers in blank pages

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using setspace to do the single/double spacing.  Setspace also
%% makes all tables and figures have single spacing automatically.
\RequirePackage{setspace} 
\RequirePackage{atbeginend} % used to redefine the list environs
\setstretch{1.5}

\BeforeBegin{itemize}{\vspace*{-2ex}}
\AfterEnd{itemize}{}
%\BeforeBegin{itemize}{\vspace*{-5ex}\begin{singlespace}}
%\AfterEnd{itemize}{\end{singlespace}}
%
%\BeforeBegin{enumerate}{\vspace*{-5ex}\begin{singlespace}}
%\AfterEnd{enumerate}{\end{singlespace}}

\BeforeBegin{table}{\vspace{0em}}
\AfterEnd{table}{\vspace*{0em}}

\BeforeBegin{figure}{\vspace*{0em}}
\AfterEnd{figure}{\vspace{0em}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The figure captioning is done correctly via the hang option.
%%\RequirePackage[hang]{caption2}  -> TeX generates error
\RequirePackage[hang]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography
% 
% natbib allows easy switching of citation style and using it along
% with the iitm.bst makes things perfect.
%\RequirePackage[authoryear,round]{natbib} 
\RequirePackage[numbers,square,sort&compress]{natbib} 
%\bibliographystyle{iitm}

\newcommand{\bibstyle@iitm}{\bibpunct{(}{)}{;}{a}{,}{,}%
     \gdef\NAT@biblabel##1{##1. }}
%
\setlength{\bibhang}{0pt}
%\citestyle{iitm}
%\citestyle{unsrt_newen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful macros.  Many of these are modifications from newdiss.cls

% \department{department name} -- user macro to declare name of department.
\def\department#1{\gdef\@department{#1}}

%\RequirePackage[dvips]{graphicx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The title page

\def\maketitle{%
    \if@PhD{
       % \input{titlepage_phd}
		}
    \else{
        \input{titlepage_ms}
    }
    \fi
}

\def\makeinnertitle{%
    \if@PhD{
       % \input{innertitle_phd}
		}
    \else{
        \input{innertitle_ms}
    }
    \fi
}



\if@Synopsis
   \renewcommand\refname{REFERENCES}
\else
   % QUOTATIONS
   %
   \def\quotations{%
       \chapter*{\centerline{QUOTATIONS}}
       \pagenumbering{gobble}
   %\addcontentsline{toc}{chapter}{QUOTATIONS}
   }

   % DEDICATION
   %
   \def\dedication{
       \chapter*{\centerline{DEDICATION}}
       \pagenumbering{gobble}
   %\addcontentsline{toc}{chapter}{DEDICATION}
   }

   % CERTIFICATE
   %
   %   - this produces a certificate page as per IITM Regulations
   %     comment the following lines out to get it working.
   %
   \def\certificate{%% A preliminary chapter
     \cleardoublepage
     \vspace*{36pt}
     \centerline{\Large \bf \underline{THESIS CERTIFICATE}}
     \vskip 1.3cm
     \thispagestyle{empty}
     \typeout{Certificate}
     \pagenumbering{gobble}
   }

     % LIST OF PUBLICATIONS
   %
   \def\listofpublications{%
       \chapter*{\centerline{\underline {LIST OF PUBLICATIONS}}}
       \pagenumbering{roman}
       \setcounter{page}{1} % start page numbering from acknowledgements
       \thispagestyle{empty}
       %\addcontentsline{toc}{chapter}{List of Publications}
   }
   
   % ACKNOWLEDGEMENTS
   %
   \def\acknowledgements{%
       \chapter*{\centerline{ACKNOWLEDGEMENTS}}
       \pagenumbering{roman}
       %\setcounter{page}{1} % start page numbering from acknowledgements
       \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
   }

   % ABSTRACT
   %   - this produces pages suitable for an IITM Abstract
   \def\abstract{%
       \chapter*{\centerline{ABSTRACT}}
       \addcontentsline{toc}{chapter}{ABSTRACT}
   }

   % GLOSSARY
   %
   \def\glossary{
       \chapter*{\centerline{GLOSSARY}}
       \addcontentsline{toc}{chapter}{GLOSSARY}
   }

   % ABBREVIATIONS
   %
   \def\abbreviations{
       \chapter*{\centerline{ABBREVIATIONS}}
       \addcontentsline{toc}{chapter}{ABBREVIATIONS}
   }

   
   % Use the nomencl package for the NOTATION section.

   % Makes the chapter heading
   \def\@makechapterhead#1{%
     {\parindent \z@ \raggedright \normalfont 
     %\vspace*{1.2cm} %change this to adjust the space betweeen top of page and chapter title
       \ifnum \c@secnumdepth >\m@ne
       \begin{center}
         \fontsize{15}{0em}\bfseries \@chapapp\space \thechapter 
       \end{center}
       \par\nobreak
       %\vspace*{-0.7cm} 
       %\vskip 20\p@
       \fi
       \interlinepenalty\@M
       \fontsize{15}{1.25em} \bf
       \begin{center}
         #1\par\nobreak      
       \end{center}
       %\vskip 20\p@
       %\vspace*{-1.2cm} %change this for space between the chapter title and the first line of the chapter
       \thispagestyle{empty}
     }\noindent} 

   % Makes the chapter heading for \chapter* commands
   \def\@makeschapterhead#1{%
     %\vspace*{25\p@}% %this adjusts the space b\w top of page and chapter title in non-chapter pages
     {\parindent \z@ \raggedright
       \normalfont
       \interlinepenalty\@M
       \fontsize{15}{1.25em} \bfseries #1\par\nobreak
       %\vskip 20\p@
     }}

    % to change "chapter" to "appendix" in table of contents
    \def\appendices{%
      \addtocontents{toc}{\protect\renewcommand{\protect\@chapapp}{\appendixname}}%
    }

   %LIST OF PAPERS
   \def\listofpapers{
           \normalbaselines
           \chapter*{\centerline{LIST OF PAPERS BASED ON THESIS}}
   }

   % CV
   \def\CV{\chapter*{\centerline{CURRICULUM VITAE}}}

   % Comittee
   \if@PhD
       \def\committee{\chapter*{\centerline{DOCTORAL COMMITTEE}}}
   \else
       \if@MS
          \def\committee{\chapter*{\centerline{GENERAL TEST COMITTEE}}}
        \fi
   \fi


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Renewed commands to set the titles of various pages correctly.
   %\renewcommand\contentsname{\centering TABLE OF CONTENTS}
   \renewcommand\contentsname{\begin{center}{\large TABLE OF CONTENTS} \end{center} \hfill {\small Page}  \vspace{0cm}}
   \renewcommand\listfigurename{\centering LIST OF FIGURES}
  
   %\renewcommand\listtablename{\centering LIST OF TABLES}
   \renewcommand{\listtablename}{\begin{center} {\large LIST OF TABLES} \end{center} 
   \hspace{0.4cm}\textbf{\normalsize Table} \hfill \textbf{\normalsize Title} \hfill \textbf{\normalsize Page} 
   \vspace{-0.5cm}}
   
   \renewcommand{\chaptername}{CHAPTER}

   \renewcommand\bibname{\centering REFERENCES}
   \renewcommand\appendixname{APPENDIX}
   
   
   %\renewcommand{\chaptermark}[1]{%
    %\markboth{#1}{}}

\fi


