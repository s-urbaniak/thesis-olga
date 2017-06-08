% !TeX encoding = UTF-8

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{agse-thesis}[2017/05/23 v0.1 AGSE Thesis]

%%% Read options
% Language: Default is German
\newcommand{\lang}{ngerman}
\DeclareOption{de}{\renewcommand{\lang}{ngerman}}
\DeclareOption{en}{\renewcommand{\lang}{english}}

% Font family: Default is LaTeX's lmodern
\newcommand{\fonttype}{plain}
\DeclareOption{serif}{     \renewcommand{\fonttype}{serif}}
\DeclareOption{plain}{     \renewcommand{\fonttype}{plain}}
\DeclareOption{sans-serif}{\renewcommand{\fonttype}{sans-serif}}

% Document type: Default is article (twosided)
\newcommand{\baseClass}{article}
\DeclareOption{article}{%
    \renewcommand{\baseClass}{article}
    \PassOptionsToClass{twoside}{article}
}
\DeclareOption{book}{\renewcommand{\baseClass}{book}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseClass}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{\baseClass}

% Load required language
\RequirePackage[\lang]{babel}

\RequirePackage[ngerman=ngerman-x-latest]{hyphsubst}

% Load required font
\RequirePackage{xifthen}
\ifthenelse{\equal{\fonttype}{plain}}{
    \RequirePackage{lmodern}
}{}
\ifthenelse{\equal{\fonttype}{serif}}{
    \RequirePackage[sc]{mathpazo}
    \linespread{1.05}  % Palladio needs more leading (space between lines)
}{}
\ifthenelse{\equal{\fonttype}{sans-serif}}{
    \RequirePackage{paratype}
    \renewcommand*\familydefault{\sfdefault}
}{}
\RequirePackage[T1]{fontenc}

% Allow unicode in input files
\RequirePackage[utf8]{inputenc}
\usepackage[utf8]{inputenc}

% Set layout
\RequirePackage[
  top=2.5cm,
  bottom=2.5cm,
  left=2.5cm,
  right=2.5cm,
]{geometry}

% Header and Footer Style
\pagestyle{plain}

% Display Chapter and Section for book class
\ifthenelse{\equal{\baseClass}{book}}{
    \renewcommand{\chaptermark}[1]{\markboth{%
        \chaptername\ \thechapter.\ #1}{\chaptername\ \thechapter.\ #1}}
}{%
% Display Section and Subsection for article class
    \renewcommand{\sectionmark}[1]{\markboth{%
        \thesection.\ #1}{\thesection.\ #1}}
}

% PDF settings
\usepackage[%
  breaklinks=true,
    pdfstartview=FitH,
    linktocpage,
% two lines below = color links
    colorlinks=true,
    citecolor=blue!20!black!30!green,
% two lines below = don't color links
    %colorlinks=false,
    %pdfborder={0 0 0},
]{hyperref}

% Tables
\usepackage{tabularx}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}

% Misc
\RequirePackage{fancyref}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage{makeidx}

\RequirePackage[pdftex]{graphicx}

%%% BibTeX
% \RequirePackage[numbers,sort&compress]{natbib}
% \RequirePackage[nottoc]{tocbibind}
% \bibliographystyle{plain}

% Java Code Listing Style
\RequirePackage{xcolor}
\RequirePackage{listings}
\definecolor{darkblue}{rgb}{0,0,.6}
\definecolor{darkgreen}{rgb}{0,0.5,0}
\definecolor{darkred}{rgb}{0.5,0,0}
\lstset{%
    language=Java,
    basicstyle=\ttfamily\small\upshape,
    commentstyle=\color{darkgreen}\sffamily,
    keywordstyle=\color{darkblue}\rmfamily\bfseries,
    breaklines=true,
    tabsize=2,
    xleftmargin=3mm,
    xrightmargin=3mm,
    numbers=none,
    frame=single,
    stringstyle=\color{darkred},
    showstringspaces=false
}

% Custom commands
\newcommand\zb{z.\,B.\ }
\renewcommand\dh{d.\,h.\ }
\newcommand{\mailto}[1]{\href{mailto:#1}{#1}}

\RequirePackage{pgfkeys}
\pgfkeys{
    student/id/.estore in = \studentID,
    student/mail/.estore in = \coverpageMail,
    thesis/type/.estore in = \thesisType,
    thesis/type = Bachelorarbeit,
    thesis/date/.estore in = \thesisDate,
    thesis/date = \today,
    thesis/firstAdvisor/.estore in = \firstAdvisor,
    thesis/secondAdvisor/.estore in = \secondAdvisor,
    thesis/examiner/.estore in = \firstExaminer,
    thesis/examiner/2/.estore in = \secondExaminer,
    thesis/group/.estore in = \groupName,
    thesis/group = {Arbeitsgruppe Software Engineering},
    titles/size/.store in = \titleFontSize,
    abstract/separate/.estore in = \separateAbstract,
}

% Define abstract environment for book class
\ifthenelse{\equal{\baseClass}{book}}%
    {\newenvironment{abstract}%
        {\begin{center}\textbf{\small\abstractname}\end{center}\quotation\small}%
        {\endquotation}%
    }{}

% (Re)define frontmatter and mainmatter
\ifthenelse{\equal{\baseClass}{book}}{
    \let\frontmatterOrig\frontmatter
    \renewcommand{\frontmatter}{
        \frontmatterOrig
        \pagestyle{plain}
    }
    \let\mainmatterOrig\mainmatter
    \renewcommand{\mainmatter}{
        \mainmatterOrig
        \pagestyle{plain}
        \setcounter{page}{1}
    }
}{
    \newcommand{\frontmatter}{
        \pagestyle{fancy}
        \pagenumbering{roman}
        \setcounter{page}{1}
    }
    \newcommand{\mainmatter}{
        \pagestyle{fancy}
        \pagenumbering{arabic}
        \setcounter{page}{1}
        \fancyhf{} %alle Kopf- und Fußzeilenfelder bereinigen
        \fancyhead[L]{\textcolor{gray}{Traumapädagogik}} %Kopfzeile links
        \fancyhead[C]{} %zentrierte Kopfzeile
        \fancyhead[R]{\textcolor{gray}{Olga Urbaniak}} %Kopfzeile rechts
        \fancyfoot[C]{\thepage}

        \renewcommand{\headrulewidth}{0.1pt}% 2pt header rule
        \renewcommand{\headrule}{\hbox to\headwidth{%
            \color{gray}\leaders\hrule height \headrulewidth\hfill}}
        \renewcommand{\footrulewidth}{0pt}% No footer rule
    }
}

\newcommand{\hang}{
  \hangindent=2em
  \hangafter=1
}

\RequirePackage{xstring}
\RequirePackage{etoolbox}
\newcommand{\coverpage}[2][]{
    \pgfkeys{#1}
    \pagestyle{empty}

    \begin{center}
        \LARGE
        \textbf{Freie Universität Berlin}

        \vspace{4mm}

        \normalsize

        Fachbereich Erziehungswissenschaft und Psychologie \\
        Bildungs- und Erziehungswissenschaft \\
        (Bachelor of Arts)

        \vspace{2mm}

        \ifcsdef{separateAbstract}{\vspace{25mm}}{\vspace{13mm}}

        \ifcsdef{titleFontSize}{}{%
            \StrLen{\thesisTitle}[\titleLength]
            \ifthenelse{\titleLength > 100}{%
                \let\titleFontSize\LARGE
            }{%
                \let\titleFontSize\huge
            }
        }
        \titleFontSize\thesisTitle

        \vspace{2mm}

        \Large
        \thesisSubtitle

    \end{center}

    \vspace{10mm}

    \firstAdvisor

    \secondAdvisor

    \begin{center}

        \ifcsdef{separateAbstract}{\vfill}{\vspace{13mm}}

        \vspace{4mm}

        \begin{tabular}{rl}
          Vorgelegt von: & \studentName \\
          & Landshuter Str. 7a \\
          & 10779 Berlin \\
          & Tel.: 030 - 787 151 30 \\
          & \mailto{\coverpageMail} \\
          \\
          Matrikel-Nr.: & 4802822 \\
          \\
          W\"orter im Textteil: & xxx \\
        \end{tabular}

        \vspace{2cm}

        Berlin, \thesisDate
    \end{center}
}
